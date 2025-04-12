use std::hash::{DefaultHasher, Hash, Hasher};
use std::ops::{Deref, DerefMut};
use std::sync::{Arc, Mutex, MutexGuard};
use std::time::Duration;
use dashmap::DashMap;
use itertools::Itertools;
use mizer_protocol_dmx::DmxConnectionManager;
use rayon::prelude::*;
use serde::Serialize;
use crate::definition::{
    FixtureControl, FixtureControlType, FixtureDefinition, FixtureFaderControl,
};
use crate::fixture::{Fixture, FixtureConfiguration, IFixtureMut};
use crate::library::FixtureLibrary;
use crate::programmer::{GenericPreset, Group, Preset, PresetId, PresetType, Presets, Programmer, PresetValue, Color, Position};
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

    pub fn add_intensity_preset(&self, label: Option<String>, value: PresetValue<f64>) -> anyhow::Result<PresetId> {
        let preset_type = PresetType::Intensity;
        let preset_id = self.presets.next_id(preset_type);
        let preset = Preset {
            id: preset_id,
            value,
            label,
        };
        self.presets.intensity.insert(preset_id, preset);

        Ok(PresetId::Intensity(preset_id))
    }

    pub fn add_shutter_preset(&self, label: Option<String>, value: PresetValue<f64>) -> anyhow::Result<PresetId> {
        let preset_type = PresetType::Shutter;
        let preset_id = self.presets.next_id(preset_type);
        let preset = Preset {
            id: preset_id,
            value,
            label,
        };
        self.presets.shutter.insert(preset_id, preset);

        Ok(PresetId::Shutter(preset_id))
    }

    pub fn add_color_preset(&self, label: Option<String>, value: PresetValue<Color>) -> anyhow::Result<PresetId> {
        let preset_type = PresetType::Color;
        let preset_id = self.presets.next_id(preset_type);
        let preset = Preset {
            id: preset_id,
            value,
            label,
        };
        self.presets.color.insert(preset_id, preset);

        Ok(PresetId::Color(preset_id))
    }

    pub fn add_position_preset(&self, label: Option<String>, value: PresetValue<Position>) -> anyhow::Result<PresetId> {
        let preset_type = PresetType::Position;
        let preset_id = self.presets.next_id(preset_type);
        let preset = Preset {
            id: preset_id,
            value,
            label,
        };
        self.presets.position.insert(preset_id, preset);

        Ok(PresetId::Position(preset_id))
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
        self.write_fixture_control_with_timings(
            fixture_id,
            control,
            value,
            priority,
            None,
            FadeTimings::default(),
        )
    }

    pub fn write_fixture_control_with_timings(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        match fixture_id {
            FixtureId::Fixture(fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    fixture.write_fader_control_with_timings(control, value, priority, source, fade_timings);
                }
            }
            FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    if let Some(mut sub_fixture) = fixture.sub_fixture_mut(sub_fixture_id) {
                        sub_fixture.write_fader_control_with_timings(control, value, priority, source, fade_timings);
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

    pub fn write_group_control_with_timings(
        &self,
        group_id: GroupId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        if let Some(group) = self.groups.get(&group_id) {
            for fixture_id in group.fixtures().into_iter().flatten() {
                self.write_fixture_control_with_timings(fixture_id, control.clone(), value, priority, source.clone(), fade_timings);
            }
        }
    }

    pub fn write_outputs(&self, dmx_manager: &DmxConnectionManager) {
        profiling::scope!("FixtureManager::write_outputs");
        let writer = dmx_manager.get_writer();

        let universes = self
            .fixtures
            .iter_mut()
            .sorted_by_key(|f| f.universe)
            .chunk_by(|f| f.universe)
            .into_iter()
            .map(|(_, f)| f.into_iter().map(|fixture| fixture.id).collect::<Vec<_>>())
            .collect::<Vec<_>>();

        universes.into_par_iter().for_each(|fixtures| {
            for fixture_id in fixtures {
                let mut fixture = self.get_fixture_mut(fixture_id).unwrap();
                fixture.flush(&writer);
            }
        });
    }

    pub fn get_programmer(&self) -> impl Deref<Target = Programmer> + '_ {
        tracing::trace!("Locking programmer");
        let programmer = self.programmer.lock().unwrap().log_wrap();
        programmer
    }

    pub fn get_programmer_mut(&self) -> impl DerefMut<Target = Programmer> + '_ {
        tracing::trace!("Locking programmer");
        let programmer = self.programmer.lock().unwrap().log_wrap();
        programmer
    }

    pub(crate) fn execute_programmers(&self) {
        profiling::scope!("FixtureManager::execute_programmers");
        tracing::trace!("Locking programmer");
        let programmer = self.programmer.lock().unwrap().log_wrap();
        programmer.run(&self.fixtures, &self.presets);
    }

    pub(crate) fn default_fixtures(&self) {
        profiling::scope!("FixtureManager::default_fixtures");
        for mut fixture in self.fixtures.iter_mut() {
            fixture.set_to_default();
        }
    }
}

#[derive(Default, Debug, Clone, Copy, PartialEq, Eq, Serialize)]
pub struct FadeTimings {
    // TODO: support bpm based fade duration
    // TODO: support fade in as well? might be better than doing it in the sequencer, node etc as we have access to the previous value
    pub fade_out: Option<Duration>,
}

impl<T: Into<FadeTimings>> From<Option<T>> for FadeTimings {
    fn from(value: Option<T>) -> Self {
        match value {
            None => Self::default(),
            Some(value) => value.into(),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Serialize)]
pub struct FixtureValueSource {
    // TODO: this should be an Arc<String> in the future so we can also show this in the ui without significant performance costs
    #[cfg(debug_assertions)]
    pub label: String,
    pub(crate) id: u64,
}

impl FixtureValueSource {
    pub fn new(id: impl Hash, label: &str) -> Self {
        let mut hasher = DefaultHasher::new();
        id.hash(&mut hasher);
        let id = hasher.finish();

        #[cfg(debug_assertions)]
        {
            let label = label.to_string();

            Self { id, label }
        }
        #[cfg(not(debug_assertions))]
        {
            Self { id }
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
