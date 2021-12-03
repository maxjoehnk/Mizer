use crate::fixture::Fixture;
use crate::definition::{FixtureControl, FixtureDefinition};
use crate::library::FixtureLibrary;
use dashmap::DashMap;
use mizer_protocol_dmx::DmxConnectionManager;
use std::ops::{Deref, DerefMut};
use std::sync::{Arc, Mutex};
use crate::FixtureId;
use crate::programmer::Programmer;

#[derive(Clone)]
pub struct FixtureManager {
    library: FixtureLibrary,
    // TODO: this is only public for project loading/saving
    pub fixtures: Arc<DashMap<u32, Fixture>>,
    programmer: Arc<Mutex<Programmer>>,
}

impl FixtureManager {
    pub fn new(library: FixtureLibrary) -> Self {
        let fixtures = Default::default();
        Self {
            library,
            programmer: Arc::new(Mutex::new(Programmer::new(Arc::clone(&fixtures)))),
            fixtures,
        }
    }

    pub fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        self.library.get_definition(id)
    }

    pub fn add_fixture(
        &self,
        fixture_id: u32,
        definition: FixtureDefinition,
        mode: Option<String>,
        output: Option<String>,
        channel: u8,
        universe: Option<u16>,
    ) {
        log::trace!("Adding fixture {}", fixture_id);
        let fixture = Fixture::new(fixture_id, definition, mode, output, channel, universe);
        self.fixtures.insert(fixture_id, fixture);
    }

    pub fn get_fixture(&self, fixture_id: u32) -> Option<impl Deref<Target = Fixture> + '_> {
        self.fixtures.get(&fixture_id)
    }

    pub fn get_fixture_mut(&self, fixture_id: u32) -> Option<impl DerefMut<Target = Fixture> + '_> {
        self.fixtures.get_mut(&fixture_id)
    }

    pub fn write_fixture_control(&self, fixture_id: FixtureId, control: FixtureControl, value: f64) {
        match fixture_id {
            FixtureId::Fixture(fixture_id) => {
                if let Some(mut fixture) = self.get_fixture_mut(fixture_id) {
                    fixture.write_control(control, value);
                }
            },
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

    pub fn write_outputs(&self, dmx_manager: &DmxConnectionManager) {
        for fixture in self.fixtures.iter() {
            if let Some(output) = fixture.output.as_ref().and_then(|output| dmx_manager.get_output(output)) {
                fixture.flush(output);
            }else {
                for (_, output) in dmx_manager.list_outputs() {
                    fixture.flush(output.as_ref());
                }
            }
        }
    }

    pub fn get_programmer<'a>(&'a self) -> impl DerefMut<Target = Programmer> + 'a {
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
