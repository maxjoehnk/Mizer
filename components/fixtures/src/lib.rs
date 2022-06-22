use crate::fixture::Fixture;
use crate::library::{FixtureLibrary, FixtureLibraryProvider};
use crate::manager::FixtureManager;
use crate::processor::FixtureProcessor;
use crate::programmer::Color;
use mizer_module::{Module, Runtime};
use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::sync::Arc;

pub mod definition;
pub mod fixture;
pub mod library;
pub mod manager;
mod processor;
// TODO: should probably find a better name
pub mod programmer;
mod color_mixer;

#[derive(Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash)]
#[serde(untagged)]
pub enum FixtureId {
    Fixture(u32),
    SubFixture(u32, u32),
}

impl From<u32> for FixtureId {
    fn from(id: u32) -> Self {
        Self::Fixture(id)
    }
}

impl From<(u32, u32)> for FixtureId {
    fn from((fixture_id, child_id): (u32, u32)) -> Self {
        Self::SubFixture(fixture_id, child_id)
    }
}

pub struct FixtureModule(FixtureLibrary, FixtureManager);

impl FixtureModule {
    pub fn new(
        providers: Vec<Box<dyn FixtureLibraryProvider>>,
    ) -> (Self, FixtureManager, FixtureLibrary) {
        let library = FixtureLibrary::new(providers);
        let manager = FixtureManager::new(library.clone());
        (Self(library.clone(), manager.clone()), manager, library)
    }
}

impl Module for FixtureModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(self.0);
        injector.provide(self.1);
        runtime.add_processor(FixtureProcessor.into());
        Ok(())
    }
}

#[derive(Clone)]
pub struct FixtureStates(Arc<NonEmptyPinboard<HashMap<FixtureId, FixtureState>>>);

impl Default for FixtureStates {
    fn default() -> Self {
        Self(Arc::new(NonEmptyPinboard::new(HashMap::new())))
    }
}

impl FixtureStates {
    pub(crate) fn add_fixture(&self, fixture: &Fixture) {
        let mut states = self.0.read();
        states.insert(FixtureId::Fixture(fixture.id), Default::default());
        for sub_fixture in fixture.current_mode.sub_fixtures.iter() {
            states.insert(
                FixtureId::SubFixture(fixture.id, sub_fixture.id),
                Default::default(),
            );
        }
        self.0.set(states);
    }

    pub(crate) fn remove_fixture(&self, fixture: &Fixture) {
        let mut states = self.0.read();
        states.remove(&FixtureId::Fixture(fixture.id));
        for sub_fixture in fixture.current_mode.sub_fixtures.iter() {
            states.remove(&FixtureId::SubFixture(fixture.id, sub_fixture.id));
        }
        self.0.set(states);
    }

    pub fn clear(&self) {
        self.0.set(Default::default());
    }

    pub fn read(&self) -> HashMap<FixtureId, FixtureState> {
        self.0.read()
    }

    pub(crate) fn write(&self, state: HashMap<FixtureId, FixtureState>) {
        self.0.set(state);
    }
}

#[derive(Clone, Copy, Debug, Default)]
pub struct FixtureState {
    pub brightness: Option<f64>,
    pub color: Option<Color>,
}

#[derive(Debug, Clone, Copy, Default)]
pub struct RgbColor {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
}
