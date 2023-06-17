use std::fmt::{Display, Formatter};

use dashmap::DashMap;
use mizer_node::NodeSettingValue::Float;
use serde::{Deserialize, Serialize};

use crate::definition::{FixtureControlValue, FixtureFaderControl};

pub type Color = (f64, f64, f64);
#[derive(Debug, Deserialize, Serialize, Clone, Copy, PartialEq)]
pub enum Position {
    Pan(f64),
    Tilt(f64),
    PanTilt(f64, f64),
}

#[derive(Default, Debug, Deserialize, Serialize)]
pub struct Presets {
    pub intensity: DashMap<u32, Preset<f64>>,
    pub shutter: DashMap<u32, Preset<f64>>,
    pub color: DashMap<u32, Preset<Color>>,
    pub position: DashMap<u32, Preset<Position>>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum PresetType {
    Intensity,
    Shutter,
    Color,
    Position,
}

impl PresetType {
    pub fn contains_control(&self, control: &FixtureFaderControl) -> bool {
        match self {
            Self::Intensity => control == &FixtureFaderControl::Intensity,
            Self::Shutter => control == &FixtureFaderControl::Shutter,
            Self::Color => matches!(control, &FixtureFaderControl::ColorMixer(_)),
            Self::Position => matches!(
                control,
                &FixtureFaderControl::Pan | &FixtureFaderControl::Tilt
            ),
        }
    }
}

impl Display for PresetType {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

impl Presets {
    pub fn add(&self, preset: GenericPreset) {
        match preset {
            GenericPreset::Intensity(preset) => {
                self.intensity.insert(preset.id, preset);
            }
            GenericPreset::Shutter(preset) => {
                self.shutter.insert(preset.id, preset);
            }
            GenericPreset::Color(preset) => {
                self.color.insert(preset.id, preset);
            }
            GenericPreset::Position(preset) => {
                self.position.insert(preset.id, preset);
            }
        }
    }

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
            match preset.value {
                Position::Pan(pan) => vec![FixtureControlValue::Pan(pan)],
                Position::Tilt(tilt) => vec![FixtureControlValue::Tilt(tilt)],
                Position::PanTilt(pan, tilt) => vec![
                    FixtureControlValue::Pan(pan),
                    FixtureControlValue::Tilt(tilt),
                ],
            }
        } else {
            Default::default()
        }
    }

    pub(crate) fn next_id(&self, preset_type: PresetType) -> u32 {
        match preset_type {
            PresetType::Intensity => highest_preset_id(&self.intensity),
            PresetType::Shutter => highest_preset_id(&self.shutter),
            PresetType::Color => highest_preset_id(&self.color),
            PresetType::Position => highest_preset_id(&self.position),
        }
    }
}

fn highest_preset_id<TValue>(map: &DashMap<u32, TValue>) -> u32 {
    map.iter().map(|e| *e.key()).max().unwrap_or(1)
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct Preset<TValue> {
    pub id: u32,
    #[serde(default)]
    pub label: Option<String>,
    pub value: TValue,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash)]
pub enum PresetId {
    Intensity(u32),
    Shutter(u32),
    Color(u32),
    Position(u32),
}

impl Display for PresetId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub enum GenericPreset {
    Intensity(Preset<f64>),
    Shutter(Preset<f64>),
    Color(Preset<Color>),
    Position(Preset<Position>),
}

impl GenericPreset {
    pub fn id(&self) -> PresetId {
        match self {
            GenericPreset::Intensity(preset) => PresetId::Intensity(preset.id),
            GenericPreset::Shutter(preset) => PresetId::Shutter(preset.id),
            GenericPreset::Color(preset) => PresetId::Color(preset.id),
            GenericPreset::Position(preset) => PresetId::Position(preset.id),
        }
    }
}
