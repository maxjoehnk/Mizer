use crate::commands::StaticNodeDescriptor;
use crate::context::CoordinatorRuntimeContext;
use crate::execution_engine::ExecutionEngine;
use anyhow::Context;
use indexmap::IndexMap;
use mizer_clock::{BoxedClock, Clock, ClockFrame};
use mizer_debug_ui_impl::{Injector, NodeStateAccess};
use mizer_node::{
    NodeDesigner, NodeLink, NodeMetadata, NodePath, NodePosition, NodeSetting, NodeType,
    PipelineNode, PortDirection, PortMetadata, ProcessingNode,
};
use mizer_nodes::{ContainerNode, Node, NodeDowncast, NodeExt};
use mizer_pipeline::{NodePortReader, NodePreviewRef, PipelineWorker, ProcessingNodeExt};
use mizer_ports::PortId;
use mizer_processing::{Processor, ProcessorPriorities};
use mizer_project_files::{Channel, Project};
use pinboard::NonEmptyPinboard;
use regex::Regex;
use std::collections::HashMap;
use std::io::Write;
use std::ops::DerefMut;
use std::sync::Arc;

pub struct Pipeline {
    nodes: IndexMap<NodePath, NodeState>,
    links: Vec<NodeLink>,
    worker: PipelineWorker,
    execution_engine: ExecutionEngine,
}

pub struct NodeState {
    node: Box<dyn ProcessingNodeExt>,
    designer: NodeDesigner,
    metadata: NodeMetadata,
    settings: Vec<NodeSetting>,
    ports: Vec<(PortId, PortMetadata)>,
}

impl NodeState {
    pub fn as_node<T: ProcessingNode>(&self) -> Option<&T> {
        self.node.downcast_ref::<T>().ok()
    }
}

impl Default for Pipeline {
    fn default() -> Self {
        Self {
            nodes: IndexMap::default(),
            links: Vec::default(),
            worker: PipelineWorker::new(Arc::new(NonEmptyPinboard::new(Default::default()))),
            execution_engine: ExecutionEngine::default(),
        }
    }
}

impl Pipeline {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add_node(
        &mut self,
        injector: &Injector,
        node_type: NodeType,
        designer: NodeDesigner,
        node: Option<Node>,
        parent: Option<&NodePath>,
    ) -> anyhow::Result<StaticNodeDescriptor> {
        let node = node.unwrap_or_else(|| node_type.into());
        let path = self.new_node_path(node_type, parent, None);

        self.add_node_with_path(injector, path, designer, node, parent)
    }

    fn add_node_with_path(
        &mut self,
        injector: &Injector,
        path: NodePath,
        designer: NodeDesigner,
        node: Node,
        parent: Option<&NodePath>,
    ) -> anyhow::Result<StaticNodeDescriptor> {
        let settings = node.settings(injector);
        let ports = node.list_ports(injector);
        let node = self.add_dyn_node(path.clone(), node, &ports);
        let metadata = NodeMetadata {
            display_name: node.display_name(injector),
            custom_name: None,
        };
        let state = NodeState {
            metadata,
            designer,
            settings,
            ports,
            node,
        };

        let descriptor = Self::get_descriptor(path.clone(), &state);

        if let Some(container) =
            parent.and_then(|parent| self.get_node_mut::<ContainerNode>(parent))
        {
            container.nodes.push(path.clone());
        }

        self.nodes.insert(path.clone(), state);
        self.execution_engine.add_node(path);

        Ok(descriptor)
    }

    fn add_dyn_node(
        &mut self,
        path: NodePath,
        node: Node,
        ports: &[(PortId, PortMetadata)],
    ) -> Box<dyn ProcessingNodeExt> {
        let mut registration = PipelineNodeRegistration {
            ports,
            path,
            worker: &mut self.worker,
        };

        registration.handle_dyn(node)
    }

    pub(crate) fn duplicate_node(
        &mut self,
        path: &NodePath,
        parent: Option<&NodePath>,
    ) -> anyhow::Result<NodePath> {
        let state = self
            .nodes
            .get(path)
            .ok_or_else(|| anyhow::anyhow!("Node not found: {}", path))?;
        let node_config: Node = NodeDowncast::downcast(&state.node);
        let node_type = node_config.node_type();
        let new_path = self.new_node_path(node_type, parent, Some(path));
        // add_dyn_node inlined because of borrow checker
        let node = {
            let mut registration = PipelineNodeRegistration {
                ports: &state.ports,
                path: new_path.clone(),
                worker: &mut self.worker,
            };

            registration.handle_dyn(node_config)
        };
        let new_node = NodeState {
            node,
            designer: state.designer,
            metadata: state.metadata.clone(),
            settings: state.settings.clone(),
            ports: state.ports.clone(),
        };

        self.nodes.insert(new_path.clone(), new_node);
        self.execution_engine.add_node(new_path.clone());

        Ok(new_path)
    }

    pub(crate) fn rename_node(&mut self, from: &NodePath, to: NodePath) -> anyhow::Result<()> {
        if self.nodes.contains_key(&to) {
            anyhow::bail!("A node with the path {to} already exists!");
        }
        let state = self.nodes.shift_remove(from).unwrap();
        self.nodes.insert(to.clone(), state);
        for link in self.links.iter_mut() {
            if &link.source == from {
                link.source = to.clone();
            }
            if &link.target == from {
                link.target = to.clone();
            }
        }
        self.worker.rename_node(from.clone(), to.clone())?;
        self.execution_engine.rename_node(from, to)?;

        Ok(())
    }

    fn new_node_path(
        &self,
        node_type: NodeType,
        parent: Option<&NodePath>,
        old_path: Option<&NodePath>,
    ) -> NodePath {
        if let Some((old_path, parent)) = old_path.zip(parent) {
            if !old_path.starts_with(parent) {
                if let Some(without_parent) = old_path.split("/").last() {
                    return parent.join(&NodePath::from(without_parent));
                }
            }
        }

        let node_type_name = node_type.get_name();
        let id = self.get_next_id(node_type);
        let node_name = format!("{}-{}", node_type_name, id).into();

        if let Some(parent) = parent {
            parent.join(&node_name)
        } else {
            node_name
        }
    }

    pub(crate) fn delete_node(&mut self, path: &NodePath) -> Option<(NodeState, Vec<NodeLink>)> {
        let node = self.nodes.shift_remove(path)?;
        let links = self.remove_links_if(|link| link.source == *path || link.target == *path);
        self.worker.remove_node(path, &links);
        self.execution_engine.remove_node(path);

        Some((node, links))
    }

    pub(crate) fn reinsert_node(&mut self, path: NodePath, state: NodeState) {
        self.add_dyn_node(
            path.clone(),
            NodeDowncast::downcast(&state.node),
            &state.ports,
        );
        self.nodes.insert(path.clone(), state);
        self.execution_engine.add_node(path);
    }

    pub(crate) fn list_links(&self) -> impl Iterator<Item = &NodeLink> {
        self.links.iter()
    }

    pub(crate) fn delete_link(&mut self, link: &NodeLink) {
        self.remove_links_if(|l| l == link);
    }

    pub(crate) fn remove_links_from_port(
        &mut self,
        path: &NodePath,
        port: &PortId,
    ) -> Vec<NodeLink> {
        self.remove_links_if(|link| link.source == *path && link.source_port == *port)
    }

    pub(crate) fn remove_links_from_node(&mut self, path: &NodePath) -> Vec<NodeLink> {
        self.remove_links_if(|link| link.source == *path || link.target == *path)
    }

    pub(crate) fn find_input_link(&mut self, path: &NodePath, port: &PortId) -> Option<NodeLink> {
        self.links
            .iter()
            .find(|link| link.target == *path && link.target_port == *port)
            .cloned()
    }

    fn remove_links_if(&mut self, predicate: impl Fn(&NodeLink) -> bool) -> Vec<NodeLink> {
        let links = std::mem::take(&mut self.links);
        let (removed_links, remaining_links) = links.into_iter().partition(predicate);
        tracing::debug!("Removing links: {removed_links:?}");
        self.links = remaining_links;
        for link in &removed_links {
            self.worker.disconnect_port(link);
            self.execution_engine.remove_link(link);
        }

        removed_links
    }

    pub(crate) fn add_link(&mut self, mut link: NodeLink) -> anyhow::Result<()> {
        let (source_port, target_port) = self
            .get_ports(&link)
            .context(format!("Fetching ports for link {link:?}"))?;
        anyhow::ensure!(
            source_port.port_type == target_port.port_type,
            "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
            &source_port,
            &target_port,
            &link
        );
        link.port_type = source_port.port_type;
        self.worker
            .connect_nodes(link.clone(), source_port, target_port)?;
        self.execution_engine.link_node(link.clone())?;
        self.links.push(link);

        Ok(())
    }

    pub fn contains_node(&self, path: &NodePath) -> bool {
        self.nodes.contains_key(path)
    }

    pub fn get_node<TNode: PipelineNode>(&self, path: &NodePath) -> Option<&TNode> {
        self.nodes
            .get(path)
            .and_then(|state| state.node.downcast_ref::<TNode>().ok())
    }

    pub fn get_node_with_state<TNode: ProcessingNode>(
        &self,
        path: &NodePath,
    ) -> Option<(&TNode, &TNode::State)> {
        let node = self.get_node(path)?;
        let state = self.worker.get_state::<TNode::State>(path)?;

        Some((node, state))
    }

    pub fn get_node_dyn(&self, path: &NodePath) -> Option<&dyn ProcessingNodeExt> {
        self.nodes.get(path).map(|state| &*state.node)
    }

    pub fn get_node_dyn_mut(&mut self, path: &NodePath) -> Option<&mut dyn ProcessingNodeExt> {
        self.nodes.get_mut(path).map(|state| &mut *state.node)
    }

    pub fn get_node_mut<TNode: PipelineNode>(&mut self, path: &NodePath) -> Option<&mut TNode> {
        self.nodes
            .get_mut(path)
            .and_then(|state| state.node.downcast_mut::<TNode>().ok())
    }

    pub fn get_node_designer_mut(&mut self, path: &NodePath) -> Option<&mut NodeDesigner> {
        self.nodes.get_mut(path).map(|state| &mut state.designer)
    }

    pub fn list_nodes(&self) -> impl Iterator<Item = (&NodePath, &dyn ProcessingNodeExt)> {
        self.nodes.iter().map(|(path, state)| (path, &*state.node))
    }

    pub fn list_node_descriptors(&self) -> Vec<StaticNodeDescriptor> {
        self.nodes
            .iter()
            .map(|(path, state)| Self::get_descriptor(path.clone(), state))
            .collect()
    }

    pub fn get_node_descriptor(&self, path: &NodePath) -> Option<StaticNodeDescriptor> {
        self.nodes
            .get(path)
            .map(|state| Self::get_descriptor(path.clone(), state))
    }

    fn get_descriptor(path: NodePath, state: &NodeState) -> StaticNodeDescriptor {
        let node_type = state.node.node_type();

        let children = if let Some(container) = state.node.downcast_node::<ContainerNode>(node_type)
        {
            container.nodes.clone()
        } else {
            Default::default()
        };

        StaticNodeDescriptor {
            node_type,
            path: path.clone(),
            designer: state.designer,
            metadata: state.metadata.clone(),
            children,
            settings: state.settings.clone(),
            ports: state.ports.clone(),
            details: state.node.details(),
        }
    }

    pub fn find_node_paths<TNode: PipelineNode>(
        &self,
        matches: impl Fn(&TNode) -> bool,
    ) -> Vec<&NodePath> {
        self.matching_nodes(matches).map(|(path, _)| path).collect()
    }

    pub fn find_node_path<TNode: PipelineNode>(
        &self,
        matches: impl Fn(&TNode) -> bool,
    ) -> Option<&NodePath> {
        self.matching_nodes(matches).map(|(path, _)| path).next()
    }

    pub fn find_nodes<TNode: PipelineNode>(
        &self,
        matches: impl Fn(&NodePath, &TNode) -> bool,
    ) -> Vec<(&NodePath, &TNode)> {
        self.matching_nodes_with_path(matches).collect()
    }

    pub fn update_node(&mut self, path: &NodePath, config: Node) -> anyhow::Result<Node> {
        let state = self
            .nodes
            .get_mut(path)
            .ok_or_else(|| anyhow::anyhow!("Node not found: {}", path))?;
        let mut node = boxed_node(config);
        std::mem::swap(&mut state.node, &mut node);

        Ok(NodeDowncast::downcast(&node))
    }

    fn matching_nodes<TNode: PipelineNode, TMatches: Fn(&TNode) -> bool>(
        &self,
        matches: TMatches,
    ) -> impl Iterator<Item = (&NodePath, &TNode)> {
        self.nodes.iter().filter_map(move |(path, state)| {
            let node = state.node.downcast_ref::<TNode>().ok()?;

            matches(node).then_some((path, node))
        })
    }

    fn matching_nodes_with_path<TNode: PipelineNode, TMatches: Fn(&NodePath, &TNode) -> bool>(
        &self,
        matches: TMatches,
    ) -> impl Iterator<Item = (&NodePath, &TNode)> {
        self.nodes.iter().filter_map(move |(path, state)| {
            let node = state.node.downcast_ref::<TNode>().ok()?;

            matches(path, node).then_some((path, node))
        })
    }

    fn get_ports(&self, link: &NodeLink) -> anyhow::Result<(PortMetadata, PortMetadata)> {
        let _source_node = self.nodes.get(&link.source).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.source)
        })?;
        let _target_node = self.nodes.get(&link.target).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.target)
        })?;
        let source_port = self
            .try_get_output_port_metadata(&link.source, &link.source_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.source_port,
                    link.source
                )
            })?;
        let target_port = self
            .try_get_input_port_metadata(&link.target, &link.target_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.target_port,
                    link.target
                )
            })?;

        Ok((source_port, target_port))
    }

    pub(crate) fn try_get_input_port_metadata(
        &self,
        path: &NodePath,
        port: &PortId,
    ) -> Option<PortMetadata> {
        self.get_port_metadata(path, port, PortDirection::Input)
    }

    pub(crate) fn get_input_port_metadata(&self, path: &NodePath, port: &PortId) -> PortMetadata {
        self.try_get_input_port_metadata(path, port)
            .unwrap_or_default()
    }

    pub(crate) fn try_get_output_port_metadata(
        &self,
        path: &NodePath,
        port: &PortId,
    ) -> Option<PortMetadata> {
        self.get_port_metadata(path, port, PortDirection::Output)
    }

    pub(crate) fn get_output_port_metadata(&self, path: &NodePath, port: &PortId) -> PortMetadata {
        self.try_get_output_port_metadata(path, port)
            .unwrap_or_default()
    }

    fn get_port_metadata(
        &self,
        path: &NodePath,
        port: &PortId,
        direction: PortDirection,
    ) -> Option<PortMetadata> {
        self.nodes.get(path).and_then(|state| {
            state
                .ports
                .iter()
                .filter(|(_, port)| port.direction == direction)
                .find(|(id, _)| id == port)
                .map(|(_, port)| *port)
        })
    }

    fn get_next_id(&self, node_type: NodeType) -> u32 {
        let node_type_prefix = format!("/{}-(\\d+)$", node_type.get_name());
        let regex = Regex::new(&node_type_prefix).unwrap();
        let next_id = self
            .nodes
            .keys()
            .filter_map(|path| regex.captures(path.as_str()))
            .map(|captures| captures[1].parse::<u32>().unwrap())
            .max()
            .map(|id| id + 1)
            .unwrap_or(0);

        next_id
    }

    #[profiling::function]
    fn pre_process(
        &mut self,
        injector: &mut Injector,
        clock: &mut dyn Clock,
        frame: ClockFrame,
        fps: f64,
    ) {
        let nodes = self
            .execution_engine
            .get_execution_order()
            .flat_map(|path| self.nodes.get(path).map(|state| (path, &state.node)))
            .collect::<Vec<_>>();
        let context = CoordinatorRuntimeContext {
            injector,
            fps,
            master_clock: frame,
        };
        self.worker
            .pre_process(nodes, &context, clock, &NodeStatePortReader(&self.nodes));
    }

    #[profiling::function]
    fn process(&mut self, injector: &mut Injector, clock: &mut dyn Clock, frame: ClockFrame) {
        let nodes = self
            .execution_engine
            .get_execution_order()
            .flat_map(|path| self.nodes.get(path).map(|state| (path, &state.node)))
            .collect::<Vec<_>>();
        let context = CoordinatorRuntimeContext {
            injector,
            fps: 60.,
            master_clock: frame,
        };
        self.worker
            .process(nodes, &context, clock, &NodeStatePortReader(&self.nodes));
    }

    #[profiling::function]
    fn post_process(&mut self, injector: &mut Injector, clock: &mut dyn Clock, frame: ClockFrame) {
        let nodes = self
            .execution_engine
            .get_execution_order()
            .flat_map(|path| self.nodes.get(path).map(|state| (path, &state.node)))
            .collect::<Vec<_>>();
        let context = CoordinatorRuntimeContext {
            injector,
            fps: 60.,
            master_clock: frame,
        };
        self.worker
            .post_process(nodes, &context, clock, &NodeStatePortReader(&self.nodes));
    }

    #[profiling::function]
    pub(crate) fn refresh_ports(&mut self, injector: &Injector) {
        for (_path, state) in self.nodes.iter_mut() {
            let _scope = format!("{:?}Node::list_ports", state.node.node_type());
            profiling::scope!(&_scope);

            state.ports = state.node.list_ports(injector);
        }
    }

    #[profiling::function]
    pub(crate) fn refresh_metadata(&mut self, injector: &Injector) {
        for (_path, state) in self.nodes.iter_mut() {
            let _scope = format!("{:?}Node::display_name", state.node.node_type());
            profiling::scope!(&_scope);
            let display_name = state.node.display_name(injector);

            state.metadata = NodeMetadata {
                display_name,
                custom_name: None,
            };
        }
    }

    #[profiling::function]
    pub(crate) fn refresh_settings(&mut self, injector: &Injector, paths: &[NodePath]) {
        for path in paths {
            if let Some(state) = self.nodes.get_mut(path) {
                let _scope = format!("{:?}Node::settings", state.node.node_type());
                profiling::scope!(&_scope);
                let settings = state.node.settings(injector);

                state.settings = settings;
            }
        }
    }

    #[profiling::function]
    pub(crate) fn get_settings(&self, paths: &[NodePath]) -> HashMap<NodePath, Vec<NodeSetting>> {
        paths
            .iter()
            .filter_map(move |path| {
                self.nodes
                    .get(path)
                    .map(|state| (path.clone(), state.settings.clone()))
            })
            .collect()
    }

    pub fn generate_pipeline_graph(&self) -> anyhow::Result<()> {
        let mut file = std::fs::File::create("pipeline.dot")?;
        writeln!(&mut file, "digraph pipeline {{")?;
        let mut node_ids = HashMap::new();
        for (counter, (path, _)) in self.nodes.iter().enumerate() {
            node_ids.insert(path, format!("N{}", counter));
            writeln!(&mut file, "  N{}[label=\"{}\",shape=box];", counter, path)?;
        }
        for link in self.links.iter() {
            let left_id = node_ids.get(&link.source).unwrap();
            let right_id = node_ids.get(&link.target).unwrap();

            writeln!(&mut file, "  {} -> {}[label=\"\"]", left_id, right_id)?;
        }
        writeln!(&mut file, "}}")?;
        Ok(())
    }

    pub fn get_preview_ref(&self, path: &NodePath) -> Option<NodePreviewRef> {
        self.worker.get_preview_ref(path)
    }

    pub fn write_port(&mut self, path: NodePath, port: PortId, value: f64) {
        self.worker.write_port(path, port, value);
    }

    pub fn read_state<TValue: 'static>(&self, path: &NodePath) -> Option<&TValue> {
        self.worker.get_state(path)
    }

    pub fn get_positions(&self, paths: &[NodePath]) -> Vec<NodePosition> {
        paths
            .iter()
            .filter_map(|path| self.nodes.get(path).map(|state| state.designer.position))
            .collect()
    }
}

impl NodeStateAccess for Pipeline {
    fn get(&self, path: &str) -> Option<&Box<dyn std::any::Any>> {
        self.worker.get(path)
    }
}

struct PipelineNodeRegistration<'a> {
    path: NodePath,
    worker: &'a mut PipelineWorker,
    ports: &'a [(PortId, PortMetadata)],
}

impl<'a> NodeExt for PipelineNodeRegistration<'a> {
    type Result = Box<dyn ProcessingNodeExt>;

    fn handle<TNode: ProcessingNode>(&mut self, node: TNode) -> Self::Result {
        self.worker
            .register_node(self.path.clone(), &node, self.ports);

        Box::new(node)
    }
}

struct NodeBoxer;
impl NodeExt for NodeBoxer {
    type Result = Box<dyn ProcessingNodeExt>;

    fn handle<TNode: ProcessingNode>(&mut self, node: TNode) -> Self::Result {
        Box::new(node)
    }
}

fn boxed_node(node: Node) -> Box<dyn ProcessingNodeExt> {
    let mut boxer = NodeBoxer;
    boxer.handle_dyn(node)
}

pub struct RuntimeProcessor;

impl Processor for RuntimeProcessor {
    fn priorities(&self) -> ProcessorPriorities {
        ProcessorPriorities {
            pre_process: -50,
            process: 0,
            post_process: 50,
        }
    }

    fn pre_process(&mut self, injector: &mut Injector, frame: ClockFrame, fps: f64) {
        let (pipeline, injector) = injector.get_slice_mut::<Pipeline>().unwrap();
        let (clock, injector) = injector.get_slice_mut::<BoxedClock>().unwrap();

        pipeline.pre_process(injector, clock.deref_mut(), frame, fps);
    }

    fn process(&mut self, injector: &mut Injector, frame: ClockFrame) {
        let (pipeline, injector) = injector.get_slice_mut::<Pipeline>().unwrap();
        let (clock, injector) = injector.get_slice_mut::<BoxedClock>().unwrap();

        pipeline.process(injector, clock.deref_mut(), frame);
    }

    fn post_process(&mut self, injector: &mut Injector, frame: ClockFrame) {
        let (pipeline, injector) = injector.get_slice_mut::<Pipeline>().unwrap();
        let (clock, injector) = injector.get_slice_mut::<BoxedClock>().unwrap();

        pipeline.post_process(injector, clock.deref_mut(), frame);
    }
}

impl Pipeline {
    pub fn new_project(&mut self, injector: &Injector) {
        self.add_node(
            injector,
            NodeType::Programmer,
            Default::default(),
            None,
            None,
        )
        .unwrap();
        self.add_node(
            injector,
            NodeType::Transport,
            Default::default(),
            None,
            None,
        )
        .unwrap();
    }

    pub fn load(&mut self, project: &Project, injector: &Injector) -> anyhow::Result<()> {
        for node in &project.nodes {
            self.add_node_with_path(
                injector,
                node.path.clone(),
                node.designer.clone(),
                node.config.clone(),
                None,
            )?;
        }
        for channel in &project.channels {
            let source_port =
                self.get_output_port_metadata(&channel.from_path, &channel.from_channel);
            let target_port = self.get_input_port_metadata(&channel.to_path, &channel.to_channel);
            anyhow::ensure!(
                source_port.port_type == target_port.port_type,
                "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
                &source_port,
                &target_port,
                &channel
            );

            self.add_link(NodeLink {
                source: channel.from_path.clone(),
                target: channel.to_path.clone(),
                source_port: channel.from_channel.clone(),
                target_port: channel.to_channel.clone(),
                port_type: source_port.port_type,
                local: true,
            })?;
        }
        Ok(())
    }

    pub fn save(&self, project: &mut Project) {
        project.channels = self
            .list_links()
            .map(|link| Channel {
                from_channel: link.source_port.clone(),
                from_path: link.source.clone(),
                to_channel: link.target_port.clone(),
                to_path: link.target.clone(),
            })
            .collect();
        project.nodes = self
            .nodes
            .iter()
            .map(|(name, state)| {
                let node = NodeDowncast::downcast(&state.node);
                mizer_project_files::Node {
                    designer: state.designer.clone(),
                    path: name.clone(),
                    config: node,
                }
            })
            .collect();
    }

    pub fn clear(&mut self) {
        self.nodes.clear();
        self.links.clear();
        self.worker = PipelineWorker::new(Arc::new(NonEmptyPinboard::new(Default::default())));
    }
}

struct NodeStatePortReader<'a>(&'a IndexMap<NodePath, NodeState>);

impl<'a> NodePortReader for NodeStatePortReader<'a> {
    fn list_ports(&self, path: &NodePath) -> Option<Vec<(PortId, PortMetadata)>> {
        self.0.get(path).map(|state| state.ports.clone())
    }
}

#[cfg(test)]
mod tests {
    use crate::Pipeline;
    use itertools::Itertools;
    use mizer_node::{
        ConfigurableNode, NodeContext, NodeDetails, NodeLink, NodePath, NodeSetting, NodeType,
        PipelineNode, PortMetadata, ProcessingNode,
    };
    use mizer_ports::{PortId, PortType};
    use mizer_processing::Injector;
    use std::sync::{Arc, Mutex};
    use std::time::Instant;

    use assertables::*;
    use mizer_clock::{ClockFrame, SystemClock};
    use mizer_nodes::FaderNode;
    use proptest::prelude::*;

    #[test_case::test_case(NodeType::Oscillator, "/oscillator-0")]
    #[test_case::test_case(NodeType::Fader, "/fader-0")]
    fn new_node_path_for_blank_node(node_type: NodeType, expected: &str) {
        let pipeline = Pipeline::new();

        let path = pipeline.new_node_path(node_type, None, None);

        assert_eq!(path, NodePath::from(expected));
    }

    #[test]
    fn new_node_path_in_container_should_add_prefix() {
        let pipeline = Pipeline::new();

        let path = pipeline.new_node_path(
            NodeType::Oscillator,
            Some(&NodePath::from("/container")),
            None,
        );

        assert_eq!(path, NodePath::from("/container/oscillator-0"));
    }

    #[test]
    fn new_node_path_in_new_container_should_keep_own_name() {
        let pipeline = Pipeline::new();

        let path = pipeline.new_node_path(
            NodeType::Oscillator,
            Some(&NodePath::from("/container-1")),
            Some(&NodePath::from("/container-0/sine-wave")),
        );

        assert_eq!(path, NodePath::from("/container-1/sine-wave"));
    }

    // This was a bug with the old reorder_nodes implementation not having a total sort order.
    // This test reproduced it with a count of 24
    proptest! {
        #[test]
        fn add_link_should_not_panic_with_non_linear_naming_of_connected_nodes(count in 2..100) {
            let count = count as usize;
            let injector = Injector::new();
            let mut pipeline = Pipeline::new();
            let paths = (0..count)
                .map(|_| {
                    pipeline.add_node(&injector, NodeType::Fader, Default::default(), Default::default(), Default::default()).unwrap().path
                })
                .collect::<Vec<_>>();

            for window in paths.windows(2) {
                pipeline.add_link(NodeLink {
                    source: window[0].clone(),
                    source_port: "Output".into(),
                    target: window[1].clone(),
                    target_port: "Input".into(),
                    port_type: PortType::Single,
                    local: true
                })
                    .unwrap();
            }

            assert_eq!(pipeline.list_links().count(), count - 1);
        }
    }

    proptest! {
        #[test]
        fn process_should_run_unconnected_nodes_in_insertion_order(count in 1..100) {
            let mut context = TestExecutionContext::default();
            let nodes = (0..count).map(|_| context.add_node()).collect::<Vec<_>>();

            context.process();

            let order = context.get_order();
            assert_iter_eq!(order, nodes);
        }
    }

    #[test]
    fn process_should_run_source_before_target() {
        let mut context = TestExecutionContext::default();
        let target = context.add_node();
        let source = context.add_node();
        context.add_link(&source, &target);

        context.process();

        let order = context.get_order();
        assert_iter_eq!(order, vec![source, target]);
    }

    #[test]
    fn process_should_not_reorder_non_linked_nodes() {
        let mut context = TestExecutionContext::default();
        let a = context.add_node();
        let b = context.add_node();
        let c = context.add_node();
        let d = context.add_node();
        context.add_link(&d, &a);

        context.process();

        let order = context.get_order();
        assert_iter_eq!(order, vec![b, c, d, a]);
    }

    #[test]
    fn process_should_move_later_connected_nodes_before_non_linked_nodes() {
        let mut context = TestExecutionContext::default();
        let a = context.add_node();
        let b = context.add_node();
        let c = context.add_node();
        let d = context.add_node();
        context.add_link(&b, &a);

        context.process();

        let order = context.get_order();
        assert_iter_eq!(order, vec![b, a, c, d]);
    }

    proptest! {
        #[test]
        fn process_should_run_multiple_nodes_in_link_order(count in 2..50) {
            let mut context = TestExecutionContext::default();
            let nodes = (0..count)
                .map(|_| context.add_node())
                .collect::<Vec<_>>();
            for window in nodes.windows(2) {
                context.add_link(&window[0], &window[1]);
            }

            context.process();

            let order = context.get_order();
            assert_iter_eq!(order, nodes);
        }

        #[test]
        fn process_should_run_multiple_reversed_nodes_in_link_order(count in 2..50) {
            let mut context = TestExecutionContext::default();
            let nodes = (0..count)
                .map(|_| context.add_node())
                .collect::<Vec<_>>();
            for window in nodes.windows(2) {
                context.add_link(&window[1], &window[0]);
            }

            context.process();

            let mut order = context.get_order();
            order.reverse();
            assert_iter_eq!(order, nodes);
        }
    }

    #[test]
    fn process_should_run_diamond_graph_source_first_and_sink_last() {
        let mut context = TestExecutionContext::default();
        let sink = context.add_node();
        let left = context.add_node();
        let right = context.add_node();
        let source = context.add_node();
        context.add_link(&source, &left);
        context.add_link(&source, &right);
        context.add_link(&left, &sink);
        context.add_link(&right, &sink);

        context.process();

        let order = context.get_order();
        assert_iter_eq!(order, vec![source, left, right, sink]);
    }

    #[test]
    fn add_link_should_not_move_target_node_before_source_when_they_are_already_linked_transitive()
    {
        let mut context = TestExecutionContext::default();
        let c = context.add_node();
        let b = context.add_node();
        let a = context.add_node();
        context.add_link(&a, &b);
        context.add_link(&b, &c);

        context.add_link(&a, &c);

        context.process();
        let order = context.get_order();
        assert_iter_eq!(order, vec![a, b, c]);
    }

    proptest! {
        #[test]
        fn process_should_run_two_graphs_in_correct_order_after_they_where_linked(size_a in 2..100, size_b in 2..100) {
            let mut context = TestExecutionContext::default();
            let graph_b = (0..size_a).map(|_| context.add_node()).collect::<Vec<_>>();
            let graph_a = (0..size_b).map(|_| context.add_node()).collect::<Vec<_>>();
            for graph in [&graph_a, &graph_b] {
                for window in graph.windows(2) {
                    context.add_link(&window[0], &window[1]);
                }
            }
            context.add_link(graph_a.last().unwrap(), &graph_b[0]);

            context.process();

            let order = context.get_order();
            assert_iter_eq!(order, [graph_a, graph_b].concat());
        }
    }

    #[derive(Default)]
    struct TestExecutionContext {
        injector: Injector,
        clock: SystemClock,
        pipeline: Pipeline,
    }

    impl TestExecutionContext {
        fn add_node(&mut self) -> NodePath {
            let descriptor = self
                .pipeline
                .add_node(
                    &self.injector,
                    NodeType::Fader,
                    Default::default(),
                    Default::default(),
                    Default::default(),
                )
                .unwrap();
            let node = MockFaderNode::default();
            self.pipeline.nodes[&descriptor.path].node = Box::new(node);

            descriptor.path
        }

        fn add_link(&mut self, from: &NodePath, to: &NodePath) {
            self.pipeline
                .add_link(NodeLink {
                    source: from.clone(),
                    source_port: "Output".into(),
                    target: to.clone(),
                    target_port: "Input".into(),
                    port_type: PortType::Single,
                    local: true,
                })
                .unwrap();
        }

        fn process(&mut self) {
            self.pipeline
                .process(&mut self.injector, &mut self.clock, ClockFrame::default());
        }

        fn get_order(self) -> Vec<NodePath> {
            self.pipeline
                .nodes
                .into_iter()
                .map(|(path, state)| (path, state.node.downcast::<MockFaderNode>().unwrap()))
                .filter_map(|(path, node)| {
                    let node = *node;
                    let processing_time = Arc::into_inner(node.processing_time)?;
                    let processing_time = processing_time.into_inner().unwrap()?;

                    Some((path, processing_time))
                })
                .sorted_by_key(|(_, time)| *time)
                .map(|(path, _)| path)
                .collect()
        }
    }

    #[derive(Default, Debug, Clone)]
    struct MockFaderNode {
        processing_time: Arc<Mutex<Option<Instant>>>,
        _fader_node: FaderNode,
    }

    impl PipelineNode for MockFaderNode {
        fn details(&self) -> NodeDetails {
            PipelineNode::details(&self._fader_node)
        }

        fn display_name(&self, injector: &Injector) -> String {
            self._fader_node.display_name(injector)
        }

        fn list_ports(&self, injector: &Injector) -> Vec<(PortId, PortMetadata)> {
            self._fader_node.list_ports(injector)
        }

        fn node_type(&self) -> NodeType {
            self._fader_node.node_type()
        }
    }

    impl ConfigurableNode for MockFaderNode {
        fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
            self._fader_node.settings(injector)
        }
    }

    impl ProcessingNode for MockFaderNode {
        type State = Option<f64>;

        fn process(
            &self,
            context: &impl NodeContext,
            state: &mut Self::State,
        ) -> anyhow::Result<()> {
            self.processing_time.lock().unwrap().replace(Instant::now());

            Ok(())
        }

        fn create_state(&self) -> Self::State {
            Default::default()
        }
    }
}
