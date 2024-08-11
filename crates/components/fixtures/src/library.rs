use std::sync::Arc;

use parking_lot::{Condvar, Mutex, RwLock};

use mizer_module::FixtureLibraryPaths;

use crate::definition::FixtureDefinition;
use crate::FixtureLibraryLoader;

#[derive(Clone)]
pub struct FixtureLibrary {
    providers: Arc<RwLock<Vec<Box<dyn FixtureLibraryProvider>>>>,
    library_loader: Arc<Box<dyn FixtureLibraryLoader>>,
    is_loading: FixtureLibraryLoadingIndicator,
}

#[derive(Clone, Default)]
struct FixtureLibraryLoadingIndicator {
    is_loading: Arc<Mutex<bool>>,
    event: Arc<Condvar>,
}

impl FixtureLibraryLoadingIndicator {
    pub fn wait_for_load(&self) {
        let mut is_loading = self.is_loading.lock();
        if *is_loading {
            self.event.wait(&mut is_loading)
        }
    }

    pub fn set_loading(&self, loading: bool) {
        let mut is_loading = self.is_loading.lock();
        *is_loading = loading;
        if !loading {
            self.event.notify_all();
        }
    }
}

impl FixtureLibrary {
    pub fn new(
        providers: Vec<Box<dyn FixtureLibraryProvider>>,
        loader: impl FixtureLibraryLoader + 'static,
    ) -> Self {
        FixtureLibrary {
            providers: Arc::new(RwLock::new(providers)),
            library_loader: Arc::new(Box::new(loader)),
            is_loading: Default::default(),
        }
    }

    pub fn reload(&self, paths: FixtureLibraryPaths) -> anyhow::Result<()> {
        let new_providers = self.library_loader.get_providers(&paths);
        let mut providers = self.providers.write();
        *providers = new_providers;
        self.queue_load();

        Ok(())
    }

    pub fn wait_for_load(&self) {
        tracing::debug!("Waiting for fixture libraries to load...");
        self.is_loading.wait_for_load()
    }

    pub(crate) fn queue_load(&self) {
        self.is_loading.set_loading(true);
        let library = self.clone();
        std::thread::Builder::new()
            .name("Background Fixture Library Loader".into())
            .spawn(move || {
                tracing::info!("Loading fixture libraries...");
                if let Err(err) = library.load_libraries() {
                    tracing::error!("Loading of fixture libraries failed: {:?}", err);
                } else {
                    tracing::info!("Loaded fixture libraries successfully.");
                }
            })
            .unwrap();
    }

    fn load_libraries(&self) -> anyhow::Result<()> {
        let mut providers = self.providers.write();
        for provider in providers.iter_mut() {
            if let Err(err) = provider.load() {
                tracing::error!("Unable to load from provider {provider}: {err:?}");
            }
        }

        self.is_loading.set_loading(false);

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

pub trait FixtureLibraryProvider: std::fmt::Display + Send + Sync {
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
            is_loading: Default::default(),
        }
    }
}
