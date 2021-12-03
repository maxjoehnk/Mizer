use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureDefinition {
    pub id: String,
    pub name: String,
    pub manufacturer: String,
    pub modes: Vec<FixtureMode>,
    pub physical: PhysicalFixtureData,
    pub tags: Vec<String>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct SubFixtureDefinition {
    pub id: u32,
    pub name: String,
    pub controls: FixtureControls,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureMode {
    pub name: String,
    pub channels: Vec<FixtureChannelDefinition>,
    pub controls: FixtureControls,
    pub sub_fixtures: Vec<SubFixtureDefinition>,
}

#[derive(Debug, Clone, PartialEq, Default)]
pub struct FixtureControls {
    pub intensity: Option<String>,
    pub shutter: Option<String>,
    pub color: Option<ColorGroup>,
    pub pan: Option<AxisGroup>,
    pub tilt: Option<AxisGroup>,
    pub focus: Option<String>,
    pub zoom: Option<String>,
    pub prism: Option<String>,
    pub iris: Option<String>,
    pub frost: Option<String>,
    pub generic: Vec<GenericControl>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum FixtureChannelGroupType {
    Generic(String),
    Color(ColorGroup),
    Pan(AxisGroup),
    Tilt(AxisGroup),
    Focus(String),
    Zoom(String),
    Prism(String),
    Intensity(String),
    Shutter(String),
    Iris(String),
    Frost(String),
}

#[derive(Debug, Clone, PartialEq)]
pub struct ColorGroup {
    pub red: String,
    pub green: String,
    pub blue: String,
}

#[derive(Debug, Clone, PartialEq)]
pub struct AxisGroup {
    pub channel: String,
    pub angle: Option<Angle>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Angle {
    pub from: f32,
    pub to: f32,
}

#[derive(Debug, Clone, PartialEq)]
pub struct GenericControl {
    pub label: String,
    pub channel: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum FixtureControl {
    Intensity,
    Shutter,
    Color(ColorChannel),
    Pan,
    Tilt,
    Focus,
    Zoom,
    Prism,
    Iris,
    Frost,
    Generic(String),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum ColorChannel {
    Red,
    Green,
    Blue
}

impl FixtureMode {
    pub(crate) fn dmx_channels(&self) -> u8 {
        self.channels.iter().map(|c| c.channels()).sum()
    }

    pub fn intensity(&self) -> Option<FixtureChannelDefinition> {
        self.controls
            .intensity
            .as_ref()
            .and_then(|channel| self.channels.iter().find(|c| &c.name == channel).cloned())
    }

    pub fn color(&self) -> Option<ColorGroup> {
        self.controls.color.clone()
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelDefinition {
    pub name: String,
    pub resolution: ChannelResolution,
}

impl FixtureChannelDefinition {
    fn channels(&self) -> u8 {
        match self.resolution {
            ChannelResolution::Coarse { .. } => 1,
            ChannelResolution::Fine { .. } => 2,
            ChannelResolution::Finest { .. } => 3,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum ChannelResolution {
    /// 8 Bit
    ///
    /// coarse
    Coarse(u8),
    /// 16 Bit
    ///
    /// coarse, fine
    Fine(u8, u8),
    /// 24 Bit
    ///
    /// coarse, fine, finest
    Finest(u8, u8, u8),
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct PhysicalFixtureData {
    pub dimensions: Option<FixtureDimensions>,
    pub weight: Option<f32>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct FixtureDimensions {
    pub width: f32,
    pub height: f32,
    pub depth: f32,
}
