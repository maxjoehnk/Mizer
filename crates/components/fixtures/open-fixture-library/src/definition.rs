use std::collections::HashMap;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AgLibraryFile {
    pub fixtures: Vec<OpenFixtureLibraryFixtureDefinition>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct OpenFixtureLibraryFixtureDefinition {
    pub name: String,
    pub short_name: Option<String>,
    #[serde(default)]
    pub categories: Vec<String>,
    #[serde(default)]
    pub available_channels: HashMap<String, Channel>,
    #[serde(default)]
    pub modes: Vec<Mode>,
    pub fixture_key: String,
    pub manufacturer: FixtureManufacturer,
    #[serde(default)]
    pub physical: Physical,
    #[serde(default)]
    pub matrix: Option<Matrix>,
    #[serde(default)]
    pub wheels: HashMap<String, WheelDefinition>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WheelDefinition {
    pub slots: Vec<WheelSlotDefinition>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "type")]
pub enum WheelSlotDefinition {
    Open,
    Closed,
    Color {
        #[serde(default)]
        name: Option<String>,
        #[serde(default)]
        colors: Vec<String>,
    },
    Gobo {
        #[serde(default)]
        name: Option<String>,
        #[serde(default)]
        resource: Option<Resource>,
    },
    Prism,
    Iris,
    Frost,
    AnimationGoboStart,
    AnimationGoboEnd,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FixtureManufacturer {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Channel {
    #[serde(default)]
    pub fine_channel_aliases: Vec<String>,
    pub default_value: Option<Value>,
    pub highlight_value: Option<Value>,
    pub capabilities: Vec<Capability>,
    #[serde(default)]
    pub pixel_key: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Value {
    Dmx(u32),
    Percentage(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CapabilityChannel {
    Single(SingleCapabilityChannel),
    Multi(MultiCapabilityChannel),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SingleCapabilityChannel {
    #[serde(flatten)]
    pub capability: Capability,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct MultiCapabilityChannel {
    pub dmx_range: (u16, u16),
    #[serde(flatten)]
    pub capability: Capability,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "type")]
pub enum Capability {
    Generic,
    Fog,
    FogOutput,
    FogType,
    Intensity,
    NoFunction,
    Maintenance,
    ColorIntensity {
        color: String,
    },
    ColorPreset {
        #[serde(default)]
        colors: Vec<String>,
    },
    ColorTemperature,
    Effect,
    EffectSpeed,
    EffectParameter,
    EffectDuration,
    ShutterStrobe {
        #[serde(rename = "shutterEffect")]
        shutter_effect: String,
        // #[serde(rename = "speedStart")]
        // speed_start: Option<u8>,
        // #[serde(rename = "speedEnd")]
        // speed_end: Option<u8>,
    },
    StrobeDuration,
    StrobeSpeed,
    SoundSensitivity,
    Pan {
        #[serde(rename = "angleStart")]
        angle_start: f32,
        #[serde(rename = "angleEnd")]
        angle_end: f32,
    },
    PanContinuous,
    Tilt {
        #[serde(rename = "angleStart")]
        angle_start: f32,
        #[serde(rename = "angleEnd")]
        angle_end: f32,
    },
    TiltContinuous,
    PanTiltSpeed,
    Rotation,
    WheelSlot(WheelSlot),
    WheelRotation,
    WheelSlotRotation,
    WheelShake,
    Prism,
    PrismRotation,
    Focus,
    Zoom,
    Iris,
    IrisEffect,
    Frost,
    FrostEffect,
    BladeRotation,
    BladeInsertion,
    BladeSystemRotation,
    Speed,
    Time,
    BeamPosition,
    BeamAngle,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum WheelSlot {
    Single {
        #[serde(rename = "slotNumber")]
        slot_number: f32,
        #[serde(rename = "dmxRange")]
        dmx_range: (u16, u16),
    },
    Range {
        #[serde(rename = "slotNumberStart")]
        slot_number_start: f32,
        #[serde(rename = "slotNumberEnd")]
        slot_number_end: f32,
    },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Mode {
    pub name: String,
    pub short_name: Option<String>,
    pub channels: Vec<Option<String>>,
}

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct Physical {
    #[serde(default)]
    pub dimensions: Vec<f32>,
    #[serde(default)]
    pub weight: Option<f32>,
    pub power: Option<f32>,
    #[serde(rename = "DMXconnector", default)]
    pub dmx_connector: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Matrix {
    #[serde(flatten)]
    pub pixels: MatrixPixels,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum MatrixPixels {
    PixelKeys(Vec<Vec<Vec<Option<String>>>>),
    PixelCount([u32; 3]),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Resource {
    pub name: String,
    pub key: String,
    #[serde(rename = "type")]
    pub resource_type: String,
    pub image: ResourceImage,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResourceImage {
    pub mime_type: String,
    pub extension: String,
    pub data: String,
    pub encoding: String,
}
