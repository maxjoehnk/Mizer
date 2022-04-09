use crate::definition::FixtureDefinition;
use parking_lot::RwLock;
use std::sync::Arc;

#[derive(Clone, Default)]
pub struct FixtureLibrary {
    providers: Arc<RwLock<Vec<Box<dyn FixtureLibraryProvider>>>>,
}

impl FixtureLibrary {
    pub fn new(providers: Vec<Box<dyn FixtureLibraryProvider>>) -> Self {
        FixtureLibrary {
            providers: Arc::new(RwLock::new(providers)),
        }
    }

    pub fn replace_providers(&self, new_providers: Vec<Box<dyn FixtureLibraryProvider>>) {
        let mut providers = self.providers.write();
        *providers = new_providers;
    }

    pub fn load_libraries(&self) -> anyhow::Result<()> {
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
