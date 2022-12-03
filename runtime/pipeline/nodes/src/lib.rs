pub use self::container_node::ContainerNode;
use crate::test_sink::TestSink;
use derive_more::From;
pub use mizer_clock_nodes::ClockNode;
pub use mizer_color_nodes::{HsvColorNode, RgbColorNode};
pub use mizer_conversion_nodes::{DataToNumberNode, NumberToDataNode};
pub use mizer_data_nodes::ValueNode;
pub use mizer_dmx_nodes::DmxOutputNode;
pub use mizer_envelope_nodes::EnvelopeNode;
pub use mizer_fixture_nodes::{FixtureNode, GroupNode, PresetNode, ProgrammerNode};
pub use mizer_gamepad_nodes::{GamepadControl, GamepadNode};
pub use mizer_input_nodes::{ButtonNode, FaderNode};
pub use mizer_laser_nodes::{IldaFileNode, LaserNode};
pub use mizer_math_nodes::{MathMode, MathNode};
pub use mizer_midi_nodes::{MidiInputConfig, MidiInputNode, MidiOutputConfig, MidiOutputNode};
pub use mizer_mqtt_nodes::{MqttInputNode, MqttOutputNode};
use mizer_node::{Injector, NodeType, PipelineNode, ProcessingNode};
pub use mizer_opc_nodes::OpcOutputNode;
pub use mizer_osc_nodes::{OscArgumentType, OscInputNode, OscOutputNode};
pub use mizer_oscillator_nodes::{OscillatorNode, OscillatorType};
pub use mizer_pixel_nodes::{Pattern, PixelDmxNode, PixelPatternGeneratorNode};
pub use mizer_plan_nodes::PlanScreenNode;
pub use mizer_port_operation_nodes::{
    EncoderNode, MergeMode, MergeNode, SelectNode, ThresholdNode,
};
pub use mizer_scripting_nodes::ScriptingNode;
pub use mizer_sequence_nodes::{SequenceNode, SequenceStep};
pub use mizer_sequencer_nodes::SequencerNode;
pub use mizer_timing_nodes::DelayNode;
pub use mizer_video_nodes::{
    VideoColorBalanceNode, VideoEffectNode, VideoFileNode, VideoOutputNode, VideoTransformNode,
};
use serde::{Deserialize, Serialize};

mod container_node;
#[doc(hidden)]
pub mod test_sink;

macro_rules! node_impl {
    ($($node_type:ident($node:ty),)*) => {
        #[derive(Debug, Clone, From, Deserialize, Serialize)]
        pub enum Node {
            $($node_type($node),)*
            // TODO: should only be available in tests
            #[doc(hidden)]
            TestSink(TestSink),
        }

        impl From<NodeType> for Node {
            fn from(node_type: NodeType) -> Self {
                match node_type {
                    $(NodeType::$node_type => <$node>::default().into(),)*
                    NodeType::TestSink => unimplemented!(),
                }
            }
        }

        impl Node {
            pub fn node_type(&self) -> NodeType {
                match self {
                    $(Node::$node_type(_) => NodeType::$node_type,)*
                    Node::TestSink(_) => NodeType::TestSink,
                }
            }

            pub fn update(&self, target: &mut dyn PipelineNode) -> anyhow::Result<()> {
                let node_type = target.node_type();
                match (node_type, self) {
                    $((NodeType::$node_type, Node::$node_type(config)) => {
                        let node: &mut $node = target.downcast_mut()?;
                        node.update(config);
                    },)*
                    (node_type, node) => log::warn!(
                        "invalid node type {:?} for given update {:?}",
                        node_type,
                        node
                    ),
                }

                Ok(())
            }

            pub fn prepare(&mut self, injector: &Injector) {
                match self {
                    $(Node::$node_type(node) => node.prepare(injector),)*
                    Node::TestSink(_) => {},
                }
            }
        }
    };
}

node_impl! {
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
    MqttInput(MqttInputNode),
    MqttOutput(MqttOutputNode),
    NumberToData(NumberToDataNode),
    DataToNumber(DataToNumberNode),
    PlanScreen(PlanScreenNode),
    Value(ValueNode),
    Delay(DelayNode),
}
