use crate::commands::StaticNodeDescriptor;
use crate::context::CoordinatorRuntimeContext;
use anyhow::Context;
use indexmap::IndexMap;
use mizer_clock::{BoxedClock, ClockFrame};
use mizer_debug_ui_impl::{Injector, NodeStateAccess};
use mizer_node::{NodeCommentArea, NodeCommentId, NodeDesigner, NodeLink, NodeMetadata, NodePath, NodeSetting, NodeType, PipelineNode, PortDirection, PortMetadata, ProcessingNode};
use mizer_nodes::{ContainerNode, Node, NodeDowncast, NodeExt};
use mizer_pipeline::{NodePortReader, NodePreviewRef, PipelineWorker, ProcessingNodeExt};
use mizer_ports::PortId;
use mizer_processing::{Processor, ProcessorPriorities};
use mizer_project_files::{Channel, Project};
use pinboard::NonEmptyPinboard;
use std::cmp::Ordering;
use std::collections::HashMap;
use std::io::Write;
use std::ops::DerefMut;
use std::str::FromStr;
use std::sync::Arc;

pub struct Pipeline {
    nodes: IndexMap<NodePath, NodeState>,
    links: Vec<NodeLink>,
    comments: IndexMap<NodeCommentId, NodeCommentArea>,
    worker: PipelineWorker,
}

pub struct NodeState {
    node: Box<dyn ProcessingNodeExt>,
    designer: NodeDesigner,
    metadata: NodeMetadata,
    settings: Vec<NodeSetting>,
    ports: Vec<(PortId, PortMetadata)>,
}

impl Pipeline {
    pub fn new() -> Self {
        Self {
            nodes: IndexMap::new(),
            links: Vec::new(),
            comments: Default::default(),
            worker: PipelineWorker::new(Arc::new(NonEmptyPinboard::new(Default::default()))),
        }
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
        let path = self.new_node_path(node_type);

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

        self.nodes.insert(path, state);

        self.reorder_nodes();

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

    pub(crate) fn duplicate_node(&mut self, path: &NodePath) -> anyhow::Result<NodePath> {
        let state = self
            .nodes
            .get(path)
            .ok_or_else(|| anyhow::anyhow!("Node not found: {}", path))?;
        let node_config: Node = NodeDowncast::downcast(&state.node);
        let node_type = node_config.node_type();
        let new_path = self.new_node_path(node_type);
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
        self.reorder_nodes();

        Ok(new_path)
    }

    pub(crate) fn rename_node(&mut self, from: &NodePath, to: NodePath) -> anyhow::Result<()> {
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
        self.worker.rename_node(from.clone(), to)?;
        self.reorder_nodes();

        Ok(())
    }

    fn new_node_path(&self, node_type: NodeType) -> NodePath {
        let node_type_name = node_type.get_name();
        let id = self.get_next_id(node_type);
        let path: NodePath = format!("/{}-{}", node_type_name, id).into();
        path
    }

    pub(crate) fn delete_node(&mut self, path: &NodePath) -> Option<(NodeState, Vec<NodeLink>)> {
        let node = self.nodes.shift_remove(path)?;
        let links = self.remove_links_if(|link| link.source == *path || link.target == *path);
        self.worker.remove_node(path, &links);

        Some((node, links))
    }

    pub(crate) fn reinsert_node(&mut self, path: NodePath, state: NodeState) {
        self.add_dyn_node(
            path.clone(),
            NodeDowncast::downcast(&state.node),
            &state.ports,
        );
        self.nodes.insert(path, state);
        self.reorder_nodes();
    }

    pub(crate) fn list_links(&self) -> impl Iterator<Item = &NodeLink> {
        self.links.iter()
    }
    
    pub(crate) fn list_comments(&self) -> impl Iterator<Item = &NodeCommentArea> {
        self.comments.values()
    }
    
    pub(crate) fn add_comment(&mut self, comment: NodeCommentArea) {
        self.comments.insert(comment.id, comment);
    }
    
    pub(crate) fn delete_comment(&mut self, id: &NodeCommentId) -> Option<NodeCommentArea> {
        self.comments.shift_remove(id)
    }
    
    pub(crate) fn get_comment_mut(&mut self, id: &NodeCommentId) -> Option<&mut NodeCommentArea> {
        self.comments.get_mut(id)
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
        }
        self.reorder_nodes();

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
        self.links.push(link);
        self.reorder_nodes();

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
        matches: impl Fn(&TNode) -> bool,
    ) -> Vec<(&NodePath, &TNode)> {
        self.matching_nodes(matches).collect()
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
        let node_type_prefix = format!("/{}-", node_type.get_name());
        let mut ids = self
            .nodes
            .keys()
            .filter_map(|path| path.0.strip_prefix(&node_type_prefix))
            .filter_map(|suffix| u32::from_str(suffix).ok())
            .collect::<Vec<_>>();
        tracing::trace!("found ids for prefix {}: {:?}", node_type_prefix, ids);
        ids.sort_unstable();
        ids.last().map(|last_id| last_id + 1).unwrap_or_default()
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
    pub(crate) fn refresh_settings(&mut self, injector: &Injector) {
        for (_path, state) in self.nodes.iter_mut() {
            let _scope = format!("{:?}Node::settings", state.node.node_type());
            profiling::scope!(&_scope);
            let settings = state.node.settings(injector);

            state.settings = settings;
        }
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

    fn reorder_nodes(&mut self) {
        profiling::scope!("PipelineAccess::reorder_nodes");
        let dependencies = self.list_links().cloned().fold(
            HashMap::<NodePath, Vec<NodePath>>::default(),
            |mut map, link| {
                map.entry(link.target).or_default().push(link.source);
                map
            },
        );
        // TODO: this doesn't actually guarantee execution order, but it's the same algorithm as before
        // Because two nodes don't have to relate to each other just using sort_by doesn't work for our use case
        self.nodes.sort_by(|left, _, right, _| {
            let deps = dependencies.get(left).zip(dependencies.get(right));
            if let Some((left_deps, right_deps)) = deps {
                if left_deps.contains(right) {
                    Ordering::Less
                } else if right_deps.contains(left) {
                    Ordering::Greater
                } else {
                    Ordering::Equal
                }
            } else {
                Ordering::Equal
            }
        });
        tracing::debug!(
            "Reordered nodes: {:?}",
            self.nodes.keys().collect::<Vec<_>>()
        );
    }

    pub fn write_port(&mut self, path: NodePath, port: PortId, value: f64) {
        self.worker.write_port(path, port, value);
    }

    pub fn read_state<TValue: 'static>(&self, path: &NodePath) -> Option<&TValue> {
        self.worker.get_state(path)
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
        profiling::scope!("Pipeline::pre_process");
        let (pipeline, injector) = injector.get_slice_mut::<Pipeline>().unwrap();
        let (clock, injector) = injector.get_slice_mut::<BoxedClock>().unwrap();
        let nodes = pipeline
            .nodes
            .iter()
            .map(|(path, state)| (path, &state.node))
            .collect::<Vec<_>>();
        let context = CoordinatorRuntimeContext {
            injector,
            fps,
            master_clock: frame,
        };
        pipeline.worker.pre_process(
            nodes,
            &context,
            clock.deref_mut(),
            &NodeStatePortReader(&pipeline.nodes),
        );
    }

    fn process(&mut self, injector: &mut Injector, frame: ClockFrame) {
        profiling::scope!("Pipeline::process");
        let (pipeline, injector) = injector.get_slice_mut::<Pipeline>().unwrap();
        let (clock, injector) = injector.get_slice_mut::<BoxedClock>().unwrap();
        let nodes = pipeline
            .nodes
            .iter()
            .map(|(path, state)| (path, &state.node))
            .collect::<Vec<_>>();
        let context = CoordinatorRuntimeContext {
            injector,
            fps: 60.,
            master_clock: frame,
        };
        pipeline.worker.process(
            nodes,
            &context,
            clock.deref_mut(),
            &NodeStatePortReader(&pipeline.nodes),
        );
    }

    fn post_process(&mut self, injector: &mut Injector, frame: ClockFrame) {
        profiling::scope!("Pipeline::post_process");
        let (pipeline, injector) = injector.get_slice_mut::<Pipeline>().unwrap();
        let (clock, injector) = injector.get_slice_mut::<BoxedClock>().unwrap();
        let nodes = pipeline
            .nodes
            .iter()
            .map(|(path, state)| (path, &state.node))
            .collect::<Vec<_>>();
        let context = CoordinatorRuntimeContext {
            injector,
            fps: 60.,
            master_clock: frame,
        };
        pipeline.worker.post_process(
            nodes,
            &context,
            clock.deref_mut(),
            &NodeStatePortReader(&pipeline.nodes),
        );
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
        self.comments = project.comments.iter().cloned().map(|comment| (comment.id, comment)).collect();

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
        project.comments = self.comments.values().cloned().collect();
    }

    pub fn clear(&mut self) {
        self.nodes.clear();
        self.links.clear();
        self.comments.clear();
        self.worker = PipelineWorker::new(Arc::new(NonEmptyPinboard::new(Default::default())));
    }
}

struct NodeStatePortReader<'a>(&'a IndexMap<NodePath, NodeState>);

impl<'a> NodePortReader for NodeStatePortReader<'a> {
    fn list_ports(&self, path: &NodePath) -> Option<Vec<(PortId, PortMetadata)>> {
        self.0.get(path).map(|state| state.ports.clone())
    }
}
