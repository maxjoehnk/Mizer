use std::ops::{Deref, DerefMut};
use std::sync::{Arc, Mutex, MutexGuard};

use dashmap::DashMap;
use itertools::Itertools;

use mizer_protocol_dmx::DmxConnectionManager;

use crate::definition::{
    FixtureControl, FixtureControlType, FixtureControlValue, FixtureDefinition, FixtureFaderControl,
};
use crate::fixture::{Fixture, FixtureConfiguration, IFixtureMut};
use crate::library::FixtureLibrary;
use crate::programmer::{
    GenericPreset, Group, Position, Preset, PresetId, PresetType, Presets, Programmer,
};
use crate::{FixtureId, FixturePriority, FixtureStates, GroupId};

#[derive(Clone)]
pub struct FixtureManager {
    library: FixtureLibrary,
    // TODO: this is only public for project loading/saving
    pub fixtures: Arc<DashMap<u32, Fixture>>,
    pub groups: Arc<DashMap<GroupId, Group>>,
    pub presets: Arc<Presets>,
    pub states: FixtureStates,
    programmer: Arc<Mutex<Programmer>>,
}

impl FixtureManager {
    pub fn new(library: FixtureLibrary) -> Self {
        Self {
            library,
            programmer: Arc::new(Mutex::new(Programmer::new())),
            fixtures: Default::default(),
            groups: Default::default(),
            states: Default::default(),
            presets: Default::default(),
        }
    }

    pub fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        self.library.get_definition(id)
    }

    pub fn add_fixture(
        &self,
        fixture_id: u32,
        name: String,
        definition: FixtureDefinition,
        mode: Option<String>,
        channel: u16,
        universe: Option<u16>,
        configuration: FixtureConfiguration,
    ) {
        tracing::trace!(
            "Adding fixture {} with address {}.{}",
            fixture_id,
            universe.unwrap_or(1),
            channel
        );
        let fixture = Fixture::new(
            fixture_id,
            name,
            definition,
            mode,
            channel,
            universe,
            configuration,
        );
        self.states.add_fixture(&fixture);
        self.fixtures.insert(fixture_id, fixture);
    }

    pub fn add_group(&self, name: String) -> GroupId {
        let highest_id = self.groups.iter().map(|e| e.id).max().unwrap_or_default();
        let group_id = highest_id.next();
        let group = Group {
            id: group_id,
            selection: Default::default(),
            name,
        };
        self.groups.insert(group_id, group);

        group_id
    }

    pub fn delete_group(&self, group_id: GroupId) -> Option<Group> {
        self.groups.remove(&group_id).map(|(_, group)| group)
    }

    pub fn add_preset(
        &self,
        label: Option<String>,
        preset_type: PresetType,
        values: Vec<FixtureControlValue>,
    ) -> anyhow::Result<GenericPreset> {
        let preset_id = self.presets.next_id(preset_type);
        match preset_type {
            PresetType::Intensity => {
                let value = values
                    .iter()
                    .find_map(|v| match v {
                        FixtureControlValue::Intensity(value) => Some(*value),
                        _ => None,
                    })
                    .ok_or_else(|| anyhow::anyhow!("Missing intensity value in programmer"))?;
                let preset = Preset {
                    id: preset_id,
                    value,
                    label,
                };
                self.presets.intensity.insert(preset_id, preset.clone());

                Ok(GenericPreset::Intensity(preset))
            }
            PresetType::Shutter => {
                let value = values
                    .iter()
                    .find_map(|v| match v {
                        FixtureControlValue::Shutter(value) => Some(*value),
                        _ => None,
                    })
                    .ok_or_else(|| anyhow::anyhow!("Missing shutter value in programmer"))?;
                let preset = Preset {
                    id: preset_id,
                    value,
                    label,
                };
                self.presets.shutter.insert(preset_id, preset.clone());

                Ok(GenericPreset::Shutter(preset))
            }
            PresetType::Color => {
                let value = values
                    .iter()
                    .find_map(|v| match v {
                        FixtureControlValue::ColorMixer(red, green, blue) => {
                            Some((*red, *green, *blue))
                        }
                        _ => None,
                    })
                    .ok_or_else(|| anyhow::anyhow!("Missing color value in programmer"))?;
                let preset = Preset {
                    id: preset_id,
                    value,
                    label,
                };
                self.presets.color.insert(preset_id, preset.clone());

                Ok(GenericPreset::Color(preset))
            }
            PresetType::Position => {
                let pan = values.iter().find_map(|v| match v {
                    FixtureControlValue::Pan(value) => Some(*value),
                    _ => None,
                });
                let tilt = values.iter().find_map(|v| match v {
                    FixtureControlValue::Tilt(value) => Some(*value),
                    _ => None,
                });
                let preset = Preset {
                    id: preset_id,
                    value: Position::from_pan_tilt(pan, tilt)
                        .ok_or_else(|| anyhow::anyhow!("Invalid preset type/value combination"))?,
                    label,
                };
                self.presets.position.insert(preset_id, preset.clone());

                Ok(GenericPreset::Position(preset))
            }
        }
    }

    pub fn store_in_preset(
        &self,
        preset_id: PresetId,
        mut values: Vec<FixtureControlValue>,
    ) -> anyhow::Result<Vec<FixtureControlValue>> {
        match preset_id {
            PresetId::Intensity(preset_id) => {
                let value = values
                    .iter_mut()
                    .find_map(|v| match v {
                        FixtureControlValue::Intensity(value) => Some(value),
                        _ => None,
                    })
                    .ok_or_else(|| anyhow::anyhow!("Missing intensity value in programmer"))?;
                let mut preset = self
                    .presets
                    .intensity
                    .get_mut(&preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id}"))?;
                std::mem::swap(&mut preset.value, value);

                Ok(vec![FixtureControlValue::Intensity(*value)])
            }
            PresetId::Shutter(preset_id) => {
                let value = values
                    .iter_mut()
                    .find_map(|v| match v {
                        FixtureControlValue::Shutter(value) => Some(value),
                        _ => None,
                    })
                    .ok_or_else(|| anyhow::anyhow!("Missing shutter value in programmer"))?;
                let mut preset = self
                    .presets
                    .shutter
                    .get_mut(&preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id}"))?;
                std::mem::swap(&mut preset.value, value);

                Ok(vec![FixtureControlValue::Shutter(*value)])
            }
            PresetId::Color(preset_id) => {
                let mut value = values
                    .into_iter()
                    .find_map(|v| match v {
                        FixtureControlValue::ColorMixer(red, green, blue) => {
                            Some((red, green, blue))
                        }
                        _ => None,
                    })
                    .ok_or_else(|| anyhow::anyhow!("Missing color value in programmer"))?;
                let mut preset = self
                    .presets
                    .color
                    .get_mut(&preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id}"))?;

                std::mem::swap(&mut preset.value, &mut value);

                Ok(vec![FixtureControlValue::ColorMixer(
                    value.0, value.1, value.2,
                )])
            }
            PresetId::Position(preset_id) => {
                let pan = values.iter().find_map(|v| match v {
                    FixtureControlValue::Pan(value) => Some(*value),
                    _ => None,
                });
                let tilt = values.iter().find_map(|v| match v {
                    FixtureControlValue::Tilt(value) => Some(*value),
                    _ => None,
                });
                let mut preset = self
                    .presets
                    .position
                    .get_mut(&preset_id)
                    .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id}"))?;

                let mut value = Position::from_pan_tilt(pan, tilt)
                    .ok_or_else(|| anyhow::anyhow!("Invalid preset type/value combination"))?;

                std::mem::swap(&mut preset.value, &mut value);

                Ok(value.into())
            }
        }
    }

    pub fn delete_preset(&self, preset_id: PresetId) -> Option<GenericPreset> {
        match preset_id {
            PresetId::Intensity(preset_id) => {
                let (_, preset) = self.presets.intensity.remove(&preset_id)?;

                Some(GenericPreset::Intensity(preset))
            }
            PresetId::Shutter(preset_id) => {
                let (_, preset) = self.presets.shutter.remove(&preset_id)?;

                Some(GenericPreset::Shutter(preset))
            }
            PresetId::Position(preset_id) => {
                let (_, preset) = self.presets.position.remove(&preset_id)?;

                Some(GenericPreset::Position(preset))
            }
            PresetId::Color(preset_id) => {
                let (_, preset) = self.presets.color.remove(&preset_id)?;

                Some(GenericPreset::Color(preset))
            }
        }
    }

    pub fn get_fixture(&self, fixture_id: u32) -> Option<impl Deref<Target = Fixture> + '_> {
        self.fixtures.get(&fixture_id)
    }

    pub fn get_fixture_mut(&self, fixture_id: u32) -> Option<impl DerefMut<Target = Fixture> + '_> {
        self.fixtures.get_mut(&fixture_id)
    }

    pub fn delete_fixture(&self, fixture_id: u32) -> Option<Fixture> {
        let (_, fixture) = self.fixtures.remove(&fixture_id)?;
        self.states.remove_fixture(&fixture);

        Some(fixture)
    }

    pub fn write_fixture_control(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        profiling::scope!("FixtureManager::write_fixture_control");
        match fixture_id {
            FixtureId::Fixture(fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    fixture.write_fader_control(control, value, priority);
                }
            }
            FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    if let Some(mut sub_fixture) = fixture.sub_fixture_mut(sub_fixture_id) {
                        sub_fixture.write_fader_control(control, value, priority);
                    }
                }
            }
        }
    }

    pub fn get_fixtures(&self) -> Vec<impl Deref<Target = Fixture> + '_> {
        self.fixtures.iter().collect()
    }

    pub fn get_group(&self, group_id: GroupId) -> Option<impl Deref<Target = Group> + '_> {
        self.groups.get(&group_id)
    }

    pub fn get_groups(&self) -> Vec<impl Deref<Target = Group> + '_> {
        self.groups.iter().collect()
    }

    pub fn get_group_fixture_controls(
        &self,
        group_id: GroupId,
    ) -> Vec<(FixtureControl, FixtureControlType)> {
        if let Some(group) = self.groups.get(&group_id) {
            group
                .fixtures()
                .into_iter()
                .flatten()
                .filter_map(|fixture_id| match fixture_id {
                    FixtureId::Fixture(fixture_id) => {
                        let fixture = self.fixtures.get(&fixture_id)?;

                        Some(fixture.current_mode.controls.controls())
                    }
                    FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                        let fixture = self.fixtures.get(&fixture_id)?;
                        let sub_fixture = fixture.sub_fixture(sub_fixture_id)?;

                        Some(sub_fixture.definition.controls.controls())
                    }
                })
                .flatten()
                .sorted()
                .dedup()
                .collect()
        } else {
            Default::default()
        }
    }

    pub fn write_group_control(
        &self,
        group_id: GroupId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        if let Some(group) = self.groups.get(&group_id) {
            for fixture_id in group.fixtures().into_iter().flatten() {
                self.write_fixture_control(fixture_id, control.clone(), value, priority);
            }
        }
    }

    pub fn write_outputs(&self, dmx_manager: &DmxConnectionManager) {
        profiling::scope!("FixtureManager::write_outputs");
        // TODO[perf]: par_iter with rayon? Would only work when the dmx_manager supports concurrency which would require removing the Mutex
        // Maybe we could cluster fixtures by universe and then write them in parallel
        for fixture in self.fixtures.iter() {
            fixture.flush(dmx_manager);
        }
    }

    pub fn get_programmer(&self) -> impl DerefMut<Target = Programmer> + '_ {
        tracing::trace!("Locking programmer");
        let programmer = self.programmer.lock().unwrap().log_wrap();
        programmer
    }

    pub(crate) fn execute_programmers(&self) {
        tracing::trace!("Locking programmer");
        let programmer = self.programmer.lock().unwrap().log_wrap();
        programmer.run(&self.fixtures, &self.presets);
    }

    pub(crate) fn default_fixtures(&self) {
        for mut fixture in self.fixtures.iter_mut() {
            fixture.set_to_default();
        }
    }
}

struct MutexLogWrapper<'a, T>(MutexGuard<'a, T>);

trait MutexExt<'a, T> {
    fn log_wrap(self) -> MutexLogWrapper<'a, T>;
}

impl<'a, T> MutexExt<'a, T> for MutexGuard<'a, T> {
    fn log_wrap(self) -> MutexLogWrapper<'a, T> {
        MutexLogWrapper(self)
    }
}

impl<'a, T> Deref for MutexLogWrapper<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        self.0.deref()
    }
}

impl<'a, T> DerefMut for MutexLogWrapper<'a, T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.0.deref_mut()
    }
}

impl<'a, T> Drop for MutexLogWrapper<'a, T> {
    fn drop(&mut self) {
        tracing::trace!("Dropping lock");
    }
}
