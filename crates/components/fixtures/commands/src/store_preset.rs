use mizer_commander::{Command, Ref};
use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{
    Color, GenericPreset, Position, Preset, PresetId, PresetTarget, PresetType, PresetValue,
    Programmer, ProgrammerControlValue,
};
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::ops::DerefMut;

#[derive(Debug, Deserialize, Serialize)]
pub enum StorePresetCommand {
    Existing {
        preset_id: PresetId,
    },
    New {
        name: Option<String>,
        preset_type: PresetType,
        preset_target: Option<PresetTarget>,
    },
}

pub enum StorePresetState {
    Existing(GenericPreset),
    New(PresetId),
}

impl<'a> Command<'a> for StorePresetCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = StorePresetState;
    type Result = ();

    fn label(&self) -> String {
        match &self {
            Self::Existing { preset_id } => format!("Store in Preset {}", preset_id),
            Self::New {
                name, preset_type, ..
            } => format!(
                "Store {} Preset {}",
                preset_type,
                name.as_deref().unwrap_or_default()
            ),
        }
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let programmer = fixture_manager.get_programmer();
        let state = match &self {
            Self::Existing { preset_id } => {
                let before = fixture_manager
                    .presets
                    .get(&preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id:?}"))?;

                match preset_id {
                    PresetId::Intensity(id) => {
                        let mut preset = fixture_manager
                            .presets
                            .intensity
                            .get_mut(id)
                            .ok_or_else(|| anyhow::anyhow!("Unknown intensity preset {id:?}"))?;
                        apply_value(&programmer, preset.deref_mut(), get_intensity_value)?;
                    }
                    PresetId::Shutter(id) => {
                        let mut preset = fixture_manager
                            .presets
                            .shutter
                            .get_mut(id)
                            .ok_or_else(|| anyhow::anyhow!("Unknown shutter preset {id:?}"))?;

                        apply_value(&programmer, preset.deref_mut(), get_shutter_value)?;
                    }
                    PresetId::Color(id) => {
                        let mut preset = fixture_manager
                            .presets
                            .color
                            .get_mut(id)
                            .ok_or_else(|| anyhow::anyhow!("Unknown color preset {id:?}"))?;

                        apply_value(&programmer, preset.deref_mut(), get_color_value)?;
                    }
                    PresetId::Position(id) => {
                        let mut preset = fixture_manager
                            .presets
                            .position
                            .get_mut(id)
                            .ok_or_else(|| anyhow::anyhow!("Unknown position preset {id:?}"))?;

                        apply_value(&programmer, preset.deref_mut(), get_position_value)?;
                    }
                }

                StorePresetState::Existing(before)
            }
            Self::New {
                name,
                preset_type,
                preset_target,
            } => {
                let preset_target = match preset_target {
                    Some(preset_target) => *preset_target,
                    None => {
                        let value_count = match preset_type {
                            PresetType::Intensity => count_values_in_programmer(&programmer, get_intensity_value),
                            PresetType::Shutter => count_values_in_programmer(&programmer, get_shutter_value),
                            PresetType::Color => count_values_in_programmer(&programmer, get_color_value),
                            PresetType::Position => count_values_in_programmer(&programmer, get_position_value),
                        };

                        match value_count {
                            0 => anyhow::bail!("No values in programmer"),
                            1 => PresetTarget::Universal,
                            _ => PresetTarget::Selective,
                        }
                    }
                };

                let preset_id = match preset_type {
                    PresetType::Intensity => {
                        let value =
                            get_preset_value(&programmer, preset_target, get_intensity_value)?;

                        fixture_manager.add_intensity_preset(name.clone(), value)?
                    }
                    PresetType::Shutter => {
                        let value =
                            get_preset_value(&programmer, preset_target, get_shutter_value)?;

                        fixture_manager.add_shutter_preset(name.clone(), value)?
                    }
                    PresetType::Color => {
                        let value = get_preset_value(&programmer, preset_target, get_color_value)?;

                        fixture_manager.add_color_preset(name.clone(), value)?
                    }
                    PresetType::Position => {
                        let value = get_preset_value(&programmer, preset_target, get_position_value)?;

                        fixture_manager.add_position_preset(name.clone(), value)?
                    }
                };

                StorePresetState::New(preset_id)
            }
        };

        Ok(((), state))
    }

    fn revert(&self, fixture_manager: &FixtureManager, state: Self::State) -> anyhow::Result<()> {
        match state {
            StorePresetState::Existing(preset) => match preset {
                GenericPreset::Intensity(preset) => {
                    fixture_manager.presets.intensity.insert(preset.id, preset);
                }
                GenericPreset::Shutter(preset) => {
                    fixture_manager.presets.shutter.insert(preset.id, preset);
                }
                GenericPreset::Color(preset) => {
                    fixture_manager.presets.color.insert(preset.id, preset);
                }
                GenericPreset::Position(preset) => {
                    fixture_manager.presets.position.insert(preset.id, preset);
                }
            },
            StorePresetState::New(preset_id) => {
                fixture_manager
                    .delete_preset(preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id:?}"))?;
            }
        }

        Ok(())
    }
}

fn get_aggregated_programmer_channels(programmer: &Programmer) -> Vec<AggregatedProgrammerChannel> {
    let mut channels: HashMap<Vec<FixtureId>, Vec<ProgrammerControlValue>> = Default::default();

    for channel in programmer.get_channels() {
        let entry = channels.entry(channel.fixtures).or_default();

        entry.push(channel.value);
    }

    channels
        .into_iter()
        .flat_map(|(fixtures, controls)| {
            let mut pan = None;
            let mut tilt = None;
            let mut channels = Vec::default();

            for control in controls {
                match control {
                    ProgrammerControlValue::Preset(preset_id)
                        if matches!(preset_id, PresetId::Position(_)) =>
                    {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Position(preset_id.into()),
                        });
                    }
                    ProgrammerControlValue::Control(FixtureControlValue::Pan(pan_value)) => {
                        pan = Some(pan_value);
                    }
                    ProgrammerControlValue::Control(FixtureControlValue::Tilt(tilt_value)) => {
                        tilt = Some(tilt_value);
                    }
                    ProgrammerControlValue::Preset(preset_id)
                        if matches!(preset_id, PresetId::Intensity(_)) =>
                    {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Intensity(preset_id.into()),
                        });
                    }
                    ProgrammerControlValue::Control(FixtureControlValue::Intensity(intensity)) => {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Intensity(intensity.into()),
                        });
                    }
                    ProgrammerControlValue::Preset(preset_id)
                        if matches!(preset_id, PresetId::Shutter(_)) =>
                    {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Shutter(preset_id.into()),
                        });
                    }
                    ProgrammerControlValue::Control(FixtureControlValue::Shutter(shutter)) => {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Shutter(shutter.into()),
                        });
                    }
                    ProgrammerControlValue::Preset(preset_id)
                        if matches!(preset_id, PresetId::Color(_)) =>
                    {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Color(preset_id.into()),
                        });
                    }
                    ProgrammerControlValue::Control(FixtureControlValue::ColorMixer(
                        red,
                        green,
                        blue,
                    )) => {
                        channels.push(AggregatedProgrammerChannel {
                            fixtures: fixtures.clone(),
                            value: AggregatedProgrammerValue::Color((red, green, blue).into()),
                        });
                    }
                    _ => continue,
                }
            }

            if let Some(position) = Position::from_pan_tilt(pan, tilt) {
                channels.push(AggregatedProgrammerChannel {
                    fixtures: fixtures.clone(),
                    value: AggregatedProgrammerValue::Position(position.into()),
                });
            }

            channels
        })
        .collect()
}

struct AggregatedProgrammerChannel {
    fixtures: Vec<FixtureId>,
    value: AggregatedProgrammerValue,
}

enum AggregatedProgrammerValue {
    Intensity(PresetOrValue<f64>),
    Shutter(PresetOrValue<f64>),
    Color(PresetOrValue<Color>),
    Position(PresetOrValue<Position>),
}

// TODO: we already support preset references here, but support for actually storing them in presets will come later
#[derive(Debug, Clone, Copy)]
enum PresetOrValue<TValue> {
    Preset(PresetId),
    Value(TValue),
}

impl<TValue> PresetOrValue<TValue> {
    fn try_into_value(self) -> Option<TValue> {
        match self {
            PresetOrValue::Preset(_) => None,
            PresetOrValue::Value(value) => Some(value),
        }
    }
}

impl<TValue> From<PresetId> for PresetOrValue<TValue> {
    fn from(value: PresetId) -> Self {
        PresetOrValue::Preset(value)
    }
}

impl From<Color> for PresetOrValue<Color> {
    fn from(value: Color) -> Self {
        PresetOrValue::Value(value)
    }
}

impl From<Position> for PresetOrValue<Position> {
    fn from(value: Position) -> Self {
        PresetOrValue::Value(value)
    }
}

impl From<f64> for PresetOrValue<f64> {
    fn from(value: f64) -> Self {
        PresetOrValue::Value(value)
    }
}

fn count_values_in_programmer<TValue: Copy>(
    programmer: &Programmer,
    get_value: impl Fn(AggregatedProgrammerValue) -> Option<PresetOrValue<TValue>>,
) -> usize {
    get_aggregated_programmer_channels(programmer)
        .into_iter()
        .filter_map(|channel| get_value(channel.value))
        .count()
}

fn get_intensity_value(value: AggregatedProgrammerValue) -> Option<PresetOrValue<f64>> {
    if let AggregatedProgrammerValue::Intensity(value) = value {
        Some(value)
    } else {
        None
    }
}

fn get_shutter_value(value: AggregatedProgrammerValue) -> Option<PresetOrValue<f64>> {
    if let AggregatedProgrammerValue::Shutter(value) = value {
        Some(value)
    } else {
        None
    }
}

fn get_color_value(value: AggregatedProgrammerValue) -> Option<PresetOrValue<Color>> {
    if let AggregatedProgrammerValue::Color(value) = value {
        Some(value)
    } else {
        None
    }
}

fn get_position_value(value: AggregatedProgrammerValue) -> Option<PresetOrValue<Position>> {
    match value {
        AggregatedProgrammerValue::Position(value) => Some(value),
        _ => None,
    }
}

fn apply_value<TValue: Copy>(
    programmer: &Programmer,
    preset: &mut Preset<TValue>,
    get_value: impl Fn(AggregatedProgrammerValue) -> Option<PresetOrValue<TValue>>,
) -> anyhow::Result<()> {
    match &mut preset.value {
        PresetValue::Universal(value) => {
            *value = get_universal_value(programmer, get_value)?;
        }
        PresetValue::Selective(values) => {
            let new_values = get_selective_value(programmer, get_value);

            for (fixture_id, value) in new_values.iter() {
                values.insert(*fixture_id, *value);
            }
        }
    }

    Ok(())
}

fn get_preset_value<TValue: Copy>(
    programmer: &Programmer,
    preset_target: PresetTarget,
    get_value: impl Fn(AggregatedProgrammerValue) -> Option<PresetOrValue<TValue>>,
) -> anyhow::Result<PresetValue<TValue>> {
    let value = match preset_target {
        PresetTarget::Universal => {
            let value = get_universal_value(programmer, get_value)?;

            PresetValue::Universal(value)
        }
        PresetTarget::Selective => {
            let values = get_selective_value(programmer, get_value);

            PresetValue::Selective(values)
        }
    };

    Ok(value)
}

fn get_universal_value<TValue: Copy>(
    programmer: &Programmer,
    get_value: impl Fn(AggregatedProgrammerValue) -> Option<PresetOrValue<TValue>>,
) -> anyhow::Result<TValue> {
    let mut pan = None;
    let mut tilt = None;
    let mut values = Vec::new();
    for value in programmer.get_active_values() {
        match value {
            FixtureControlValue::Pan(pan_value) => pan = Some(pan_value),
            FixtureControlValue::Tilt(tilt_value) => tilt = Some(tilt_value),
            FixtureControlValue::Intensity(intensity) => {
                values.push(AggregatedProgrammerValue::Intensity(intensity.into()))
            }
            FixtureControlValue::Shutter(shutter) => {
                values.push(AggregatedProgrammerValue::Shutter(shutter.into()))
            }
            FixtureControlValue::ColorMixer(red, green, blue) => {
                values.push(AggregatedProgrammerValue::Color((red, green, blue).into()))
            }
            _ => continue,
        }
    }

    if let Some(position) = Position::from_pan_tilt(pan, tilt) {
        values.push(AggregatedProgrammerValue::Position(position.into()));
    }

    let value = values
        .into_iter()
        .find_map(|value| get_value(value))
        .and_then(|value| value.try_into_value());

    let value = value.ok_or_else(|| anyhow::anyhow!("No value found"))?;

    Ok(value)
}

fn get_selective_value<TValue: Copy>(
    programmer: &Programmer,
    get_value: impl Fn(AggregatedProgrammerValue) -> Option<PresetOrValue<TValue>>,
) -> HashMap<FixtureId, TValue> {
    let values = get_aggregated_programmer_channels(programmer)
        .into_iter()
        .filter_map(|channel| {
            let value = get_value(channel.value)?;
            let value = value.try_into_value()?;

            Some((channel.fixtures, value))
        })
        .flat_map(|(fixtures, value)| {
            fixtures
                .into_iter()
                .map(move |fixture_id| (fixture_id, value))
        })
        .collect();

    values
}
