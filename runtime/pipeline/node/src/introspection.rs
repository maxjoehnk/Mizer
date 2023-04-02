use crate::PreviewType;
use serde::{Deserialize, Serialize};
use std::hash::{Hash, Hasher};

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct NodeDetails {
    pub name: String,
    pub preview_type: PreviewType,
}

macro_rules! node_type_name {
    (enum $name:ident {
        $($variant:ident),*,
    }) => {
        #[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize, Hash)]
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
    }
}

node_type_name! {
    enum NodeType {
        Fader,
        Button,
        Label,
        DmxOutput,
        Oscillator,
        Clock,
        OscInput,
        OscOutput,
        VideoFile,
        VideoOutput,
        VideoEffect,
        VideoColorBalance,
        VideoTransform,
        Scripting,
        PixelDmx,
        PixelPattern,
        OpcOutput,
        Fixture,
        Programmer,
        Sequencer,
        Group,
        Preset,
        Envelope,
        Sequence,
        MidiInput,
        MidiOutput,
        Laser,
        IldaFile,
        Gamepad,
        Select,
        Merge,
        Threshold,
        Ramp,
        Encoder,
        ColorRgb,
        ColorHsv,
        Container,
        Math,
        MqttInput,
        MqttOutput,
        NumberToData,
        DataToNumber,
        Value,
        PlanScreen,
        Delay,
        Noise,
        Transport,
        G13Input,
        G13Output,
        ConstantNumber,
        Conditional,
        TimecodeControl,
        TimecodeOutput,
        AudioFile,
        AudioOutput,
        AudioVolume,
        AudioInput,
        AudioMix,
        AudioMeter,
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
}

#[allow(clippy::derive_hash_xor_eq)]
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

#[allow(clippy::derive_hash_xor_eq)]
impl Hash for NodePosition {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.x.to_bits().hash(state);
        self.y.to_bits().hash(state);
    }
}
