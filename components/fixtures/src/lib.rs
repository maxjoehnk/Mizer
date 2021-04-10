use crate::library::{FixtureLibrary, FixtureLibraryProvider};
use crate::manager::FixtureManager;
use crate::processor::FixtureProcessor;
use mizer_module::{Module, Runtime};

pub mod fixture;
pub mod library;
pub mod manager;
mod processor;

pub struct FixtureModule(FixtureLibrary, FixtureManager);

impl FixtureModule {
    pub fn new(providers: Vec<Box<dyn FixtureLibraryProvider>>) -> (Self, FixtureManager, FixtureLibrary) {
        let manager = FixtureManager::new();
        let library = FixtureLibrary::new(providers);
        (Self(library.clone(), manager.clone()), manager, library)
    }
}

impl Module for FixtureModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector();
        injector.provide(self.0);
        injector.provide(self.1);
        runtime.add_processor(FixtureProcessor.into());
        Ok(())
    }
}
