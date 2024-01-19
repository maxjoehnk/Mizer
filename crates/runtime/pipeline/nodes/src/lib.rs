use derive_more::From;
use serde::{Deserialize, Serialize};

pub use mizer_audio_nodes::{
    AudioFileNode, AudioInputNode, AudioMeterNode, AudioMixNode, AudioOutputNode, AudioVolumeNode,
    PlaybackMode,
};
pub use mizer_clock_nodes::ClockNode;
pub use mizer_color_nodes::{
    ColorBrightnessNode, ColorToHsvNode, ConstantColorNode, HsvColorNode, RgbColorNode,
};
pub use mizer_constant_nodes::ConstantNumberNode;
pub use mizer_conversion_nodes::{
    DataToNumberNode, MultiToDataNode, NumberToClockNode, NumberToDataNode,
};
pub use mizer_data_nodes::{ExtractNode, TemplateNode, ValueNode};
pub use mizer_dmx_nodes::{DmxInputNode, DmxOutputNode};
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
pub use mizer_ndi_nodes::{NdiInputNode, NdiOutputNode};
use mizer_node::{ConfigurableNode, Injector, NodeDetails, NodeSetting, NodeType, PipelineNode};
pub use mizer_opc_nodes::OpcOutputNode;
pub use mizer_osc_nodes::{OscArgumentType, OscInputNode, OscOutputNode};
pub use mizer_oscillator_nodes::{OscillatorNode, OscillatorType};
pub use mizer_pixel_nodes::{Pattern, PixelDmxNode, PixelPatternGeneratorNode};
pub use mizer_plan_nodes::PlanScreenNode;
pub use mizer_port_operation_nodes::{
    CombineNode, ConditionalNode, EncoderNode, MergeMode, MergeNode, NoiseNode, RampNode,
    SelectNode, ThresholdNode,
};
pub use mizer_pro_dj_link_nodes::{PioneerCdjNode, ProDjLinkClockNode};
pub use mizer_screen_capture_nodes::ScreenCaptureNode;
pub use mizer_scripting_nodes::ScriptingNode;
pub use mizer_sequencer_nodes::SequencerNode;
pub use mizer_step_sequencer_nodes::StepSequencerNode;
pub use mizer_surface_nodes::SurfaceMappingNode;
pub use mizer_text_nodes::VideoTextNode;
pub use mizer_timecode_nodes::{TimecodeControlNode, TimecodeOutputNode, TimecodeRecorderNode};
pub use mizer_timing_nodes::{CountdownNode, DelayNode, TimeTriggerNode};
pub use mizer_transport_nodes::{BeatsNode, TransportNode};
pub use mizer_vector_nodes::{RasterizeVectorNode, VectorFileNode};
pub use mizer_video_nodes::{
    ColorizeTextureNode, ImageFileNode, LumaKeyNode, TextureBorderNode, TextureMaskNode,
    TextureOpacityNode, VideoFileNode, VideoHsvNode, VideoMixerNode, VideoOutputNode, VideoRgbNode,
    VideoRgbSplitNode, VideoTransformNode,
};
pub use mizer_webcam_nodes::WebcamNode;

use crate::test_sink::TestSink;

pub use self::container_node::ContainerNode;

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
    DmxInput(DmxInputNode),
    Scripting(ScriptingNode),
    StepSequencer(StepSequencerNode),
    Envelope(EnvelopeNode),
    Merge(MergeNode),
    Combine(CombineNode),
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
    ImageFile(ImageFileNode),
    VideoOutput(VideoOutputNode),
    VideoTransform(VideoTransformNode),
    VideoMixer(VideoMixerNode),
    VideoHsv(VideoHsvNode),
    VideoRgb(VideoRgbNode),
    VideoRgbSplit(VideoRgbSplitNode),
    VideoText(VideoTextNode),
    ColorizeTexture(ColorizeTextureNode),
    TextureBorder(TextureBorderNode),
    TextureMask(TextureMaskNode),
    TextureOpacity(TextureOpacityNode),
    LumaKey(LumaKeyNode),
    Webcam(WebcamNode),
    ScreenCapture(ScreenCaptureNode),
    Gamepad(GamepadNode),
    ColorConstant(ConstantColorNode),
    ColorBrightness(ColorBrightnessNode),
    ColorRgb(RgbColorNode),
    ColorHsv(HsvColorNode),
    ColorToHsv(ColorToHsvNode),
    Container(ContainerNode),
    Math(MathNode),
    MqttInput(MqttInputNode),
    MqttOutput(MqttOutputNode),
    NumberToData(NumberToDataNode),
    DataToNumber(DataToNumberNode),
    MultiToData(MultiToDataNode),
    NumberToClock(NumberToClockNode),
    PlanScreen(PlanScreenNode),
    Value(ValueNode),
    Extract(ExtractNode),
    Delay(DelayNode),
    Countdown(CountdownNode),
    TimeTrigger(TimeTriggerNode),
    Ramp(RampNode),
    Transport(TransportNode),
    Beats(BeatsNode),
    Noise(NoiseNode),
    G13Input(G13InputNode),
    G13Output(G13OutputNode),
    ConstantNumber(ConstantNumberNode),
    Conditional(ConditionalNode),
    TimecodeControl(TimecodeControlNode),
    TimecodeOutput(TimecodeOutputNode),
    TimecodeRecorder(TimecodeRecorderNode),
    AudioFile(AudioFileNode),
    AudioOutput(AudioOutputNode),
    AudioVolume(AudioVolumeNode),
    AudioInput(AudioInputNode),
    AudioMix(AudioMixNode),
    AudioMeter(AudioMeterNode),
    ProDjLinkClock(ProDjLinkClockNode),
    PioneerCdj(PioneerCdjNode),
    Template(TemplateNode),
    NdiOutput(NdiOutputNode),
    NdiInput(NdiInputNode),
    SurfaceMapping(SurfaceMappingNode),
    RasterizeVector(RasterizeVectorNode),
    VectorFile(VectorFileNode),
}
