use crate::PreviewType;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct NodeDetails {
    pub name: String,
    pub preview_type: PreviewType,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
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
    Envelope,
    Sequence,
    MidiInput,
    MidiOutput,
    Laser,
    IldaFile,
    Select,
    Merge,
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
            Envelope => "envelope",
            Sequence => "sequence",
            MidiInput => "midi-input",
            MidiOutput => "midi-output",
            Laser => "laser",
            IldaFile => "ilda-file",
            Select => "select",
            Merge => "merge",
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

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct NodePosition {
    pub x: f64,
    pub y: f64,
}
