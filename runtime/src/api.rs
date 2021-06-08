use std::collections::HashMap;
use std::sync::Arc;

use dashmap::mapref::one::Ref;
use dashmap::DashMap;
use pinboard::NonEmptyPinboard;

use mizer_layouts::Layout;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PipelineNode, PortId, PortMetadata};
use mizer_nodes::{FixtureNode, Node, DmxOutputNode};

#[derive(Clone)]
pub struct RuntimeApi {
    pub(crate) nodes: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub(crate) designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub(crate) links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    pub(crate) layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    pub(crate) sender: flume::Sender<ApiCommand>,
}

#[derive(Debug, Clone)]
pub enum ApiCommand {
    AddNode(
        NodeType,
        NodeDesigner,
        Option<Node>,
        flume::Sender<anyhow::Result<NodePath>>,
    ),
    AddLink(NodeLink, flume::Sender<anyhow::Result<()>>),
    WritePort(NodePath, PortId, f64, flume::Sender<anyhow::Result<()>>),
    GetNodePreview(NodePath, flume::Sender<anyhow::Result<Vec<f64>>>),
    UpdateNode(NodePath, Node, flume::Sender<anyhow::Result<()>>),
}

impl RuntimeApi {
    pub fn nodes(&self) -> Vec<NodeDescriptor> {
        let designer = self.designer.read();
        self.nodes
            .iter()
            .map(|entry| entry.key().clone())
            .map(|path| self.get_descriptor(path, &designer))
            .collect()
    }

    pub fn links(&self) -> Vec<NodeLink> {
        self.links.read()
    }

    pub fn layouts(&self) -> Vec<Layout> {
        self.layouts.read()
    }

    pub fn add_node(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
    ) -> anyhow::Result<NodeDescriptor<'_>> {
        self.add_node_internal(node_type, designer, None)
    }

    pub fn add_node_for_fixture(&self, fixture_id: u32) -> anyhow::Result<NodeDescriptor<'_>> {
        let node = FixtureNode {
            fixture_id,
            ..Default::default()
        };
        self.add_node_internal(NodeType::Fixture, NodeDesigner::default(), Some(node.into()))
    }

    fn add_node_internal(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
        node: Option<Node>,
    ) -> anyhow::Result<NodeDescriptor<'_>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::AddNode(node_type, designer.clone(), node, tx))?;

        // TODO: this blocks, we should use the async method
        let path = rx.recv()??;
        let node = self.nodes.get(&path).unwrap();
        let ports = node.list_ports();

        Ok(NodeDescriptor {
            path,
            designer,
            node,
            ports,
        })
    }

    pub fn write_node_port(
        &self,
        node_path: NodePath,
        port: PortId,
        value: f64,
    ) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::WritePort(node_path, port, value, tx))?;
        let result = rx.recv()?;

        result
    }

    pub fn link_nodes(&self, link: NodeLink) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::AddLink(link, tx))?;
        let result = rx.recv()?;

        result
    }

    pub fn get_node_history(&self, node: NodePath) -> anyhow::Result<Vec<f64>> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetNodePreview(node, tx))?;
        let result = rx.recv()?;

        result
    }

    pub fn update_node(&self, path: NodePath, config: Node) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::UpdateNode(path, config, tx))?;
        let result = rx.recv()?;

        result
    }

    fn get_descriptor(&self, path: NodePath, designer: &HashMap<NodePath, NodeDesigner>) -> NodeDescriptor {
        let node = self.nodes.get(&path).unwrap();
        let ports = node.list_ports();
        let designer = designer[&path].clone();

        NodeDescriptor {
            path,
            node,
            designer,
            ports,
        }
    }
}

pub struct NodeDescriptor<'a> {
    pub path: NodePath,
    pub node: Ref<'a, NodePath, Box<dyn PipelineNode>>,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
}

impl<'a> NodeDescriptor<'a> {
    pub fn node_type(&self) -> NodeType {
        self.node.node_type()
    }

    pub fn downcast(&self) -> Node {
        match self.node.node_type() {
            NodeType::Clock => Node::Clock(self.downcast_node().unwrap()),
            NodeType::Oscillator => Node::Oscillator(self.downcast_node().unwrap()),
            NodeType::DmxOutput => Node::DmxOutput(self.downcast_node().unwrap()),
            NodeType::Scripting => Node::Scripting(self.downcast_node().unwrap()),
            NodeType::Sequence => Node::Sequence(self.downcast_node().unwrap()),
            NodeType::Fixture => Node::Fixture(self.downcast_node().unwrap()),
            NodeType::IldaFile => Node::IldaFile(self.downcast_node().unwrap()),
            NodeType::Laser => Node::Laser(self.downcast_node().unwrap()),
            NodeType::Fader => Node::Fader(self.downcast_node().unwrap()),
            NodeType::Button => Node::Button(self.downcast_node().unwrap()),
            NodeType::MidiInput => Node::MidiInput(self.downcast_node().unwrap()),
            NodeType::MidiOutput => Node::MidiOutput(self.downcast_node().unwrap()),
            NodeType::OpcOutput => Node::OpcOutput(self.downcast_node().unwrap()),
            NodeType::PixelPattern => Node::PixelPattern(self.downcast_node().unwrap()),
            NodeType::PixelDmx => Node::PixelDmx(self.downcast_node().unwrap()),
            NodeType::OscInput => Node::OscInput(self.downcast_node().unwrap()),
            NodeType::OscOutput => Node::OscOutput(self.downcast_node().unwrap()),
            NodeType::VideoFile => Node::VideoFile(self.downcast_node().unwrap()),
            NodeType::VideoColorBalance => Node::VideoColorBalance(self.downcast_node().unwrap()),
            NodeType::VideoOutput => Node::VideoOutput(self.downcast_node().unwrap()),
            NodeType::VideoEffect => Node::VideoEffect(self.downcast_node().unwrap()),
            NodeType::VideoTransform => Node::VideoTransform(self.downcast_node().unwrap()),
        }
    }

    fn downcast_node<T: Clone + 'static>(&self) -> Option<T> {
        self.node.value().downcast_ref().ok().cloned()
    }
}
