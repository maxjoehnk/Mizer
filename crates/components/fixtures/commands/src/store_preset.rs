use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{GenericPreset, PresetId, PresetTarget, PresetType, PresetValue, Programmer, ProgrammerControlValue};
use serde::{Deserialize, Serialize};
use mizer_fixtures::definition::{FixtureControl, FixtureControlValue, FixtureFaderControl};

#[derive(Debug, Deserialize, Serialize)]
pub enum StorePresetCommand {
    Existing(PresetId),
    New {
        name: Option<String>,
        preset_type: PresetType,
        preset_target: PresetTarget,
    }
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
            Self::Existing(preset_id) => format!("Store in Preset {}", preset_id),
            Self::New { name, preset_type, .. } => format!(
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
            Self::Existing(preset_id) => {
                let before = fixture_manager.presets.get(&preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id:?}"))?;
                
                match preset_id {
                    PresetId::Intensity(id) => {
                        let mut preset = fixture_manager.presets.intensity.get_mut(id)
                            .ok_or_else(|| anyhow::anyhow!("Unknown intensity preset {id:?}"))?;
                        match &mut preset.value {
                            PresetValue::Universal(value) => {
                                *value = get_universal_intensity(&programmer)?;
                            }
                            PresetValue::Selective(values) => {
                                todo!()
                            }
                        }
                    }
                    PresetId::Shutter(id) => {
                        let mut preset = fixture_manager.presets.shutter.get_mut(id)
                            .ok_or_else(|| anyhow::anyhow!("Unknown shutter preset {id:?}"))?;
                        match &mut preset.value {
                            PresetValue::Universal(value) => {
                                *value = get_universal_shutter(&programmer)?;
                            }
                            PresetValue::Selective(values) => {
                                todo!()
                            }
                        }
                    }
                    _ => todo!(),
                }
                
                StorePresetState::Existing(before)
            }
            Self::New { name, preset_type, preset_target } => {
                let preset_id = match preset_type {
                    PresetType::Intensity => {
                        let value = get_intensity_value(&programmer, *preset_target)?;

                        fixture_manager.add_intensity_preset(name.clone(), value)?
                    }
                    PresetType::Shutter => {
                        let value = get_shutter_value(&programmer, *preset_target)?;

                        fixture_manager.add_shutter_preset(name.clone(), value)?
                    }
                    _ => todo!(),
                };

                StorePresetState::New(preset_id)
            }
        };


        Ok(((), state))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        state: Self::State,
    ) -> anyhow::Result<()> {
        match state {
            StorePresetState::Existing(preset) => {
                todo!()
            }
            StorePresetState::New(preset_id) => {
                fixture_manager
                    .delete_preset(preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id:?}"))?;
            }
        }

        Ok(())
    }
}

fn get_intensity_value(programmer: &Programmer, preset_target: PresetTarget) -> anyhow::Result<PresetValue<f64>> {
    match preset_target {
        PresetTarget::Universal => {
            let value = get_universal_intensity(programmer)?;

            Ok(PresetValue::Universal(value))
        }
        PresetTarget::Selective => {
            let values = programmer.get_controls()
                .into_iter()
                .filter(|control| matches!(control.control, FixtureFaderControl::Intensity))
                .flat_map(|control| control.fixtures.get_fixtures()
                    .into_iter()
                    .flatten()
                    .map(move |fixture_id| (fixture_id, control.value)))
                .collect();

            Ok(PresetValue::Selective(values))
        }
    }
}

fn get_universal_intensity(programmer: &Programmer) -> anyhow::Result<f64> {
    let value = programmer.get_active_values()
        .into_iter()
        .filter_map(|value| {
            if let FixtureControlValue::Intensity(value) = value {
                Some(value)
            } else {
                None
            }
        })
        .next();
    let value = value.ok_or_else(|| anyhow::anyhow!("No intensity value found"))?;
    Ok(value)
}

fn get_shutter_value(programmer: &Programmer, preset_target: PresetTarget) -> anyhow::Result<PresetValue<f64>> {
    match preset_target {
        PresetTarget::Universal => {
            let value = get_universal_shutter(programmer)?;

            Ok(PresetValue::Universal(value))
        }
        PresetTarget::Selective => {
            let values = programmer.get_controls()
                .into_iter()
                .filter(|control| matches!(control.control, FixtureFaderControl::Shutter))
                .flat_map(|control| control.fixtures.get_fixtures()
                    .into_iter()
                    .flatten()
                    .map(move |fixture_id| (fixture_id, control.value)))
                .collect();

            Ok(PresetValue::Selective(values))
        }
    }
}

fn get_universal_shutter(programmer: &Programmer) -> anyhow::Result<f64> {
    let value = programmer.get_active_values()
        .into_iter()
        .filter_map(|value| {
            if let FixtureControlValue::Shutter(value) = value {
                Some(value)
            } else {
                None
            }
        })
        .next();
    let value = value.ok_or_else(|| anyhow::anyhow!("No shutter value found"))?;
    Ok(value)
}
