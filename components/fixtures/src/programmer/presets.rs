use crate::definition::FixtureControlValue;
use dashmap::DashMap;
use serde::{Deserialize, Serialize};

pub type Color = (f64, f64, f64);
pub type Position = (f64, f64);

#[derive(Default, Debug, Deserialize, Serialize)]
pub struct Presets {
    pub intensity: DashMap<u32, Preset<f64>>,
    pub shutter: DashMap<u32, Preset<f64>>,
    pub color: DashMap<u32, Preset<Color>>,
    pub position: DashMap<u32, Preset<Position>>,
}

impl Presets {
    pub fn intensity_presets(&self) -> Vec<(PresetId, Preset<f64>)> {
        self.intensity
            .iter()
            .map(|preset| (PresetId::Intensity(preset.id), preset.clone()))
            .collect()
    }

    pub fn shutter_presets(&self) -> Vec<(PresetId, Preset<f64>)> {
        self.shutter
            .iter()
            .map(|preset| (PresetId::Shutter(preset.id), preset.clone()))
            .collect()
    }

    pub fn color_presets(&self) -> Vec<(PresetId, Preset<Color>)> {
        self.color
            .iter()
            .map(|preset| (PresetId::Color(preset.id), preset.clone()))
            .collect()
    }

    pub fn position_presets(&self) -> Vec<(PresetId, Preset<Position>)> {
        self.position
            .iter()
            .map(|preset| (PresetId::Position(preset.id), preset.clone()))
            .collect()
    }

    pub fn clear(&self) {
        self.intensity.clear();
        self.shutter.clear();
        self.color.clear();
        self.position.clear();
    }

    pub fn get_preset_values(&self, id: PresetId) -> Vec<FixtureControlValue> {
        match id {
            PresetId::Intensity(id) => self
                .intensity
                .get(&id)
                .map(|value| vec![FixtureControlValue::Intensity(value.value)])
                .unwrap_or_default(),
            PresetId::Shutter(id) => self
                .intensity
                .get(&id)
                .map(|value| vec![FixtureControlValue::Shutter(value.value)])
                .unwrap_or_default(),
            PresetId::Color(id) => Self::color_value(&self.color, id),
            PresetId::Position(id) => Self::position_value(&self.position, id),
        }
    }

    fn color_value(presets: &DashMap<u32, Preset<Color>>, id: u32) -> Vec<FixtureControlValue> {
        if let Some(preset) = presets.get(&id) {
            vec![FixtureControlValue::ColorMixer(
                preset.value.0,
                preset.value.1,
                preset.value.2,
            )]
        } else {
            Default::default()
        }
    }

    fn position_value(
        presets: &DashMap<u32, Preset<Position>>,
        id: u32,
    ) -> Vec<FixtureControlValue> {
        if let Some(preset) = presets.get(&id) {
            vec![
                FixtureControlValue::Pan(preset.value.0),
                FixtureControlValue::Tilt(preset.value.1),
            ]
        } else {
            Default::default()
        }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Preset<TValue> {
    pub id: u32,
    #[serde(default)]
    pub label: Option<String>,
    pub value: TValue,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub enum PresetId {
    Intensity(u32),
    Shutter(u32),
    Color(u32),
    Position(u32),
}
