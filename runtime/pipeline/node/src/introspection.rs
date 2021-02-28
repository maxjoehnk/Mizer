use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct NodeDetails {
    pub name: String,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub enum NodeType {
    Fader,
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
