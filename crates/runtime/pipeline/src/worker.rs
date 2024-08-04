use std::any::{type_name, Any};
use std::cell::RefCell;
use std::collections::HashMap;
use std::ops::Deref;
use std::sync::Arc;

use downcast::*;
use pinboard::NonEmptyPinboard;

use mizer_clock::Clock;
use mizer_debug_ui_impl::NodeStateAccess;
use mizer_node::*;
use mizer_nodes::NodeDowncast;
use mizer_ports::memory::MemorySender;
use mizer_ports::PortValue;
use mizer_processing::ProcessingContext;
use mizer_protocol_laser::LaserFrame;
use mizer_util::HashMapExtension;
use mizer_wgpu::TextureHandle;

use crate::ports::{NodeReceivers, NodeSenders};
use crate::preview_ref::NodePreviewRef;
use crate::{NodePreviewState, NodeRuntimeMetadata, PipelineContext};

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

impl NodeDowncast for &dyn ProcessingNodeExt {
    fn node_type(&self) -> NodeType {
        PipelineNode::node_type(*self)
    }

    fn downcast_node<T: Clone + 'static>(&self, _: NodeType) -> Option<T> {
        self.downcast_ref().ok().cloned()
    }
}

impl NodeDowncast for &mut dyn ProcessingNodeExt {
    fn node_type(&self) -> NodeType {
        PipelineNode::node_type(*self)
    }

    fn downcast_node<T: Clone + 'static>(&self, _: NodeType) -> Option<T> {
        self.downcast_ref().ok().cloned()
    }
}

pub struct PipelineWorker {
    states: HashMap<NodePath, Box<dyn Any>>,
    senders: HashMap<NodePath, NodeSenders>,
    receivers: HashMap<NodePath, NodeReceivers>,
    previews: HashMap<NodePath, NodePreviewState>,
    node_metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeRuntimeMetadata>>>,
    _node_metadata: HashMap<NodePath, NodeRuntimeMetadata>,
}

impl NodeStateAccess for PipelineWorker {
    fn get(&self, path: &str) -> Option<&Box<dyn Any>> {
        let path = NodePath(path.to_string());

        self.states.get(&path)
    }
}

impl std::fmt::Debug for PipelineWorker {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("PipelineWorker")
            .field("senders", &self.senders)
            .field("receivers", &self.receivers)
            .field("previews", &self.previews)
            .field("port_metadata", &self.node_metadata)
            .finish()
    }
}

pub trait NodePortReader {
    fn list_ports(&self, path: &NodePath) -> Option<Vec<(PortId, PortMetadata)>>;
}

impl PipelineWorker {
    pub fn new(
        node_metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeRuntimeMetadata>>>,
    ) -> Self {
        Self {
            states: Default::default(),
            senders: Default::default(),
            receivers: Default::default(),
            previews: Default::default(),
            node_metadata,
            _node_metadata: Default::default(),
        }
    }

    pub fn register_node<T: 'static + ProcessingNode>(
        &mut self,
        path: NodePath,
        node: &T,
        ports: &[(PortId, PortMetadata)],
    ) {
        tracing::debug!("register_node {:?} ({:?})", path, node);
        let state = node.create_state();
        match ProcessingNode::details(node).preview_type {
            PreviewType::History => {
                self.previews
                    .insert(path.clone(), NodePreviewState::History(Default::default()));
            }
            PreviewType::Multiple => {
                self.previews
                    .insert(path.clone(), NodePreviewState::Multi(Default::default()));
            }
            PreviewType::Data => {
                self.previews
                    .insert(path.clone(), NodePreviewState::Data(Default::default()));
            }
            PreviewType::Color => {
                self.previews
                    .insert(path.clone(), NodePreviewState::Color(Default::default()));
            }
            PreviewType::Timecode => {
                self.previews
                    .insert(path.clone(), NodePreviewState::Timecode(Default::default()));
            }
            _ => {
                self.previews.insert(path.clone(), NodePreviewState::None);
            }
        }
        let state: Box<T::State> = Box::new(state);
        self.states.insert(path.clone(), state);
        let mut receivers = NodeReceivers::default();
        for (port_id, metadata) in ports {
            if metadata.is_input() {
                register_receiver(&mut receivers, &path, port_id.clone(), *metadata);
            }
        }
        self.receivers.insert(path, receivers);
    }

    pub fn remove_node(&mut self, path: &NodePath, links: &[NodeLink]) {
        tracing::debug!("remove_node {path:?} and links {links:?}");
        self.disconnect_ports(links);
        self.states.remove(path);
        self.receivers.remove(path);
        self.senders.remove(path);
        self.previews.remove(path);
    }

    pub fn rename_node(&mut self, from: NodePath, to: NodePath) -> anyhow::Result<()> {
        self.states
            .rename_key(&from, to.clone())
            .then_some(())
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", from))?;
        self.receivers.rename_key(&from, to.clone());
        self.senders.rename_key(&from, to.clone());
        self.previews.rename_key(&from, to.clone());
        
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
        self.connect_ports(link, source_meta, target_meta)?;

        Ok(())
    }

    fn connect_ports(
        &mut self,
        link: NodeLink,
        source_meta: PortMetadata,
        target_meta: PortMetadata,
    ) -> anyhow::Result<()> {
        match link.port_type {
            PortType::Single => {
                self.connect_memory_ports::<port_types::SINGLE>(link, source_meta, target_meta)
            }
            PortType::Clock => {
                self.connect_memory_ports::<port_types::CLOCK>(link, source_meta, target_meta)
            }
            PortType::Color => {
                self.connect_memory_ports::<port_types::COLOR>(link, source_meta, target_meta)
            }
            PortType::Multi => {
                self.connect_memory_ports::<port_types::MULTI>(link, source_meta, target_meta)
            }
            PortType::Laser => {
                self.connect_memory_ports::<Vec<LaserFrame>>(link, source_meta, target_meta)
            }
            PortType::Data => {
                self.connect_memory_ports::<port_types::DATA>(link, source_meta, target_meta)
            }
            PortType::Texture => {
                self.connect_memory_ports::<TextureHandle>(link, source_meta, target_meta)
            }
            PortType::Vector => {
                self.connect_memory_ports::<port_types::VECTOR>(link, source_meta, target_meta)
            }
            PortType::Text => {
                self.connect_memory_ports::<port_types::TEXT>(link, source_meta, target_meta)
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
            PortType::Single => self.disconnect_memory_ports::<port_types::SINGLE>(link),
            PortType::Clock => self.disconnect_memory_ports::<port_types::CLOCK>(link),
            PortType::Color => self.disconnect_memory_ports::<port_types::COLOR>(link),
            PortType::Multi => self.disconnect_memory_ports::<port_types::MULTI>(link),
            PortType::Laser => self.disconnect_memory_ports::<Vec<LaserFrame>>(link),
            PortType::Data => self.disconnect_memory_ports::<port_types::DATA>(link),
            PortType::Texture => self.disconnect_memory_ports::<TextureHandle>(link),
            PortType::Vector => self.disconnect_memory_ports::<port_types::VECTOR>(link),
            PortType::Text => self.disconnect_memory_ports::<port_types::TEXT>(link),
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
            .or_default();
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
            .or_default();
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
        port_reader: &impl NodePortReader,
    ) {
        profiling::scope!("PipelineWorker::pre_process");
        self.check_node_receivers(&nodes, port_reader);
        self.pre_process_nodes(&mut nodes, clock, context);
    }

    pub fn process<'a>(
        &mut self,
        mut nodes: Vec<(&'a NodePath, &'a Box<dyn ProcessingNodeExt>)>,
        context: &impl ProcessingContext,
        clock: &mut impl Clock,
        port_reader: &impl NodePortReader,
    ) {
        profiling::scope!("PipelineWorker::process");
        self.check_node_receivers(&nodes, port_reader);
        self.process_nodes(&mut nodes, clock, context);
    }

    pub fn post_process<'a>(
        &mut self,
        mut nodes: Vec<(&'a NodePath, &'a Box<dyn ProcessingNodeExt>)>,
        context: &impl ProcessingContext,
        clock: &mut impl Clock,
        port_reader: &impl NodePortReader,
    ) {
        profiling::scope!("PipelineWorker::post_process");
        self.check_node_receivers(&nodes, port_reader);
        self.post_process_nodes(&mut nodes, clock, context);
    }

    fn check_node_receivers(
        &mut self,
        nodes: &[(&NodePath, &Box<dyn ProcessingNodeExt>)],
        port_reader: &impl NodePortReader,
    ) {
        profiling::scope!("PipelineWorker::check_node_receivers");
        for (path, _) in nodes {
            let receivers = self.receivers.entry((*path).clone()).or_default();
            for (port_id, metadata) in port_reader.list_ports(path).unwrap_or_default() {
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
            profiling::scope!(&_scope, path.as_str());
            if let Err(e) = node.pre_process(&context, state) {
                tracing::error!("pre processing of node {} failed: {:?}", &path, e)
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
            profiling::scope!(&_scope, path.as_str());
            if let Err(e) = node.process(&context, state) {
                tracing::error!("processing of node {} failed: {:?}", &path, e)
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
            profiling::scope!(&_scope, path.as_str());
            if let Err(e) = node.post_process(&context, state) {
                tracing::error!("post processing of node {} failed: {:?}", &path, e)
            }
        }
        self.node_metadata.set(node_metadata);
    }

    fn get_context<'a>(
        &'a mut self,
        path: &NodePath,
        processing_context: &'a impl ProcessingContext,
        clock: &'a mut impl Clock,
        node_metadata: &'a mut HashMap<NodePath, NodeRuntimeMetadata>,
    ) -> (PipelineContext<'a>, &'a mut Box<dyn Any>) {
        profiling::scope!("PipelineWorker::get_context");
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
        tracing::trace!("process_node {} with context {:?}", &path, &context);
        let state = self.states.get_mut(path);
        let state = state.unwrap();

        (context, state)
    }

    pub fn get_state<S: 'static>(&self, path: &NodePath) -> Option<&S> {
        self.states.get(path).and_then(|state| state.downcast_ref())
    }

    pub fn write_port<V: PortValue + 'static>(&mut self, path: NodePath, port: PortId, value: V) {
        if let Some(receivers) = self.receivers.get_mut(&path) {
            if let Some(receiver) = receivers.get(&port) {
                receiver.set_value(value);
            } else {
                tracing::warn!(
                    "trying to write value to unknown port {:?} on path {:?}",
                    &port,
                    &path
                );
            }
        } else {
            tracing::warn!(
                "trying to write value to unknown receiver for node {:?}",
                &path
            );
        }
    }

    pub fn get_preview_ref(&self, path: &NodePath) -> Option<NodePreviewRef> {
        if let Some(preview) = self.previews.get(path) {
            match preview {
                NodePreviewState::History(buf) => Some(NodePreviewRef::History(buf.clone())),
                NodePreviewState::Data(buf) => Some(NodePreviewRef::Data(buf.clone())),
                NodePreviewState::Multi(buf) => Some(NodePreviewRef::Multi(buf.clone())),
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
    profiling::scope!("PipelineWorker::register_receiver");
    tracing::debug!("Registering port receiver for {:?} {:?}", path, &port_id);
    match metadata.port_type {
        PortType::Single => receivers.register::<port_types::SINGLE>(port_id, metadata),
        PortType::Color => receivers.register::<port_types::COLOR>(port_id, metadata),
        PortType::Multi => receivers.register::<port_types::MULTI>(port_id, metadata),
        PortType::Laser => receivers.register::<Vec<LaserFrame>>(port_id, metadata),
        PortType::Data => receivers.register::<port_types::DATA>(port_id, metadata),
        PortType::Clock => receivers.register::<port_types::CLOCK>(port_id, metadata),
        PortType::Texture => receivers.register::<TextureHandle>(port_id, metadata),
        PortType::Vector => receivers.register::<port_types::VECTOR>(port_id, metadata),
        PortType::Text => receivers.register::<port_types::TEXT>(port_id, metadata),
        port_type => tracing::debug!("TODO: implement port type {:?}", port_type),
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
