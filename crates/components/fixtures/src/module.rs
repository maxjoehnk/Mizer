use std::marker::PhantomData;

use mizer_module::*;

use crate::library::{FixtureLibrary, FixtureLibraryProvider};
use crate::manager::FixtureManager;
use crate::processor::FixtureProcessor;

#[derive(Default)]
pub struct FixtureModule<TLibraryLoader>(PhantomData<TLibraryLoader>);

pub trait FixtureLibraryLoader: Send + Sync {
    fn get_providers(&self, paths: &FixtureLibraryPaths) -> Vec<Box<dyn FixtureLibraryProvider>>;
}

impl<TLibraryLoader> std::fmt::Display for FixtureModule<TLibraryLoader> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str(stringify!(FixtureModule).trim())
    }
}

impl<TLibraryLoader: FixtureLibraryLoader + Default + 'static> Module
    for FixtureModule<TLibraryLoader>
{
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let loader = TLibraryLoader::default();
        let providers = loader.get_providers(&context.settings().paths.fixture_libraries);
        let library = FixtureLibrary::new(providers, loader);
        library.queue_load();
        let manager = FixtureManager::new(library.clone());
        context.provide_api(library.clone());
        context.provide(library);
        context.provide_api(manager.clone());
        context.provide(manager);
        context.add_processor(FixtureProcessor);

        Ok(())
    }
}
