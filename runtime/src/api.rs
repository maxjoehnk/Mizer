use dashmap::mapref::one::Ref;

use dashmap::DashMap;
use mizer_clock::ClockSnapshot;
use mizer_layouts::Layout;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PipelineNode, PortId, PortMetadata};
use mizer_nodes::Node;
use pinboard::NonEmptyPinboard;
use std::collections::HashMap;
use std::sync::Arc;

#[derive(Clone)]
pub struct RuntimeAccess {
    pub nodes: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    pub layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    // TODO: make broadcast
    pub clock_recv: flume::Receiver<ClockSnapshot>,
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
            NodeType::Envelope => Node::Envelope(self.downcast_node().unwrap()),
            NodeType::Select => Node::Select(self.downcast_node().unwrap()),
            NodeType::Merge => Node::Merge(self.downcast_node().unwrap()),
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
