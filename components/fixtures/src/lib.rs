use serde::{Deserialize, Serialize};
use crate::library::{FixtureLibrary, FixtureLibraryProvider};
use crate::manager::FixtureManager;
use crate::processor::FixtureProcessor;
use mizer_module::{Module, Runtime};

pub mod fixture;
pub mod definition;
pub mod library;
pub mod manager;
mod processor;
// TODO: should probably find a better name
pub mod programmer;

#[derive(Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq, Hash)]
#[serde(untagged)]
pub enum FixtureId {
    Fixture(u32),
    SubFixture(u32, u32)
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
