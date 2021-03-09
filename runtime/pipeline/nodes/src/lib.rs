use crate::Node::{DmxOutput, MidiInput, OscInput};
use derive_more::From;
pub use mizer_clock_nodes::ClockNode;
pub use mizer_dmx_nodes::DmxOutputNode;
pub use mizer_fixture_nodes::FixtureNode;
pub use mizer_input_nodes::FaderNode;
pub use mizer_laser_nodes::{IldaFileNode, LaserNode};
pub use mizer_midi_nodes::{MidiInputNode, MidiOutputNode};
use mizer_node::NodeType;
pub use mizer_opc_nodes::OpcOutputNode;
pub use mizer_osc_nodes::OscInputNode;
pub use mizer_oscillator_nodes::OscillatorNode;
pub use mizer_pixel_nodes::{PixelDmxNode, PixelPatternGeneratorNode};
pub use mizer_scripting_nodes::ScriptingNode;
pub use mizer_sequence_nodes::SequenceNode;
pub use mizer_video_nodes::{
    VideoColorBalanceNode, VideoEffectNode, VideoFileNode, VideoOutputNode, VideoTransformNode,
};

#[derive(Debug, Clone, From)]
pub enum Node {
    Clock(ClockNode),
    Oscillator(OscillatorNode),
    DmxOutput(DmxOutputNode),
    Scripting(ScriptingNode),
    Sequence(SequenceNode),
    Fixture(FixtureNode),
    IldaFile(IldaFileNode),
    Laser(LaserNode),
    Fader(FaderNode),
    MidiInput(MidiInputNode),
    MidiOutput(MidiOutputNode),
    OpcOutput(OpcOutputNode),
    PixelPattern(PixelPatternGeneratorNode),
    PixelDmx(PixelDmxNode),
    OscInput(OscInputNode),
    VideoFile(VideoFileNode),
    VideoColorBalance(VideoColorBalanceNode),
    VideoOutput(VideoOutputNode),
    VideoEffect(VideoEffectNode),
    VideoTransform(VideoTransformNode),
}

impl From<NodeType> for Node {
    fn from(node_type: NodeType) -> Self {
        match node_type {
            NodeType::DmxOutput => DmxOutputNode::default().into(),
            NodeType::Oscillator => OscillatorNode::default().into(),
            NodeType::Clock => ClockNode::default().into(),
            NodeType::Scripting => ScriptingNode::default().into(),
            NodeType::Sequence => SequenceNode::default().into(),
            NodeType::Fixture => FixtureNode::default().into(),
            NodeType::IldaFile => IldaFileNode::default().into(),
            NodeType::Laser => LaserNode::default().into(),
            NodeType::Fader => FaderNode::default().into(),
            NodeType::OpcOutput => OpcOutputNode::default().into(),
            NodeType::PixelPattern => PixelPatternGeneratorNode::default().into(),
            NodeType::PixelDmx => PixelDmxNode::default().into(),
            NodeType::OscInput => OscInputNode::default().into(),
            NodeType::VideoFile => VideoFileNode::default().into(),
            NodeType::VideoTransform => VideoTransformNode::default().into(),
            NodeType::VideoColorBalance => VideoColorBalanceNode::default().into(),
            NodeType::VideoEffect => VideoEffectNode::default().into(),
            NodeType::VideoOutput => VideoOutputNode::default().into(),
            NodeType::MidiInput => MidiInputNode::default().into(),
            NodeType::MidiOutput => MidiOutputNode::default().into(),
        }
    }
}

impl Node {
    pub fn node_type(&self) -> NodeType {
        use Node::*;
        match self {
            Clock(_) => NodeType::Clock,
            Oscillator(_) => NodeType::Oscillator,
            DmxOutput(_) => NodeType::DmxOutput,
            Scripting(_) => NodeType::Scripting,
            Sequence(_) => NodeType::Sequence,
            Fixture(_) => NodeType::Fixture,
            IldaFile(_) => NodeType::IldaFile,
            Laser(_) => NodeType::Laser,
            Fader(_) => NodeType::Fader,
            MidiInput(_) => NodeType::MidiInput,
            MidiOutput(_) => NodeType::MidiOutput,
            OpcOutput(_) => NodeType::OpcOutput,
            PixelPattern(_) => NodeType::PixelPattern,
            PixelDmx(_) => NodeType::PixelDmx,
            OscInput(_) => NodeType::OscInput,
            VideoFile(_) => NodeType::VideoFile,
            VideoColorBalance(_) => NodeType::VideoColorBalance,
            VideoOutput(_) => NodeType::VideoOutput,
            VideoEffect(_) => NodeType::VideoEffect,
            VideoTransform(_) => NodeType::VideoTransform,
        }
    }
}
