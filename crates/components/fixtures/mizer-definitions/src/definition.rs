use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct MizerFixtureDefinition {
    #[serde(rename = "definition")]
    pub metadata: MizerFixtureDefinitionMetadata,
    #[serde(rename = "mode")]
    pub modes: Vec<MizerFixtureMode>,
    #[serde(rename = "channel")]
    pub channels: Vec<MizerFixtureChannel>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct MizerFixtureDefinitionMetadata {
    pub name: String,
    pub manufacturer: String,
    pub tags: Vec<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct MizerFixtureMode {
    pub name: String,
    #[serde(default, rename = "pixel")]
    pub pixels: Vec<MizerFixturePixel>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct MizerFixturePixel {
    pub name: String,
    pub channels: Vec<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct MizerFixtureChannel {
    pub name: String,
    pub control: MizerFixtureControl,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize)]
#[serde(rename_all = "snake_case")]
pub enum MizerFixtureControl {
    Intensity,
    Shutter,
    ColorRed,
    ColorGreen,
    ColorBlue,
}
