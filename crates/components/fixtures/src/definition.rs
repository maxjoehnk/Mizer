use crate::channels::FixtureChannelMode;

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureDefinition {
    pub id: String,
    pub name: String,
    pub manufacturer: String,
    pub modes: Vec<FixtureChannelMode>,
    pub physical: PhysicalFixtureData,
    pub tags: Vec<String>,
    pub provider: &'static str,
}

impl FixtureDefinition {
    pub fn get_mode(&self, name: &str) -> Option<&FixtureChannelMode> {
        self.modes.iter().find(|mode| mode.name.as_str() == name)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Default)]
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
