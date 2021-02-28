use crate::library::{FixtureLibrary, FixtureLibraryProvider};
use crate::manager::FixtureManager;
use crate::processor::FixtureProcessor;
use mizer_module::{Module, Runtime};

pub mod fixture;
pub mod library;
pub mod manager;
mod processor;

pub struct FixtureModule(Vec<Box<dyn FixtureLibraryProvider>>, FixtureManager);

impl FixtureModule {
    pub fn new(providers: Vec<Box<dyn FixtureLibraryProvider>>) -> (Self, FixtureManager) {
        let manager = FixtureManager::new();
        (Self(providers, manager.clone()), manager)
    }
}

impl Module for FixtureModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        let injector = runtime.injector();
        injector.provide(FixtureLibrary::new(self.0));
        injector.provide(FixtureManager::new());
        runtime.add_processor(FixtureProcessor.into());
        Ok(())
    }
}
