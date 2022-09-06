use crate::PreviewType;
use serde::{Deserialize, Serialize};
use std::hash::{Hash, Hasher};

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct NodeDetails {
    pub name: String,
    pub preview_type: PreviewType,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize, Hash)]
pub enum NodeType {
    Fader,
    Button,
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
    // TODO: should only be available in tests
    #[doc(hidden)]
    TestSink,
}

impl NodeType {
    pub fn get_name(&self) -> String {
        use NodeType::*;

        match self {
            Fader => "fader",
            Button => "button",
            DmxOutput => "dmx-output",
            Oscillator => "oscillator",
            Clock => "clock",
            OscInput => "osc-input",
            OscOutput => "osc-output",
            VideoFile => "video-file",
            VideoOutput => "video-output",
            VideoEffect => "video-effect",
            VideoColorBalance => "video-color-balance",
            VideoTransform => "video-transform",
            Scripting => "scripting",
            PixelDmx => "pixel-dmx",
            PixelPattern => "pixel-pattern",
            OpcOutput => "opc-output",
            Fixture => "fixture",
            Programmer => "programmer",
            Group => "group",
            Preset => "preset",
            Sequencer => "sequencer",
            Envelope => "envelope",
            Sequence => "sequence",
            MidiInput => "midi-input",
            MidiOutput => "midi-output",
            Laser => "laser",
            IldaFile => "ilda-file",
            Gamepad => "gamepad",
            Select => "select",
            Merge => "merge",
            Threshold => "threshold",
            Encoder => "encoder",
            ColorHsv => "color-hsv",
            ColorRgb => "color-rgb",
            Container => "container",
            Math => "math",
            MqttInput => "mqtt-input",
            MqttOutput => "mqtt-output",
            NumberToData => "number-to-data",
            DataToNumber => "data-to-number",
            Value => "value",
            TestSink => "test-sink",
        }
        .to_string()
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
