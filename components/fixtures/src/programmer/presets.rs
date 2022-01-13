use dashmap::DashMap;
use serde::{Deserialize, Serialize};
use crate::definition::{ColorChannel, FixtureControl, FixtureFaderControl};

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
        self.intensity.iter().map(|preset| (PresetId::Intensity(preset.id), preset.clone())).collect()
    }

    pub fn shutter_presets(&self) -> Vec<(PresetId, Preset<f64>)> {
        self.shutter.iter().map(|preset| (PresetId::Shutter(preset.id), preset.clone())).collect()
    }

    pub fn color_presets(&self) -> Vec<(PresetId, Preset<Color>)> {
        self.color.iter().map(|preset| (PresetId::Color(preset.id), preset.clone())).collect()
    }

    pub fn position_presets(&self) -> Vec<(PresetId, Preset<Position>)> {
        self.position.iter().map(|preset| (PresetId::Position(preset.id), preset.clone())).collect()
    }

    pub fn clear(&self) {
        self.intensity.clear();
        self.shutter.clear();
        self.color.clear();
        self.position.clear();
    }

    pub fn get_preset_values(&self, id: PresetId) -> Vec<(FixtureFaderControl, f64)> {
        match id {
            PresetId::Intensity(id) => Self::fader_value(&self.intensity, FixtureFaderControl::Intensity, id),
            PresetId::Shutter(id) => Self::fader_value(&self.shutter, FixtureFaderControl::Shutter, id),
            PresetId::Color(id) => Self::color_value(&self.color, id),
            PresetId::Position(id) => Self::position_value(&self.position, id),
        }
    }

    fn fader_value(presets: &DashMap<u32, Preset<f64>>, control: FixtureFaderControl, id: u32) -> Vec<(FixtureFaderControl, f64)> {
        if let Some(preset) = presets.get(&id) {
            vec![(control, preset.value)]
        }else {
            Default::default()
        }
    }

    fn color_value(presets: &DashMap<u32, Preset<Color>>, id: u32) -> Vec<(FixtureFaderControl, f64)> {
        if let Some(preset) = presets.get(&id) {
            vec![
                (FixtureFaderControl::Color(ColorChannel::Red), preset.value.0),
                (FixtureFaderControl::Color(ColorChannel::Green), preset.value.1),
                (FixtureFaderControl::Color(ColorChannel::Blue), preset.value.2),
            ]
        }else {
            Default::default()
        }
    }

    fn position_value(presets: &DashMap<u32, Preset<Position>>, id: u32) -> Vec<(FixtureFaderControl, f64)> {
        if let Some(preset) = presets.get(&id) {
            vec![
                (FixtureFaderControl::Pan, preset.value.0),
                (FixtureFaderControl::Tilt, preset.value.1),
            ]
        }else {
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
