pub use self::container_node::ContainerNode;
use crate::test_sink::TestSink;
use derive_more::From;
pub use mizer_clock_nodes::ClockNode;
pub use mizer_color_nodes::{HsvColorNode, RgbColorNode};
pub use mizer_dmx_nodes::DmxOutputNode;
pub use mizer_envelope_nodes::EnvelopeNode;
pub use mizer_fixture_nodes::{FixtureNode, GroupNode, PresetNode, ProgrammerNode};
pub use mizer_gamepad_nodes::{GamepadControl, GamepadNode};
pub use mizer_input_nodes::{ButtonNode, FaderNode};
pub use mizer_laser_nodes::{IldaFileNode, LaserNode};
pub use mizer_math_nodes::{MathMode, MathNode};
pub use mizer_midi_nodes::{MidiInputConfig, MidiInputNode, MidiOutputConfig, MidiOutputNode};
use mizer_node::{Injector, NodeType};
pub use mizer_opc_nodes::OpcOutputNode;
pub use mizer_osc_nodes::{OscArgumentType, OscInputNode, OscOutputNode};
pub use mizer_oscillator_nodes::{OscillatorNode, OscillatorType};
pub use mizer_pixel_nodes::{Pattern, PixelDmxNode, PixelPatternGeneratorNode};
pub use mizer_port_operation_nodes::{
    EncoderNode, MergeMode, MergeNode, SelectNode, ThresholdNode,
};
pub use mizer_scripting_nodes::ScriptingNode;
pub use mizer_sequence_nodes::{SequenceNode, SequenceStep};
pub use mizer_sequencer_nodes::SequencerNode;
pub use mizer_video_nodes::{
    VideoColorBalanceNode, VideoEffectNode, VideoFileNode, VideoOutputNode, VideoTransformNode,
};
use serde::{Deserialize, Serialize};

mod container_node;
#[doc(hidden)]
pub mod test_sink;

#[derive(Debug, Clone, From, Deserialize, Serialize)]
pub enum Node {
    Clock(ClockNode),
    Oscillator(OscillatorNode),
    DmxOutput(DmxOutputNode),
    Scripting(ScriptingNode),
    Sequence(SequenceNode),
    Envelope(EnvelopeNode),
    Merge(MergeNode),
    Select(SelectNode),
    Threshold(ThresholdNode),
    Encoder(EncoderNode),
    Fixture(FixtureNode),
    Programmer(ProgrammerNode),
    Sequencer(SequencerNode),
    Group(GroupNode),
    Preset(PresetNode),
    IldaFile(IldaFileNode),
    Laser(LaserNode),
    Fader(FaderNode),
    Button(ButtonNode),
    MidiInput(MidiInputNode),
    MidiOutput(MidiOutputNode),
    OpcOutput(OpcOutputNode),
    PixelPattern(PixelPatternGeneratorNode),
    PixelDmx(PixelDmxNode),
    OscInput(OscInputNode),
    OscOutput(OscOutputNode),
    VideoFile(VideoFileNode),
    VideoColorBalance(VideoColorBalanceNode),
    VideoOutput(VideoOutputNode),
    VideoEffect(VideoEffectNode),
    VideoTransform(VideoTransformNode),
    Gamepad(GamepadNode),
    ColorRgb(RgbColorNode),
    ColorHsv(HsvColorNode),
    Container(ContainerNode),
    Math(MathNode),
    // TODO: should only be available in tests
    #[doc(hidden)]
    TestSink(TestSink),
}

impl From<NodeType> for Node {
    fn from(node_type: NodeType) -> Self {
        match node_type {
            NodeType::DmxOutput => DmxOutputNode::default().into(),
            NodeType::Oscillator => OscillatorNode::default().into(),
            NodeType::Clock => ClockNode::default().into(),
            NodeType::Scripting => ScriptingNode::default().into(),
            NodeType::Envelope => EnvelopeNode::default().into(),
            NodeType::Sequence => SequenceNode::default().into(),
            NodeType::Merge => MergeNode::default().into(),
            NodeType::Select => SelectNode::default().into(),
            NodeType::Threshold => ThresholdNode::default().into(),
            NodeType::Encoder => EncoderNode::default().into(),
            NodeType::Fixture => FixtureNode::default().into(),
            NodeType::Programmer => ProgrammerNode::default().into(),
            NodeType::Group => GroupNode::default().into(),
            NodeType::Preset => PresetNode::default().into(),
            NodeType::Sequencer => SequencerNode::default().into(),
            NodeType::IldaFile => IldaFileNode::default().into(),
            NodeType::Laser => LaserNode::default().into(),
            NodeType::Fader => FaderNode::default().into(),
            NodeType::Button => ButtonNode::default().into(),
            NodeType::OpcOutput => OpcOutputNode::default().into(),
            NodeType::PixelPattern => PixelPatternGeneratorNode::default().into(),
            NodeType::PixelDmx => PixelDmxNode::default().into(),
            NodeType::OscInput => OscInputNode::default().into(),
            NodeType::OscOutput => OscOutputNode::default().into(),
            NodeType::VideoFile => VideoFileNode::default().into(),
            NodeType::VideoTransform => VideoTransformNode::default().into(),
            NodeType::VideoColorBalance => VideoColorBalanceNode::default().into(),
            NodeType::VideoEffect => VideoEffectNode::default().into(),
            NodeType::VideoOutput => VideoOutputNode::default().into(),
            NodeType::MidiInput => MidiInputNode::default().into(),
            NodeType::MidiOutput => MidiOutputNode::default().into(),
            NodeType::Gamepad => GamepadNode::default().into(),
            NodeType::ColorRgb => RgbColorNode::default().into(),
            NodeType::ColorHsv => HsvColorNode::default().into(),
            NodeType::Container => ContainerNode::default().into(),
            NodeType::Math => MathNode::default().into(),
            NodeType::TestSink => unimplemented!(),
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
            Envelope(_) => NodeType::Envelope,
            Merge(_) => NodeType::Merge,
            Select(_) => NodeType::Select,
            Threshold(_) => NodeType::Threshold,
            Encoder(_) => NodeType::Encoder,
            Fixture(_) => NodeType::Fixture,
            Programmer(_) => NodeType::Programmer,
            Group(_) => NodeType::Group,
            Preset(_) => NodeType::Preset,
            Sequencer(_) => NodeType::Sequencer,
            IldaFile(_) => NodeType::IldaFile,
            Laser(_) => NodeType::Laser,
            Fader(_) => NodeType::Fader,
            Button(_) => NodeType::Button,
            MidiInput(_) => NodeType::MidiInput,
            MidiOutput(_) => NodeType::MidiOutput,
            OpcOutput(_) => NodeType::OpcOutput,
            PixelPattern(_) => NodeType::PixelPattern,
            PixelDmx(_) => NodeType::PixelDmx,
            OscInput(_) => NodeType::OscInput,
            OscOutput(_) => NodeType::OscOutput,
            VideoFile(_) => NodeType::VideoFile,
            VideoColorBalance(_) => NodeType::VideoColorBalance,
            VideoOutput(_) => NodeType::VideoOutput,
            VideoEffect(_) => NodeType::VideoEffect,
            VideoTransform(_) => NodeType::VideoTransform,
            Gamepad(_) => NodeType::Gamepad,
            ColorHsv(_) => NodeType::ColorHsv,
            ColorRgb(_) => NodeType::ColorRgb,
            Container(_) => NodeType::Container,
            Math(_) => NodeType::Math,
            TestSink(_) => NodeType::TestSink,
        }
    }

    pub fn prepare(&mut self, injector: &Injector) {
        if let Node::Fixture(node) = self {
            node.fixture_manager = injector.get().cloned();
        }
    }
}
