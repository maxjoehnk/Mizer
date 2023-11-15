use std::sync::Arc;

use parking_lot::RwLock;

use mizer_module::FixtureLibraryPaths;

use crate::definition::FixtureDefinition;
use crate::FixtureLibraryLoader;

#[derive(Clone)]
pub struct FixtureLibrary {
    providers: Arc<RwLock<Vec<Box<dyn FixtureLibraryProvider>>>>,
    library_loader: Arc<Box<dyn FixtureLibraryLoader>>,
}

impl FixtureLibrary {
    pub fn new(
        providers: Vec<Box<dyn FixtureLibraryProvider>>,
        loader: impl FixtureLibraryLoader + 'static,
    ) -> Self {
        FixtureLibrary {
            providers: Arc::new(RwLock::new(providers)),
            library_loader: Arc::new(Box::new(loader)),
        }
    }

    pub fn reload(&self, paths: FixtureLibraryPaths) -> anyhow::Result<()> {
        let new_providers = self.library_loader.get_providers(&paths);
        let mut providers = self.providers.write();
        *providers = new_providers;
        self.queue_load();

        Ok(())
    }

    pub(crate) fn queue_load(&self) {
        let library = self.clone();
        std::thread::Builder::new()
            .name("Background Fixture Library Loader".into())
            .spawn(move || {
                log::info!("Loading fixture libraries...");
                if let Err(err) = library.load_libraries() {
                    log::error!("Loading of fixture libraries failed: {:?}", err);
                } else {
                    log::info!("Loaded fixture libraries successfully.");
                }
            })
            .unwrap();
    }

    fn load_libraries(&self) -> anyhow::Result<()> {
        let mut providers = self.providers.write();
        providers
            .iter_mut()
            .map(|provider| provider.load())
            .collect::<anyhow::Result<Vec<_>>>()?;

        Ok(())
    }

    pub fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        self.providers
            .read()
            .iter()
            .filter_map(|provider| provider.get_definition(id))
            .collect::<Vec<_>>()
            .first()
            .cloned()
    }

    pub fn list_definitions(&self) -> Vec<FixtureDefinition> {
        self.providers
            .read()
            .iter()
            .flat_map(|provider| provider.list_definitions())
            .collect()
    }
}

pub trait FixtureLibraryProvider: Send + Sync {
    fn load(&mut self) -> anyhow::Result<()>;

    fn get_definition(&self, id: &str) -> Option<FixtureDefinition>;

    fn list_definitions(&self) -> Vec<FixtureDefinition>;
}

/// A fixture library loader that does not load any libraries.
///
/// Only used for testing.
#[derive(Default)]
struct EmptyLibraryLoader;

impl FixtureLibraryLoader for EmptyLibraryLoader {
    fn get_providers(&self, _paths: &FixtureLibraryPaths) -> Vec<Box<dyn FixtureLibraryProvider>> {
        Default::default()
    }
}

impl Default for FixtureLibrary {
    fn default() -> Self {
        FixtureLibrary {
            providers: Arc::new(RwLock::new(Vec::new())),
            library_loader: Arc::new(Box::new(EmptyLibraryLoader::default())),
        }
    }
}
