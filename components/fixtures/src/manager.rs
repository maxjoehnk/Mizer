use crate::definition::{FixtureDefinition, FixtureFaderControl};
use crate::fixture::{Fixture, IFixtureMut};
use crate::library::FixtureLibrary;
use crate::programmer::{Group, Presets, Programmer};
use crate::{FixtureId, FixtureStates};
use dashmap::DashMap;
use mizer_protocol_dmx::DmxConnectionManager;
use std::ops::{Deref, DerefMut};
use std::sync::{Arc, Mutex};

#[derive(Clone)]
pub struct FixtureManager {
    library: FixtureLibrary,
    // TODO: this is only public for project loading/saving
    pub fixtures: Arc<DashMap<u32, Fixture>>,
    pub groups: Arc<DashMap<u32, Group>>,
    pub presets: Arc<Presets>,
    pub states: FixtureStates,
    programmer: Arc<Mutex<Programmer>>,
}

impl FixtureManager {
    pub fn new(library: FixtureLibrary) -> Self {
        let fixtures = Default::default();
        Self {
            library,
            programmer: Arc::new(Mutex::new(Programmer::new(Arc::clone(&fixtures)))),
            fixtures,
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
        output: Option<String>,
        channel: u16,
        universe: Option<u16>,
    ) {
        log::trace!("Adding fixture {}", fixture_id);
        let fixture = Fixture::new(
            fixture_id, name, definition, mode, output, channel, universe,
        );
        self.states.add_fixture(&fixture);
        self.fixtures.insert(fixture_id, fixture);
    }

    pub fn add_group(&self, name: String) -> u32 {
        let highest_id = self.groups.iter().map(|e| e.id).max().unwrap_or_default();
        let group_id = highest_id + 1;
        let group = Group {
            id: group_id,
            fixtures: Vec::new(),
            name,
        };
        self.groups.insert(group_id, group);

        group_id
    }

    pub fn delete_group(&self, group_id: u32) -> Option<Group> {
        self.groups.remove(&group_id).map(|(_, group)| group)
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
    ) {
        match fixture_id {
            FixtureId::Fixture(fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    fixture.write_control(control, value);
                }
            }
            FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    if let Some(mut sub_fixture) = fixture.sub_fixture_mut(sub_fixture_id) {
                        sub_fixture.write_control(control, value);
                    }
                }
            }
        }
    }

    pub fn get_fixtures(&self) -> Vec<impl Deref<Target = Fixture> + '_> {
        self.fixtures.iter().collect()
    }

    pub fn get_group(&self, group_id: u32) -> Option<impl Deref<Target = Group> + '_> {
        self.groups.get(&group_id)
    }

    pub fn get_groups(&self) -> Vec<impl Deref<Target = Group> + '_> {
        self.groups.iter().collect()
    }

    pub fn write_outputs(&self, dmx_manager: &DmxConnectionManager) {
        for fixture in self.fixtures.iter() {
            if let Some(output) = fixture
                .output
                .as_ref()
                .and_then(|output| dmx_manager.get_output(output))
            {
                fixture.flush(output);
            } else {
                for (_, output) in dmx_manager.list_outputs() {
                    fixture.flush(output);
                }
            }
        }
    }

    pub fn get_programmer(&self) -> impl DerefMut<Target = Programmer> + '_ {
        let programmer = self.programmer.lock().unwrap();
        programmer
    }

    pub(crate) fn execute_programmers(&self) {
        let programmer = self.programmer.lock().unwrap();
        programmer.run();
    }

    pub(crate) fn default_fixtures(&self) {
        for mut fixture in self.fixtures.iter_mut() {
            fixture.set_to_default();
        }
    }
}
