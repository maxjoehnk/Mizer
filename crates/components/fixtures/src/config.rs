use crate::fixture::FixtureConfiguration;
use crate::programmer::{Color, Position, Preset, Presets};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixtureConfig {
    pub id: u32,
    pub name: String,
    pub fixture: String,
    pub channel: u16,
    pub universe: Option<u16>,
    #[serde(default)]
    pub mode: Option<String>,
    #[serde(default)]
    pub configuration: FixtureConfiguration,
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct PresetsStore {
    #[serde(default)]
    pub intensity: Vec<Preset<f64>>,
    #[serde(default)]
    pub shutter: Vec<Preset<f64>>,
    #[serde(default)]
    pub color: Vec<Preset<Color>>,
    #[serde(default)]
    pub position: Vec<Preset<Position>>,
}

impl PresetsStore {
    pub fn load(&self, presets: &Presets) {
        for preset in self.intensity.iter() {
            presets.intensity.insert(preset.id, preset.clone());
        }
        for preset in self.shutter.iter() {
            presets.shutter.insert(preset.id, preset.clone());
        }
        for preset in self.color.iter() {
            presets.color.insert(preset.id, preset.clone());
        }
        for preset in self.position.iter() {
            presets.position.insert(preset.id, preset.clone());
        }
    }

    pub fn store(presets: &Presets) -> Self {
        let intensity = presets
            .intensity
            .iter()
            .map(|entry| entry.value().clone())
            .collect();
        let shutter = presets
            .shutter
            .iter()
            .map(|entry| entry.value().clone())
            .collect();
        let color = presets
            .color
            .iter()
            .map(|entry| entry.value().clone())
            .collect();
        let position = presets
            .position
            .iter()
            .map(|entry| entry.value().clone())
            .collect();

        Self {
            intensity,
            shutter,
            color,
            position,
        }
    }
}
