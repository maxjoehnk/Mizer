use std::collections::HashMap;
use std::str::FromStr;
use std::sync::Arc;

use dashmap::DashMap;
use pinboard::NonEmptyPinboard;

use crate::NodeDowncast;

use mizer_node::*;
use mizer_nodes::*;
use mizer_pipeline::*;

pub struct PipelineAccess {
    pub(crate) nodes: HashMap<NodePath, Box<dyn ProcessingNodeExt>>,
    pub nodes_view: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub(crate) links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
}

impl PipelineAccess {
    pub fn new() -> Self {
        Self {
            nodes: Default::default(),
            nodes_view: Default::default(),
            designer: NonEmptyPinboard::new(Default::default()).into(),
            links: NonEmptyPinboard::new(Default::default()).into(),
        }
    }

    pub fn handle_add_node(
        &mut self,
        node_type: NodeType,
        designer: NodeDesigner,
        node: Option<Node>,
    ) -> anyhow::Result<NodePath> {
        let node_type_name = node_type.get_name();
        let id = self.get_next_id(node_type);
        let path: NodePath = format!("/{}-{}", node_type_name, id).into();
        let node = node.unwrap_or_else(|| node_type.into());
        self.internal_add_node(path.clone(), node, designer);

        Ok(path)
    }

    pub(crate) fn internal_add_node(&mut self, path: NodePath, node: Node, designer: NodeDesigner) {
        self.add_project_node(path.clone(), node);
        self.add_designer_node(path, designer);
    }

    fn get_next_id(&self, node_type: NodeType) -> u32 {
        let node_type_prefix = format!("/{}-", node_type.get_name());
        let mut ids = self
            .nodes
            .keys()
            .filter_map(|path| path.0.strip_prefix(&node_type_prefix))
            .filter_map(|suffix| u32::from_str(suffix).ok())
            .collect::<Vec<_>>();
        log::trace!("found ids for prefix {}: {:?}", node_type_prefix, ids);
        ids.sort_unstable();
        ids.last().map(|last_id| last_id + 1).unwrap_or_default()
    }

    fn add_project_node(&mut self, path: NodePath, node: Node) {
        use Node::*;
        match node {
            DmxOutput(node) => self.add_node(path, node),
            Oscillator(node) => self.add_node(path, node),
            Clock(node) => self.add_node(path, node),
            Scripting(node) => self.add_node(path, node),
            Sequence(node) => self.add_node(path, node),
            Envelope(node) => self.add_node(path, node),
            Merge(node) => self.add_node(path, node),
            Select(node) => self.add_node(path, node),
            Threshold(node) => self.add_node(path, node),
            Fixture(node) => self.add_node(path, node),
            Programmer(node) => self.add_node(path, node),
            Group(node) => self.add_node(path, node),
            Preset(node) => self.add_node(path, node),
            Sequencer(node) => self.add_node(path, node),
            IldaFile(node) => self.add_node(path, node),
            Laser(node) => self.add_node(path, node),
            Fader(node) => self.add_node(path, node),
            Button(node) => self.add_node(path, node),
            OpcOutput(node) => self.add_node(path, node),
            PixelPattern(node) => self.add_node(path, node),
            PixelDmx(node) => self.add_node(path, node),
            OscInput(node) => self.add_node(path, node),
            OscOutput(node) => self.add_node(path, node),
            VideoFile(node) => self.add_node(path, node),
            VideoTransform(node) => self.add_node(path, node),
            VideoColorBalance(node) => self.add_node(path, node),
            VideoEffect(node) => self.add_node(path, node),
            VideoOutput(node) => self.add_node(path, node),
            MidiInput(node) => self.add_node(path, node),
            MidiOutput(node) => self.add_node(path, node),
            ColorHsv(node) => self.add_node(path, node),
            ColorRgb(node) => self.add_node(path, node),
            Gamepad(node) => self.add_node(path, node),
            TestSink(node) => self.add_node(path, node),
        }
    }

    pub fn add_node<T: 'static + ProcessingNode<State = S>, S: 'static>(
        &mut self,
        path: NodePath,
        node: T,
    ) {
        log::debug!("adding node {}: {:?}", &path, node);
        self.nodes_view.insert(path.clone(), Box::new(node.clone()));
        let node = Box::new(node);
        self.nodes.insert(path, node);
    }

    pub fn add_designer_node(&mut self, path: NodePath, designer: NodeDesigner) {
        let mut nodes = self.designer.read();
        nodes.insert(path, designer);
        self.designer.set(nodes);
    }

    pub fn delete_node(
        &mut self,
        path: NodePath,
    ) -> anyhow::Result<(Node, NodeDesigner, Vec<NodeLink>)> {
        let node = self
            .nodes
            .remove(&path)
            .ok_or_else(|| anyhow::anyhow!("Deleting unknown node"))?;
        let node = NodeDowncast::downcast(&node);
        self.nodes_view.remove(&path);
        let mut designer = self.designer.read();
        let node_designer = designer
            .remove(&path)
            .ok_or_else(|| anyhow::anyhow!("Missing designer state for node"))?;
        self.designer.set(designer);
        let links = self.links.read();
        let (links, removed_links) = links
            .into_iter()
            .partition(|link| link.source != path && link.target != path);
        self.links.set(links);

        Ok((node, node_designer, removed_links))
    }

    pub fn add_link(&mut self, mut link: NodeLink) -> anyhow::Result<()> {
        let (source_port, target_port) = self.get_ports(&link)?;
        anyhow::ensure!(
            source_port.port_type == target_port.port_type,
            "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
            &source_port,
            &target_port,
            &link
        );
        link.port_type = source_port.port_type;
        let mut links = self.links.read();
        links.push(link.clone());
        self.links.set(links);

        Ok(())
    }

    pub fn remove_link(&mut self, link: &NodeLink) {
        let mut links = self.links.read();
        links.retain(|l| l != link);
        self.links.set(links);
    }

    fn get_ports(&self, link: &NodeLink) -> anyhow::Result<(PortMetadata, PortMetadata)> {
        let source_node = self.nodes.get(&link.source).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.source)
        })?;
        let target_node = self.nodes.get(&link.target).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.target)
        })?;
        let source_port = source_node
            .introspect_port(&link.source_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.source_port,
                    link.source
                )
            })?;
        let target_port = target_node
            .introspect_port(&link.target_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.target_port,
                    link.target
                )
            })?;

        Ok((source_port, target_port))
    }

    pub(crate) fn get_port_metadata(&self, path: &NodePath, port: &PortId) -> PortMetadata {
        let node = self.nodes_view.get(path).unwrap();
        node.introspect_port(port).unwrap_or_default()
    }
}
