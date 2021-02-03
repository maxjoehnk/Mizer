use crate::fixture::{Fixture, FixtureDefinition};
use dashmap::DashMap;
use std::sync::Arc;
use std::ops::Deref;

#[derive(Default, Clone)]
pub struct FixtureManager {
    fixtures: Arc<DashMap<String, Fixture>>,
}

impl FixtureManager {
    pub fn new() -> Self {
        FixtureManager::default()
    }

    pub fn add_fixture(
        &self,
        fixture_id: String,
        definition: FixtureDefinition,
        mode: Option<String>,
        channel: u8,
        universe: Option<u16>,
    ) {
        let fixture = Fixture::new(fixture_id.clone(), definition, mode, channel, universe);
        self.fixtures.insert(fixture_id, fixture);
    }

    pub fn get_fixture(& self, fixture_id: &str) -> Option<impl Deref<Target = Fixture> + '_> {
        self.fixtures.get(fixture_id)
    }

    pub fn get_fixtures(&self) -> Vec<impl Deref<Target = Fixture> + '_> {
        self.fixtures.iter().collect()
    }
}
