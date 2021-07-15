use crate::fixture::{Fixture, FixtureDefinition};
use crate::library::FixtureLibrary;
use dashmap::DashMap;
use mizer_protocol_dmx::DmxConnectionManager;
use std::ops::{Deref, DerefMut};
use std::sync::Arc;

#[derive(Clone)]
pub struct FixtureManager {
    library: FixtureLibrary,
    pub fixtures: Arc<DashMap<u32, Fixture>>,
}

impl FixtureManager {
    pub fn new(library: FixtureLibrary) -> Self {
        Self {
            library,
            fixtures: Default::default(),
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
        output: String,
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

    pub fn get_fixtures(&self) -> Vec<impl Deref<Target = Fixture> + '_> {
        self.fixtures.iter().collect()
    }

    pub fn write_outputs(&self, dmx_manager: &DmxConnectionManager) {
        for fixture in self.fixtures.iter() {
            if let Some(output) = dmx_manager.get_output(&fixture.output) {
                fixture.flush(output);
            } else {
                log::warn!("fixture is referencing unknown output {}", fixture.output);
            }
        }
    }
}
