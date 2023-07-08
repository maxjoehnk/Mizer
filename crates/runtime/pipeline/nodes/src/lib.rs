pub use self::container_node::ContainerNode;
use crate::test_sink::TestSink;
use derive_more::From;
pub use mizer_audio_nodes::{
    AudioFileNode, AudioInputNode, AudioMeterNode, AudioMixNode, AudioOutputNode, AudioVolumeNode,
    PlaybackMode,
};
pub use mizer_clock_nodes::ClockNode;
pub use mizer_color_nodes::{ColorBrightnessNode, ConstantColorNode, HsvColorNode, RgbColorNode};
pub use mizer_constant_nodes::ConstantNumberNode;
pub use mizer_conversion_nodes::{DataToNumberNode, NumberToDataNode};
pub use mizer_data_nodes::{ExtractNode, TemplateNode, ValueNode};
pub use mizer_dmx_nodes::DmxOutputNode;
pub use mizer_envelope_nodes::EnvelopeNode;
pub use mizer_fixture_nodes::{FixtureNode, GroupNode, PresetNode, ProgrammerNode};
pub use mizer_g13_nodes::{G13InputNode, G13Key, G13OutputNode};
pub use mizer_gamepad_nodes::{GamepadControl, GamepadNode};
pub use mizer_input_nodes::{ButtonNode, FaderNode, LabelNode};
pub use mizer_laser_nodes::{IldaFileNode, LaserNode};
pub use mizer_math_nodes::{MathMode, MathNode};
pub use mizer_midi_nodes::{
    MidiInputConfig, MidiInputNode, MidiOutputConfig, MidiOutputNode, NoteMode,
};
pub use mizer_mqtt_nodes::{MqttInputNode, MqttOutputNode};
use mizer_node::{ConfigurableNode, Injector, NodeDetails, NodeSetting, NodeType, PipelineNode};
pub use mizer_opc_nodes::OpcOutputNode;
pub use mizer_osc_nodes::{OscArgumentType, OscInputNode, OscOutputNode};
pub use mizer_oscillator_nodes::{OscillatorNode, OscillatorType};
pub use mizer_pixel_nodes::{Pattern, PixelDmxNode, PixelPatternGeneratorNode};
pub use mizer_plan_nodes::PlanScreenNode;
pub use mizer_port_operation_nodes::{
    ConditionalNode, EncoderNode, MergeMode, MergeNode, NoiseNode, RampNode, SelectNode,
    ThresholdNode,
};
pub use mizer_scripting_nodes::ScriptingNode;
pub use mizer_sequence_nodes::{SequenceNode, SequenceStep};
pub use mizer_sequencer_nodes::SequencerNode;
pub use mizer_timecode_nodes::{TimecodeControlNode, TimecodeOutputNode};
pub use mizer_timing_nodes::DelayNode;
pub use mizer_transport_nodes::TransportNode;
pub use mizer_video_nodes::{
    VideoColorBalanceNode, VideoFileNode, VideoMixerNode, VideoOutputNode, VideoRgbNode,
    VideoRgbSplitNode, VideoTransformNode,
};
use serde::{Deserialize, Serialize};

mod container_node;
mod downcast;
#[doc(hidden)]
pub mod test_sink;

macro_rules! node_impl {
    ($($node_type:ident($node:ty),)*) => {
        #[derive(Debug, Clone, From, Deserialize, Serialize, PartialEq)]
        #[serde(tag = "type", content = "config", rename_all = "kebab-case")]
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

            pub fn apply_to(&self, target: &mut dyn PipelineNode) -> anyhow::Result<()> {
                let node_type = target.node_type();
                match (node_type, self) {
                    $((NodeType::$node_type, Node::$node_type(config)) => {
                        let node: &mut $node = target.downcast_mut()?;
                        *node = config.clone();
                    },)*
                    (node_type, node) => anyhow::bail!(
                        "invalid node type {node_type:?} for given update {node:?}"
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

            pub fn details(&self) -> NodeDetails {
                match self {
                    $(Node::$node_type(node) => node.details(),)*
                    Node::TestSink(node) => node.details(),
                }
            }

            pub fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
                match self {
                    $(Node::$node_type(node) => node.settings(injector),)*
                    Node::TestSink(_) => vec![],
                }
            }

            pub fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
                match self {
                    $(Node::$node_type(node) => node.update_setting(setting),)*
                    Node::TestSink(_) => Ok(()),
                }
            }
        }

        pub trait NodeDowncast {
            fn node_type(&self) -> NodeType;

            fn downcast(&self) -> Node {
                let node_type = self.node_type();
                match node_type {
                    $(NodeType::$node_type => Node::$node_type(self.downcast_node(node_type).unwrap()),)*
                    NodeType::TestSink => Node::TestSink(self.downcast_node(node_type).unwrap()),
                }
            }

            fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T>;
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
    Label(LabelNode),
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
    VideoTransform(VideoTransformNode),
    VideoMixer(VideoMixerNode),
    VideoRgb(VideoRgbNode),
    VideoRgbSplit(VideoRgbSplitNode),
    Gamepad(GamepadNode),
    ColorConstant(ConstantColorNode),
    ColorBrightness(ColorBrightnessNode),
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
    Extract(ExtractNode),
    Delay(DelayNode),
    Ramp(RampNode),
    Transport(TransportNode),
    Noise(NoiseNode),
    G13Input(G13InputNode),
    G13Output(G13OutputNode),
    ConstantNumber(ConstantNumberNode),
    Conditional(ConditionalNode),
    TimecodeControl(TimecodeControlNode),
    TimecodeOutput(TimecodeOutputNode),
    AudioFile(AudioFileNode),
    AudioOutput(AudioOutputNode),
    AudioVolume(AudioVolumeNode),
    AudioInput(AudioInputNode),
    AudioMix(AudioMixNode),
    AudioMeter(AudioMeterNode),
    Template(TemplateNode),
}
