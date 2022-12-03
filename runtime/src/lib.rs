use mizer_clock::SystemClock;
use std::ops::Deref;

pub use self::api::*;
pub use self::coordinator::CoordinatorRuntime;
pub use self::views::LayoutsView;
pub use mizer_execution_planner::*;

pub type DefaultRuntime = CoordinatorRuntime<SystemClock>;

mod api;
pub mod commands;
mod coordinator;
pub mod pipeline_access;
mod processor;
mod views;

use mizer_node::{NodePath, NodeType, PipelineNode};
use mizer_nodes::Node;
use mizer_pipeline::ProcessingNodeExt;

pub trait NodeDowncast {
    fn node_type(&self) -> NodeType;

    fn downcast(&self) -> Node {
        let node_type = self.node_type();
        match node_type {
            NodeType::Clock => Node::Clock(self.downcast_node(node_type).unwrap()),
            NodeType::Oscillator => Node::Oscillator(self.downcast_node(node_type).unwrap()),
            NodeType::DmxOutput => Node::DmxOutput(self.downcast_node(node_type).unwrap()),
            NodeType::Scripting => Node::Scripting(self.downcast_node(node_type).unwrap()),
            NodeType::Sequence => Node::Sequence(self.downcast_node(node_type).unwrap()),
            NodeType::Envelope => Node::Envelope(self.downcast_node(node_type).unwrap()),
            NodeType::Select => Node::Select(self.downcast_node(node_type).unwrap()),
            NodeType::Merge => Node::Merge(self.downcast_node(node_type).unwrap()),
            NodeType::Threshold => Node::Threshold(self.downcast_node(node_type).unwrap()),
            NodeType::Encoder => Node::Encoder(self.downcast_node(node_type).unwrap()),
            NodeType::Fixture => Node::Fixture(self.downcast_node(node_type).unwrap()),
            NodeType::Programmer => Node::Programmer(self.downcast_node(node_type).unwrap()),
            NodeType::Group => Node::Group(self.downcast_node(node_type).unwrap()),
            NodeType::Preset => Node::Preset(self.downcast_node(node_type).unwrap()),
            NodeType::Sequencer => Node::Sequencer(self.downcast_node(node_type).unwrap()),
            NodeType::IldaFile => Node::IldaFile(self.downcast_node(node_type).unwrap()),
            NodeType::Laser => Node::Laser(self.downcast_node(node_type).unwrap()),
            NodeType::Fader => Node::Fader(self.downcast_node(node_type).unwrap()),
            NodeType::Button => Node::Button(self.downcast_node(node_type).unwrap()),
            NodeType::MidiInput => Node::MidiInput(self.downcast_node(node_type).unwrap()),
            NodeType::MidiOutput => Node::MidiOutput(self.downcast_node(node_type).unwrap()),
            NodeType::OpcOutput => Node::OpcOutput(self.downcast_node(node_type).unwrap()),
            NodeType::PixelPattern => Node::PixelPattern(self.downcast_node(node_type).unwrap()),
            NodeType::PixelDmx => Node::PixelDmx(self.downcast_node(node_type).unwrap()),
            NodeType::OscInput => Node::OscInput(self.downcast_node(node_type).unwrap()),
            NodeType::OscOutput => Node::OscOutput(self.downcast_node(node_type).unwrap()),
            NodeType::VideoFile => Node::VideoFile(self.downcast_node(node_type).unwrap()),
            NodeType::VideoColorBalance => {
                Node::VideoColorBalance(self.downcast_node(node_type).unwrap())
            }
            NodeType::VideoOutput => Node::VideoOutput(self.downcast_node(node_type).unwrap()),
            NodeType::VideoEffect => Node::VideoEffect(self.downcast_node(node_type).unwrap()),
            NodeType::VideoTransform => {
                Node::VideoTransform(self.downcast_node(node_type).unwrap())
            }
            NodeType::Gamepad => Node::Gamepad(self.downcast_node(node_type).unwrap()),
            NodeType::ColorHsv => Node::ColorHsv(self.downcast_node(node_type).unwrap()),
            NodeType::ColorRgb => Node::ColorRgb(self.downcast_node(node_type).unwrap()),
            NodeType::Container => Node::Container(self.downcast_node(node_type).unwrap()),
            NodeType::Math => Node::Math(self.downcast_node(node_type).unwrap()),
            NodeType::MqttInput => Node::MqttInput(self.downcast_node(node_type).unwrap()),
            NodeType::MqttOutput => Node::MqttOutput(self.downcast_node(node_type).unwrap()),
            NodeType::NumberToData => Node::NumberToData(self.downcast_node(node_type).unwrap()),
            NodeType::DataToNumber => Node::DataToNumber(self.downcast_node(node_type).unwrap()),
            NodeType::Value => Node::Value(self.downcast_node(node_type).unwrap()),
            NodeType::PlanScreen => Node::PlanScreen(self.downcast_node(node_type).unwrap()),
            NodeType::Delay => Node::Delay(self.downcast_node(node_type).unwrap()),
            NodeType::TestSink => Node::TestSink(self.downcast_node(node_type).unwrap()),
        }
    }

    fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T>;
}

impl<'a> NodeDowncast for dashmap::mapref::one::Ref<'a, NodePath, Box<dyn PipelineNode>> {
    fn node_type(&self) -> NodeType {
        self.value().node_type()
    }

    fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T> {
        match self.value().downcast_ref::<T>() {
            Ok(node) => Some(node.clone()),
            Err(err) => {
                log::error!("Could not downcast node type {:?}: {:?}", node_type, err);
                None
            }
        }
    }
}

impl<'a> NodeDowncast for dashmap::mapref::multiple::RefMulti<'a, NodePath, Box<dyn PipelineNode>> {
    fn node_type(&self) -> NodeType {
        self.value().node_type()
    }

    fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T> {
        match self.value().downcast_ref::<T>() {
            Ok(node) => Some(node.clone()),
            Err(err) => {
                log::error!("Could not downcast node type {:?}: {:?}", node_type, err);
                None
            }
        }
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
