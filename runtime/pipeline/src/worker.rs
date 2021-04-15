use crate::ports::{NodeReceivers, NodeSenders};
use crate::PipelineContext;
use mizer_clock::ClockFrame;
use mizer_node::*;
use mizer_ports::PortValue;
use mizer_processing::Injector;
use mizer_protocol_laser::LaserFrame;
use std::any::Any;
use std::cmp::Ordering;
use std::collections::HashMap;

pub trait ProcessingNodeExt: PipelineNode {
    fn process(&self, context: &PipelineContext, state: &mut Box<dyn Any>) -> anyhow::Result<()>;
}

impl<T, S: 'static> ProcessingNodeExt for T
where
    T: ProcessingNode<State = S>,
{
    fn process(&self, context: &PipelineContext, state: &mut Box<dyn Any>) -> anyhow::Result<()> {
        if let Some(state) = state.downcast_mut() {
            self.process(context, state)
        } else {
            unreachable!()
        }
    }
}

#[derive(Default)]
pub struct PipelineWorker {
    states: HashMap<NodePath, Box<dyn Any>>,
    senders: HashMap<NodePath, NodeSenders>,
    receivers: HashMap<NodePath, NodeReceivers>,
    dependencies: HashMap<NodePath, Vec<NodePath>>,
}

impl PipelineWorker {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn register_node<T: 'static + ProcessingNode<State = S>, S: 'static>(
        &mut self,
        path: NodePath,
        node: &T,
    ) {
        let state = node.create_state();
        let state: Box<S> = Box::new(state);
        self.states.insert(path.clone(), state);
        let mut receivers = NodeReceivers::default();
        for (port_id, metadata) in node.list_ports() {
            if metadata.is_input() {
                log::debug!("Registering port receiver for {:?} {:?}", &path, &port_id);
                match metadata.port_type {
                    PortType::Single => receivers.register::<f64>(port_id, metadata),
                    PortType::Multi => receivers.register::<Vec<f64>>(port_id, metadata),
                    PortType::Laser => receivers.register::<Vec<LaserFrame>>(port_id, metadata),
                    _ => {}
                }
            }
        }
        self.receivers.insert(path, receivers);
    }

    pub fn connect_nodes(
        &mut self,
        link: NodeLink,
        source_meta: PortMetadata,
        target_meta: PortMetadata,
    ) -> anyhow::Result<()> {
        self.add_dependency(link.source.clone(), link.target.clone());
        self.connect_ports(link, source_meta, target_meta)?;

        Ok(())
    }

    fn add_dependency(&mut self, node: NodePath, dependency: NodePath) {
        if let Some(dependencies) = self.dependencies.get_mut(&node) {
            dependencies.push(dependency);
        } else {
            self.dependencies.insert(node, vec![dependency]);
        }
    }

    fn connect_ports(
        &mut self,
        link: NodeLink,
        source_meta: PortMetadata,
        target_meta: PortMetadata,
    ) -> anyhow::Result<()> {
        match link.port_type {
            PortType::Single => self.connect_memory_ports::<f64>(link, source_meta, target_meta),
            PortType::Color => self.connect_memory_ports::<Color>(link, source_meta, target_meta),
            PortType::Multi => {
                self.connect_memory_ports::<Vec<f64>>(link, source_meta, target_meta)
            }
            PortType::Laser => {
                self.connect_memory_ports::<Vec<LaserFrame>>(link, source_meta, target_meta)
            }
            PortType::Gstreamer => self.connect_gst_ports(link)?,
            _ => unimplemented!(),
        }
        Ok(())
    }

    fn connect_memory_ports<V: PortValue + Default + 'static>(
        &mut self,
        link: NodeLink,
        source_meta: PortMetadata,
        target_meta: PortMetadata,
    ) {
        let (tx, rx) = mizer_ports::memory::channel::<V>();
        if !self.senders.contains_key(&link.source) {
            self.senders
                .insert(link.source.clone(), NodeSenders::default());
        }
        if let Some(senders) = self.senders.get_mut(&link.source) {
            senders.add(link.source_port, tx, target_meta);
        }
        if !self.receivers.contains_key(&link.target) {
            self.receivers
                .insert(link.target.clone(), NodeReceivers::default());
        }
        if let Some(receivers) = self.receivers.get_mut(&link.target) {
            receivers.add(link.target_port, rx, source_meta);
        }
    }

    fn connect_gst_ports(&self, link: NodeLink) -> anyhow::Result<()> {
        let source = self.states.get(&link.source).expect("invalid source path");
        let target = self.states.get(&link.target).expect("invalid target path");

        let gst_source = self.get_gst_node(source);
        let gst_target = self.get_gst_node(target);

        gst_source.link_to(gst_target)?;

        Ok(())
    }

    fn get_gst_node<'a>(&self, node: &'a Box<dyn Any>) -> &'a dyn mizer_video_nodes::GstreamerNode {
        use mizer_video_nodes::*;

        if let Some(node) = node.downcast_ref::<VideoColorBalanceState>() {
            node as &dyn GstreamerNode
        } else if let Some(node) = node.downcast_ref::<VideoOutputState>() {
            node as &dyn GstreamerNode
        } else if let Some(node) = node.downcast_ref::<VideoEffectState>() {
            node as &dyn GstreamerNode
        } else if let Some(node) = node.downcast_ref::<VideoTransformState>() {
            node as &dyn GstreamerNode
        } else if let Some(node) = node.downcast_ref::<VideoFileState>() {
            node as &dyn GstreamerNode
        } else {
            unreachable!()
        }
    }

    pub fn process<'a>(
        &mut self,
        mut nodes: Vec<(&'a NodePath, &'a Box<dyn ProcessingNodeExt>)>,
        frame: ClockFrame,
        injector: &Injector,
    ) {
        self.order_nodes_by_dependencies(&mut nodes);
        self.process_nodes(&mut nodes, frame, &injector)
    }

    fn order_nodes_by_dependencies(
        &mut self,
        nodes: &mut Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
    ) {
        nodes.sort_by(|(left, _), (right, _)| {
            let left_deps = self.dependencies.get(left).cloned().unwrap_or_default();
            let right_deps = self.dependencies.get(right).cloned().unwrap_or_default();

            if left_deps.contains(&right) {
                Ordering::Less
            } else if right_deps.contains(&left) {
                Ordering::Greater
            } else {
                Ordering::Equal
            }
        });
    }

    fn process_nodes(
        &mut self,
        nodes: &mut Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
        frame: ClockFrame,
        injector: &Injector,
    ) {
        for (path, node) in nodes {
            let context = PipelineContext {
                frame,
                injector,
                receivers: self.receivers.get(path),
                senders: self.senders.get(path),
            };
            let state = self.states.get_mut(path);
            let state = state.unwrap();
            if let Err(e) = node.process(&context, state) {
                println!("processing of node failed: {:?}", e)
            }
        }
    }

    pub fn get_state<S: 'static>(&self, path: &NodePath) -> Option<&S> {
        self.states.get(path).and_then(|state| state.downcast_ref())
    }

    pub fn write_port<V: PortValue + 'static>(&mut self, path: NodePath, port: PortId, value: V) {
        if let Some(receivers) = self.receivers.get_mut(&path) {
            if let Some(receiver) = receivers.get(&port) {
                receiver.set_value(value);
            }else {
                log::warn!("trying to write value to unknown port {:?} on path {:?}", &port, &path);
            }
        }else {
            log::warn!("trying to write value to unknown receiver for node {:?}", &path);
        }
    }
}
