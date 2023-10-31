use std::any::{type_name, Any};
use std::cell::RefCell;
use std::cmp::Ordering;
use std::collections::HashMap;
use std::ops::Deref;
use std::sync::Arc;

use downcast::*;
use pinboard::NonEmptyPinboard;

use mizer_clock::Clock;
use mizer_debug_ui_impl::{DebugUi, DebugUiImpl};
use mizer_node::*;
use mizer_nodes::NodeDowncast;
use mizer_ports::memory::MemorySender;
use mizer_ports::PortValue;
use mizer_processing::{DebugUiDrawHandle, ProcessingContext};
use mizer_protocol_laser::LaserFrame;
use mizer_util::{HashMapExtension, StructuredData};
use mizer_wgpu::TextureHandle;

use crate::ports::{NodeReceivers, NodeSenders};
use crate::{NodeMetadata, NodePreviewState, PipelineContext};

pub trait ProcessingNodeExt: PipelineNode {
    fn pre_process(
        &self,
        context: &PipelineContext,
        state: &mut Box<dyn Any>,
    ) -> anyhow::Result<()>;
    fn process(&self, context: &PipelineContext, state: &mut Box<dyn Any>) -> anyhow::Result<()>;
    fn post_process(
        &self,
        context: &PipelineContext,
        state: &mut Box<dyn Any>,
    ) -> anyhow::Result<()>;

    fn debug_ui(&self, ui: &mut <DebugUiImpl as DebugUi>::DrawHandle<'_>, state: &Box<dyn Any>);

    fn as_pipeline_node_mut(&mut self) -> &mut dyn PipelineNode;
}

downcast!(dyn ProcessingNodeExt);

impl<T, S: 'static> ProcessingNodeExt for T
where
    T: ProcessingNode<State = S>,
{
    fn pre_process(
        &self,
        context: &PipelineContext,
        state: &mut Box<dyn Any>,
    ) -> anyhow::Result<()> {
        if let Some(state) = state.downcast_mut() {
            self.pre_process(context, state)
        } else {
            unreachable!()
        }
    }

    fn process(&self, context: &PipelineContext, state: &mut Box<dyn Any>) -> anyhow::Result<()> {
        if let Some(state) = state.downcast_mut() {
            self.process(context, state)
        } else {
            unreachable!()
        }
    }

    fn post_process(
        &self,
        context: &PipelineContext,
        state: &mut Box<dyn Any>,
    ) -> anyhow::Result<()> {
        if let Some(state) = state.downcast_mut() {
            self.post_process(context, state)
        } else {
            unreachable!()
        }
    }

    fn debug_ui(&self, ui: &mut <DebugUiImpl as DebugUi>::DrawHandle<'_>, state: &Box<dyn Any>) {
        if let Some(state) = state.downcast_ref() {
            self.debug_ui(ui, state)
        } else {
            unreachable!()
        }
    }

    fn as_pipeline_node_mut(&mut self) -> &mut dyn PipelineNode {
        self
    }
}

impl NodeDowncast for Box<dyn ProcessingNodeExt> {
    fn node_type(&self) -> NodeType {
        let node: &dyn ProcessingNodeExt = self.deref();
        PipelineNode::node_type(node)
    }

    fn downcast_node<T: Clone + 'static>(&self, _: NodeType) -> Option<T> {
        self.downcast_ref().ok().cloned()
    }
}

pub struct PipelineWorker {
    states: HashMap<NodePath, Box<dyn Any>>,
    senders: HashMap<NodePath, NodeSenders>,
    receivers: HashMap<NodePath, NodeReceivers>,
    dependencies: HashMap<NodePath, Vec<NodePath>>,
    previews: HashMap<NodePath, NodePreviewState>,
    node_metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>,
    _node_metadata: HashMap<NodePath, NodeMetadata>,
}

impl std::fmt::Debug for PipelineWorker {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("PipelineWorker")
            .field("senders", &self.senders)
            .field("receivers", &self.receivers)
            .field("dependencies", &self.dependencies)
            .field("previews", &self.previews)
            .field("port_metadata", &self.node_metadata)
            .finish()
    }
}

impl PipelineWorker {
    pub fn new(node_metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>) -> Self {
        Self {
            states: Default::default(),
            senders: Default::default(),
            receivers: Default::default(),
            dependencies: Default::default(),
            previews: Default::default(),
            node_metadata,
            _node_metadata: Default::default(),
        }
    }

    pub fn register_node<T: 'static + ProcessingNode<State = S>, S: 'static>(
        &mut self,
        path: NodePath,
        node: &T,
    ) {
        log::debug!("register_node {:?} ({:?})", path, node);
        let state = node.create_state();
        match mizer_node::ProcessingNode::details(node).preview_type {
            PreviewType::History => {
                self.previews.insert(
                    path.clone(),
                    NodePreviewState::History(
                        Default::default(),
                        NonEmptyPinboard::new(Vec::new()).into(),
                    ),
                );
            }
            PreviewType::Data => {
                self.previews.insert(
                    path.clone(),
                    NodePreviewState::Data(NonEmptyPinboard::new(None).into()),
                );
            }
            PreviewType::Color => {
                self.previews.insert(
                    path.clone(),
                    NodePreviewState::Color(NonEmptyPinboard::new(None).into()),
                );
            }
            PreviewType::Timecode => {
                self.previews.insert(
                    path.clone(),
                    NodePreviewState::Timecode(NonEmptyPinboard::new(None).into()),
                );
            }
            _ => {
                self.previews.insert(path.clone(), NodePreviewState::None);
            }
        }
        let state: Box<S> = Box::new(state);
        self.states.insert(path.clone(), state);
        let mut receivers = NodeReceivers::default();
        for (port_id, metadata) in node.list_ports() {
            if metadata.is_input() {
                register_receiver(&mut receivers, &path, port_id, metadata);
            }
        }
        self.receivers.insert(path, receivers);
    }

    pub fn remove_node(&mut self, path: &NodePath, links: &[NodeLink]) {
        log::debug!("remove_node {path:?} and links {links:?}");
        self.disconnect_ports(links);
        self.states.remove(path);
        self.receivers.remove(path);
        self.senders.remove(path);
        self.previews.remove(path);
        self.dependencies.remove(path);
    }

    pub fn rename_node(&mut self, from: NodePath, to: NodePath) -> anyhow::Result<()> {
        self.states
            .rename_key(&from, to.clone())
            .then_some(())
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", from))?;
        self.receivers.rename_key(&from, to.clone());
        self.senders.rename_key(&from, to.clone());
        self.previews.rename_key(&from, to.clone());
        self.dependencies.rename_key(&from, to.clone());

        for (_, dependencies) in self.dependencies.iter_mut() {
            for path in dependencies.iter_mut() {
                if path == &from {
                    *path = to.clone();
                }
            }
        }

        Ok(())
    }

    #[tracing::instrument(err, skip(self))]
    pub fn connect_nodes(
        &mut self,
        link: NodeLink,
        source_meta: PortMetadata,
        target_meta: PortMetadata,
    ) -> anyhow::Result<()> {
        tracing::trace!("Connect nodes");
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
            PortType::Clock => self.connect_memory_ports::<u64>(link, source_meta, target_meta),
            PortType::Color => self.connect_memory_ports::<Color>(link, source_meta, target_meta),
            PortType::Multi => {
                self.connect_memory_ports::<Vec<f64>>(link, source_meta, target_meta)
            }
            PortType::Laser => {
                self.connect_memory_ports::<Vec<LaserFrame>>(link, source_meta, target_meta)
            }
            PortType::Data => {
                self.connect_memory_ports::<StructuredData>(link, source_meta, target_meta)
            }
            PortType::Texture => {
                self.connect_memory_ports::<TextureHandle>(link, source_meta, target_meta)
            }
            _ => todo!(),
        }
        Ok(())
    }

    fn disconnect_ports(&mut self, links: &[NodeLink]) {
        for link in links {
            self.disconnect_port(link);
        }
    }

    pub fn disconnect_port(&mut self, link: &NodeLink) {
        match link.port_type {
            PortType::Single => self.disconnect_memory_ports::<f64>(link),
            PortType::Clock => self.disconnect_memory_ports::<u64>(link),
            PortType::Color => self.disconnect_memory_ports::<Color>(link),
            PortType::Multi => self.disconnect_memory_ports::<Vec<f64>>(link),
            PortType::Laser => self.disconnect_memory_ports::<Vec<LaserFrame>>(link),
            PortType::Data => self.disconnect_memory_ports::<StructuredData>(link),
            PortType::Texture => self.disconnect_memory_ports::<TextureHandle>(link),
            _ => unimplemented!(),
        }
    }

    fn connect_memory_ports<V: PortValue + Default + 'static>(
        &mut self,
        link: NodeLink,
        source_meta: PortMetadata,
        target_meta: PortMetadata,
    ) {
        let value_name = type_name::<V>();
        tracing::trace!(value = value_name, "connect_memory_ports");
        let senders = self
            .senders
            .entry(link.source.clone())
            .or_insert_with(NodeSenders::default);
        let rx = if let Some((port, _)) = senders.get(&link.source_port) {
            let port = port
                .downcast_ref::<MemorySender<V>>()
                .expect("port is not a memory port");

            // TODO: this may cause problems with ports reading the target metadata
            port.add_destination()
        } else {
            let (tx, rx) = mizer_ports::memory::channel::<V>();
            senders.add(link.source_port.clone(), tx, target_meta);

            rx
        };
        let receivers = self
            .receivers
            .entry(link.target)
            .or_insert_with(NodeReceivers::default);
        receivers.add(
            link.target_port,
            rx,
            (link.source, link.source_port),
            source_meta,
        );
    }

    fn disconnect_memory_ports<V: PortValue + Default + 'static>(&mut self, link: &NodeLink) {
        if let Some(receivers) = self.receivers.get_mut(&link.target) {
            receivers.remove::<V>(
                &link.target_port,
                (link.source.clone(), link.source_port.clone()),
            );
        }
    }

    pub fn pre_process<'a>(
        &mut self,
        mut nodes: Vec<(&'a NodePath, &'a Box<dyn ProcessingNodeExt>)>,
        context: &impl ProcessingContext,
        clock: &mut impl Clock,
    ) {
        profiling::scope!("PipelineWorker::pre_process");
        self.check_node_receivers(&nodes);
        self.order_nodes_by_dependencies(&mut nodes);
        self.pre_process_nodes(&mut nodes, clock, context);
    }

    pub fn process<'a>(
        &mut self,
        mut nodes: Vec<(&'a NodePath, &'a Box<dyn ProcessingNodeExt>)>,
        context: &impl ProcessingContext,
        clock: &mut impl Clock,
    ) {
        profiling::scope!("PipelineWorker::process");
        self.check_node_receivers(&nodes);
        self.order_nodes_by_dependencies(&mut nodes);
        self.process_nodes(&mut nodes, clock, context);
    }

    pub fn post_process<'a>(
        &mut self,
        mut nodes: Vec<(&'a NodePath, &'a Box<dyn ProcessingNodeExt>)>,
        context: &impl ProcessingContext,
        clock: &mut impl Clock,
    ) {
        profiling::scope!("PipelineWorker::post_process");
        self.check_node_receivers(&nodes);
        self.order_nodes_by_dependencies(&mut nodes);
        self.post_process_nodes(&mut nodes, clock, context);
    }

    fn check_node_receivers(&mut self, nodes: &[(&NodePath, &Box<dyn ProcessingNodeExt>)]) {
        for (path, node) in nodes {
            let receivers = self.receivers.entry((*path).clone()).or_default();
            for (port_id, metadata) in node.list_ports() {
                if !metadata.is_input() {
                    continue;
                }
                if let Some(port_receiver) = receivers.get_mut(&port_id) {
                    if port_receiver.metadata.port_type == metadata.port_type {
                        continue;
                    }
                    register_receiver(receivers, path, port_id, metadata);
                } else {
                    register_receiver(receivers, path, port_id, metadata);
                }
            }
        }
    }

    fn order_nodes_by_dependencies(
        &mut self,
        nodes: &mut Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
    ) {
        profiling::scope!("PipelineWorker::order_nodes_by_dependencies");
        nodes.sort_by(|(left, _), (right, _)| {
            let left_deps = self.dependencies.get(left).cloned().unwrap_or_default();
            let right_deps = self.dependencies.get(right).cloned().unwrap_or_default();

            if left_deps.contains(right) {
                Ordering::Less
            } else if right_deps.contains(left) {
                Ordering::Greater
            } else {
                Ordering::Equal
            }
        });
    }

    fn pre_process_nodes(
        &mut self,
        nodes: &mut Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
        clock: &mut impl Clock,
        processing_context: &impl ProcessingContext,
    ) {
        profiling::scope!("PipelineWorker::pre_process_nodes");
        let mut node_metadata = HashMap::default();
        for (path, node) in nodes {
            let (context, state) =
                self.get_context(path, processing_context, clock, &mut node_metadata);
            let _scope = format!("{:?}Node::pre_process", node.node_type());
            profiling::scope!(&_scope);
            if let Err(e) = node.pre_process(&context, state) {
                log::error!("pre processing of node {} failed: {:?}", &path, e)
            }
        }
        self._node_metadata = node_metadata;
    }

    fn process_nodes(
        &mut self,
        nodes: &mut Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
        clock: &mut impl Clock,
        processing_context: &impl ProcessingContext,
    ) {
        profiling::scope!("PipelineWorker::process_nodes");
        let mut node_metadata = self._node_metadata.clone();
        for (path, node) in nodes {
            let (context, state) =
                self.get_context(path, processing_context, clock, &mut node_metadata);
            let _scope = format!("{:?}Node::process", node.node_type());
            profiling::scope!(&_scope);
            if let Err(e) = node.process(&context, state) {
                log::error!("processing of node {} failed: {:?}", &path, e)
            }
        }
        self._node_metadata = node_metadata;
    }

    fn post_process_nodes(
        &mut self,
        nodes: &mut Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
        clock: &mut impl Clock,
        processing_context: &impl ProcessingContext,
    ) {
        profiling::scope!("PipelineWorker::post_process_nodes");
        let mut node_metadata = self._node_metadata.clone();
        for (path, node) in nodes {
            let (context, state) =
                self.get_context(path, processing_context, clock, &mut node_metadata);
            let _scope = format!("{:?}Node::post_process", node.node_type());
            profiling::scope!(&_scope);
            if let Err(e) = node.post_process(&context, state) {
                log::error!("post processing of node {} failed: {:?}", &path, e)
            }
        }
        self.node_metadata.set(node_metadata);
    }

    fn get_context<'a>(
        &'a mut self,
        path: &NodePath,
        processing_context: &'a impl ProcessingContext,
        clock: &'a mut impl Clock,
        node_metadata: &'a mut HashMap<NodePath, NodeMetadata>,
    ) -> (PipelineContext<'a>, &'a mut Box<dyn Any>) {
        let context = PipelineContext {
            processing_context: RefCell::new(processing_context),
            preview: RefCell::new(
                self.previews
                    .get_mut(path)
                    .unwrap_or_else(|| panic!("Missing preview for {path}")),
            ),
            receivers: self.receivers.get(path),
            senders: self.senders.get(path),
            node_metadata: RefCell::new(node_metadata.entry(path.clone()).or_default()),
            clock: RefCell::new(clock),
        };
        log::trace!("process_node {} with context {:?}", &path, &context);
        let state = self.states.get_mut(path);
        let state = state.unwrap();

        (context, state)
    }

    pub fn debug_ui(
        &self,
        ui: &mut <DebugUiImpl as DebugUi>::DrawHandle<'_>,
        nodes: &Vec<(&NodePath, &Box<dyn ProcessingNodeExt>)>,
    ) {
        ui.collapsing_header("Nodes", |ui| {
            for (path, node) in nodes {
                let state = self.states.get(path);
                let state = state.unwrap();
                ui.collapsing_header(path.as_str(), |ui| node.debug_ui(ui, state));
            }
        });
    }

    pub fn get_state<S: 'static>(&self, path: &NodePath) -> Option<&S> {
        self.states.get(path).and_then(|state| state.downcast_ref())
    }

    pub fn write_port<V: PortValue + 'static>(&mut self, path: NodePath, port: PortId, value: V) {
        if let Some(receivers) = self.receivers.get_mut(&path) {
            if let Some(receiver) = receivers.get(&port) {
                receiver.set_value(value);
            } else {
                log::warn!(
                    "trying to write value to unknown port {:?} on path {:?}",
                    &port,
                    &path
                );
            }
        } else {
            log::warn!(
                "trying to write value to unknown receiver for node {:?}",
                &path
            );
        }
    }

    pub fn get_preview_ref(&self, path: &NodePath) -> Option<NodePreviewRef> {
        if let Some(preview) = self.previews.get(path) {
            match preview {
                NodePreviewState::History(_, buf) => Some(NodePreviewRef::History(buf.clone())),
                NodePreviewState::Data(buf) => Some(NodePreviewRef::Data(buf.clone())),
                NodePreviewState::Color(buf) => Some(NodePreviewRef::Color(buf.clone())),
                NodePreviewState::Timecode(buf) => Some(NodePreviewRef::Timecode(buf.clone())),
                _ => None,
            }
        } else {
            None
        }
    }
}

fn register_receiver(
    receivers: &mut NodeReceivers,
    path: &NodePath,
    port_id: PortId,
    metadata: PortMetadata,
) {
    log::debug!("Registering port receiver for {:?} {:?}", path, &port_id);
    match metadata.port_type {
        PortType::Single => receivers.register::<f64>(port_id, metadata),
        PortType::Color => receivers.register::<Color>(port_id, metadata),
        PortType::Multi => receivers.register::<Vec<f64>>(port_id, metadata),
        PortType::Laser => receivers.register::<Vec<LaserFrame>>(port_id, metadata),
        PortType::Data => receivers.register::<StructuredData>(port_id, metadata),
        PortType::Clock => receivers.register::<u64>(port_id, metadata),
        PortType::Texture => receivers.register::<TextureHandle>(port_id, metadata),
        port_type => log::debug!("TODO: implement port type {:?}", port_type),
    }
}

#[cfg(test)]
mod tests {
    use std::sync::Arc;

    use pinboard::NonEmptyPinboard;
    use test_case::test_case;

    use mizer_node::{NodeLink, NodePath, PortDirection, PortId, PortMetadata, PortType};
    use mizer_ports::memory::MemorySender;
    use mizer_ports::NodePortSender;

    use crate::ports::NodeReceivers;

    use super::PipelineWorker;

    #[test_case(1.)]
    #[test_case(0.)]
    fn should_connect_two_nodes(value: f64) -> anyhow::Result<()> {
        let node_metadata = Arc::new(NonEmptyPinboard::new(Default::default()));
        let source_path: NodePath = "/source".into();
        let dest_path: NodePath = "/dest".into();
        let port_id: PortId = "value".into();
        let mut worker = PipelineWorker::new(node_metadata);
        let source = PortMetadata {
            port_type: PortType::Single,
            multiple: None,
            direction: PortDirection::Output,
            dimensions: None,
            count: None,
        };
        let dest = PortMetadata {
            port_type: PortType::Single,
            multiple: None,
            direction: PortDirection::Input,
            dimensions: None,
            count: None,
        };
        let link = NodeLink {
            port_type: PortType::Single,
            source_port: port_id.clone(),
            source: source_path.clone(),
            target: dest_path.clone(),
            target_port: port_id.clone(),
            local: true,
        };
        register_receiver(&mut worker, dest_path.clone(), port_id.clone(), dest);

        worker.connect_nodes(link, source, dest)?;

        send_value(&worker, &source_path, port_id.clone(), value)?;
        let result = recv_value(&worker, &dest_path, &port_id);
        assert_eq!(value, result);
        Ok(())
    }

    #[test_case(1.)]
    #[test_case(0.)]
    fn should_write_from_one_output_to_multiple_inputs(value: f64) -> anyhow::Result<()> {
        let node_metadata = Arc::new(NonEmptyPinboard::new(Default::default()));
        let mut worker = PipelineWorker::new(node_metadata);
        let source = PortMetadata {
            port_type: PortType::Single,
            multiple: None,
            direction: PortDirection::Output,
            dimensions: None,
            count: None,
        };
        let dest = PortMetadata {
            port_type: PortType::Single,
            multiple: None,
            direction: PortDirection::Input,
            dimensions: None,
            count: None,
        };
        let source_path: NodePath = "/source".into();
        let dest1: NodePath = "/dest1".into();
        let dest2: NodePath = "/dest2".into();
        let port_id: PortId = "value".into();
        let link1 = NodeLink {
            port_type: PortType::Single,
            source_port: port_id.clone(),
            source: source_path.clone(),
            target: dest1.clone(),
            target_port: port_id.clone(),
            local: true,
        };
        let link2 = NodeLink {
            port_type: PortType::Single,
            source_port: port_id.clone(),
            source: source_path.clone(),
            target: dest2.clone(),
            target_port: port_id.clone(),
            local: true,
        };
        register_receiver(&mut worker, dest1.clone(), port_id.clone(), dest);
        register_receiver(&mut worker, dest2.clone(), port_id.clone(), dest);

        worker.connect_nodes(link1, source, dest)?;
        worker.connect_nodes(link2, source, dest)?;

        send_value(&worker, &source_path, port_id.clone(), value)?;
        let result1 = recv_value(&worker, &dest1, &port_id);
        let result2 = recv_value(&worker, &dest2, &port_id);
        assert_eq!(value, result1);
        assert_eq!(value, result2);
        Ok(())
    }

    fn register_receiver(
        worker: &mut PipelineWorker,
        path: NodePath,
        port: PortId,
        meta: PortMetadata,
    ) {
        let mut recvs = NodeReceivers::default();
        recvs.register::<f64>(port, meta);
        worker.receivers.insert(path, recvs);
    }

    fn send_value(
        worker: &PipelineWorker,
        path: &NodePath,
        port: PortId,
        value: f64,
    ) -> anyhow::Result<()> {
        let sender = worker.senders.get(path).unwrap();
        let (port, _) = sender.get(&port).unwrap();
        let port = port.downcast_ref::<MemorySender<f64>>().unwrap();

        port.send(value)
    }

    fn recv_value(worker: &PipelineWorker, path: &NodePath, port: &PortId) -> f64 {
        let recv = worker.receivers.get(path).unwrap();
        let port = recv.get(port).unwrap();

        port.read().unwrap()
    }
}
