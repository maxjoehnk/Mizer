use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct NodeDetails {
    pub name: String,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub enum NodeType {
    Fader,
    Button,
    DmxOutput,
    Oscillator,
    Clock,
    OscInput,
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
    Sequence,
    MidiInput,
    MidiOutput,
    Laser,
    IldaFile,
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
            Sequence => "sequence",
            MidiInput => "midi-input",
            MidiOutput => "midi-output",
            Laser => "laser",
            IldaFile => "ilda-file",
        }.to_string()
    }
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct NodeDesigner {
    pub position: NodePosition,
    pub scale: f64,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct NodePosition {
    pub x: f64,
    pub y: f64,
}
