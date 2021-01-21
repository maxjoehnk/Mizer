use std::collections::HashMap;
use crate::fixture::{Fixture, FixtureDefinition};

pub struct FixtureManager {
    fixtures: HashMap<String, Fixture>,
}

impl FixtureManager {
    pub fn new() -> Self {
        FixtureManager {
            fixtures: Default::default(),
        }
    }

    pub fn add_fixture(&mut self, fixture_id: String, definition: FixtureDefinition, mode: Option<String>, channel: u8, universe: Option<u16>) {
        let fixture = Fixture::new(fixture_id.clone(), definition, mode, channel, universe);
        self.fixtures.insert(fixture_id, fixture);
    }

    pub fn get_fixture(&self, fixture_id: &str) -> Option<&Fixture> {
        self.fixtures.get(fixture_id)
    }

    pub fn get_fixtures(&self) -> Vec<&Fixture> {
        self.fixtures.values().collect()
    }
}
