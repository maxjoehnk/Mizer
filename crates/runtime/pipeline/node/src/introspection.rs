use std::hash::{Hash, Hasher};

use enum_iterator::Sequence;
use num_enum::TryFromPrimitive;
use serde::{Deserialize, Serialize};

use crate::PreviewType;

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct NodeDetails {
    pub node_type_name: String,
    pub preview_type: PreviewType,
    pub category: NodeCategory,
}

macro_rules! node_type_name {
    (enum $name:ident {
        $($variant:ident),*,
    }) => {
        #[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize, Hash, Sequence)]
        #[serde(rename_all = "kebab-case")]
        pub enum $name {
            $($variant),*
        }

        impl $name {
            pub fn get_name(&self) -> String {
                use heck::ToKebabCase;

                match self {
                    $($name::$variant => stringify!($variant).to_kebab_case()),*
                }
            }
        }

        impl TryFrom<String> for $name {
            type Error = anyhow::Error;

            fn try_from(value: String) -> Result<Self, Self::Error> {
                use heck::ToPascalCase;

                let name = value.to_pascal_case();

                match name.as_str() {
                    $(stringify!($variant) => Ok($name::$variant)),*,
                    _ => Err(anyhow::anyhow!("Invalid node type {value}")),
                }
            }
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub enum NodeCategory {
    None,
    Standard,
    Connections,
    Conversions,
    Controls,
    Fixtures,
    Data,
    Color,
    Audio,
    Video,
    Laser,
    Pixel,
    Vector,
    Ui,
}

node_type_name! {
    enum NodeType {
        Fader,
        Button,
        Dial,
        Label,
        DmxInput,
        DmxOutput,
        Oscillator,
        Clock,
        OscInput,
        OscOutput,
        VideoFile,
        ImageFile,
        VideoOutput,
        VideoHsv,
        VideoTransform,
        VideoMixer,
        VideoRgb,
        VideoRgbSplit,
        VideoText,
        ColorizeTexture,
        TextureMask,
        TextureOpacity,
        LumaKey,
        StaticColor,
        Invert,
        Webcam,
        ScreenCapture,
        TextureBorder,
        DropShadow,
        Scripting,
        PixelDmx,
        PixelPattern,
        OpcOutput,
        Fixture,
        FixtureControl,
        Programmer,
        Sequencer,
        Group,
        GroupControl,
        Preset,
        Envelope,
        StepSequencer,
        MidiInput,
        MidiOutput,
        Laser,
        IldaFile,
        Gamepad,
        Select,
        Merge,
        Combine,
        Threshold,
        Ramp,
        Encoder,
        ColorConstant,
        ColorBrightness,
        ColorRgb,
        ColorHsv,
        ColorToHsv,
        Container,
        Math,
        MqttInput,
        MqttOutput,
        NumberToData,
        DataToNumber,
        DataToText,
        MultiToData,
        DataFile,
        NumberToClock,
        Value,
        Extract,
        PlanScreen,
        Delay,
        Countdown,
        TimeTrigger,
        Noise,
        Transport,
        Beats,
        G13Input,
        G13Output,
        ConstantNumber,
        Conditional,
        TimecodeControl,
        TimecodeOutput,
        TimecodeRecorder,
        AudioFile,
        AudioOutput,
        AudioVolume,
        AudioInput,
        AudioMix,
        AudioMeter,
        Template,
        ProDjLinkClock,
        PioneerCdj,
        NdiOutput,
        NdiInput,
        SurfaceMapping,
        RasterizeVector,
        VectorFile,
        Comparison,
        Dialog,
        // TODO: should only be available in tests
        // #[doc(hidden)]
        TestSink,
    }
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct NodeDesigner {
    pub position: NodePosition,
    pub scale: f64,
    #[serde(default)]
    pub hidden: bool,
    #[serde(default)]
    pub color: Option<NodeColor>,
}

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq, Hash, TryFromPrimitive)]
#[repr(u8)]
pub enum NodeColor {
    Grey = 1,
    Red = 2,
    DeepOrange = 3,
    Orange = 4,
    Amber = 5,
    Yellow = 6,
    Lime = 7,
    LightGreen = 8,
    Green = 9,
    Teal = 10,
    Cyan = 11,
    LightBlue = 12,
    Blue = 13,
    Indigo = 14,
    Purple = 15,
    DeepPurple = 16,
    Pink = 17,
    BlueGrey = 18,
    Brown = 19,
}

#[allow(clippy::derived_hash_with_manual_eq)]
impl Hash for NodeDesigner {
    fn hash<H: Hasher>(&self, state: &mut H) {
        state.write(format!("{:?}", self).as_bytes());
    }
}

#[derive(Default, Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub struct NodePosition {
    pub x: f64,
    pub y: f64,
}

#[allow(clippy::derived_hash_with_manual_eq)]
impl Hash for NodePosition {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.x.to_bits().hash(state);
        self.y.to_bits().hash(state);
    }
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct NodeMetadata {
    pub display_name: String,
    pub custom_name: Option<String>,
}

impl NodeMetadata {
    pub fn display_name(&self) -> &str {
        self.custom_name.as_deref().unwrap_or(&self.display_name)
    }
}
