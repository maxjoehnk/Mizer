use std::fmt::{Display, Formatter};

use dashmap::DashMap;
use serde::{Deserialize, Serialize};
use crate::channels::{FixtureChannel, FixtureChannelValue, FixtureColorChannel};

pub type Color = (f64, f64, f64);
#[derive(Debug, Deserialize, Serialize, Clone, Copy, PartialEq)]
pub enum Position {
    Pan(f64),
    Tilt(f64),
    PanTilt(f64, f64),
}

impl Position {
    pub fn from_pan_tilt(pan: Option<f64>, tilt: Option<f64>) -> Option<Position> {
        match (pan, tilt) {
            (Some(pan), Some(tilt)) => Some(Self::PanTilt(pan, tilt)),
            (Some(pan), None) => Some(Self::Pan(pan)),
            (None, Some(tilt)) => Some(Self::Tilt(tilt)),
            (None, None) => None,
        }
    }
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
    pub fn contains_channel(&self, control: &FixtureChannel) -> bool {
        match self {
            Self::Intensity => matches!(control, &FixtureChannel::Intensity),
            Self::Shutter => matches!(control, &FixtureChannel::Shutter(_)),
            Self::Color => matches!(control, &FixtureChannel::ColorMixer(_)),
            Self::Position => matches!(
                control,
                &FixtureChannel::Pan | &FixtureChannel::Tilt
            ),
        }
    }
}

impl Display for PresetType {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

pub enum PresetValue {
    Intensity(f64),
    Shutter(f64),
    Color(Color),
    Position(Position),
}

impl PresetValue {
    pub fn into_channel_values(self) -> Vec<FixtureChannelValue> {
        match self {
            Self::Intensity(value) => vec![FixtureChannelValue {
                channel: FixtureChannel::Intensity,
                value: value.into(),
            }],
            Self::Shutter(value) => vec![FixtureChannelValue {
                channel: FixtureChannel::Shutter(1),
                value: value.into(),
            }],
            Self::Color((red, green, blue)) => vec![
                FixtureChannelValue {
                    channel: FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                    value: red.into(),
                },
                FixtureChannelValue {
                    channel: FixtureChannel::ColorMixer(FixtureColorChannel::Green),
                    value: green.into(),
                },
                FixtureChannelValue {
                    channel: FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
                    value: blue.into(),
                },
            ],
            Self::Position(Position::Pan(pan)) => vec![FixtureChannelValue {
                channel: FixtureChannel::Pan,
                value: pan.into(),
            }],
            Self::Position(Position::Tilt(tilt)) => vec![FixtureChannelValue {
                channel: FixtureChannel::Tilt,
                value: tilt.into(),
            }],
            Self::Position(Position::PanTilt(pan, tilt)) => vec![
                FixtureChannelValue {
                    channel: FixtureChannel::Pan,
                    value: pan.into(),
                },
                FixtureChannelValue {
                    channel: FixtureChannel::Tilt,
                    value: tilt.into(),
                },
            ],
        }
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

    pub fn get(&self, id: &PresetId) -> Option<GenericPreset> {
        match id {
            PresetId::Intensity(id) => self
                .intensity
                .get(id)
                .map(|p| GenericPreset::Intensity(p.clone())),
            PresetId::Shutter(id) => self
                .shutter
                .get(id)
                .map(|p| GenericPreset::Shutter(p.clone())),
            PresetId::Color(id) => self.color.get(id).map(|p| GenericPreset::Color(p.clone())),
            PresetId::Position(id) => self
                .position
                .get(id)
                .map(|p| GenericPreset::Position(p.clone())),
        }
    }

    pub fn get_mut(&self, id: &PresetId) -> Option<GenericPresetMut> {
        match id {
            PresetId::Intensity(id) => self.intensity.get_mut(id).map(GenericPresetMut::Intensity),
            PresetId::Shutter(id) => self.shutter.get_mut(id).map(GenericPresetMut::Shutter),
            PresetId::Color(id) => self.color.get_mut(id).map(GenericPresetMut::Color),
            PresetId::Position(id) => self.position.get_mut(id).map(GenericPresetMut::Position),
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

    pub fn get_preset_values(&self, id: PresetId) -> Option<PresetValue> {
        match id {
            PresetId::Intensity(id) => self
                .intensity
                .get(&id)
                .map(|value| PresetValue::Intensity(value.value)),
            PresetId::Shutter(id) => self
                .shutter
                .get(&id)
                .map(|value| PresetValue::Shutter(value.value)),
            PresetId::Color(id) => self
                .color
                .get(&id)
                .map(|value| PresetValue::Color(value.value)),
            PresetId::Position(id) => self
                .position
                .get(&id)
                .map(|value| PresetValue::Position(value.value)),
        }
    }

    pub(crate) fn next_id(&self, preset_type: PresetType) -> u32 {
        let highest_id = match preset_type {
            PresetType::Intensity => highest_preset_id(&self.intensity),
            PresetType::Shutter => highest_preset_id(&self.shutter),
            PresetType::Color => highest_preset_id(&self.color),
            PresetType::Position => highest_preset_id(&self.position),
        };

        highest_id + 1
    }
}

fn highest_preset_id<TValue>(map: &DashMap<u32, TValue>) -> u32 {
    map.iter().map(|e| *e.key()).max().unwrap_or_default()
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

impl PresetId {
    pub fn preset_type(&self) -> PresetType {
        match self {
            Self::Intensity(_) => PresetType::Intensity,
            Self::Shutter(_) => PresetType::Shutter,
            Self::Color(_) => PresetType::Color,
            Self::Position(_) => PresetType::Position,
        }
    }

    pub fn is_intensity(&self) -> bool {
        matches!(self, Self::Intensity(_))
    }

    pub fn is_shutter(&self) -> bool {
        matches!(self, Self::Shutter(_))
    }

    pub fn is_color(&self) -> bool {
        matches!(self, Self::Color(_))
    }

    pub fn is_position(&self) -> bool {
        matches!(self, Self::Position(_))
    }
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

    pub fn label(&self) -> Option<&String> {
        match self {
            GenericPreset::Intensity(preset) => preset.label.as_ref(),
            GenericPreset::Shutter(preset) => preset.label.as_ref(),
            GenericPreset::Color(preset) => preset.label.as_ref(),
            GenericPreset::Position(preset) => preset.label.as_ref(),
        }
    }
}

pub enum GenericPresetMut<'a> {
    Intensity(dashmap::mapref::one::RefMut<'a, u32, Preset<f64>>),
    Shutter(dashmap::mapref::one::RefMut<'a, u32, Preset<f64>>),
    Color(dashmap::mapref::one::RefMut<'a, u32, Preset<Color>>),
    Position(dashmap::mapref::one::RefMut<'a, u32, Preset<Position>>),
}

impl GenericPresetMut<'_> {
    pub fn name_mut(&mut self) -> &mut Option<String> {
        match self {
            GenericPresetMut::Intensity(preset) => &mut preset.label,
            GenericPresetMut::Shutter(preset) => &mut preset.label,
            GenericPresetMut::Color(preset) => &mut preset.label,
            GenericPresetMut::Position(preset) => &mut preset.label,
        }
    }
}
