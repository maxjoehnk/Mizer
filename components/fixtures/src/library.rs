use crate::fixture::FixtureDefinition;

pub struct FixtureLibrary {
    providers: Vec<Box<dyn FixtureLibraryProvider>>,
}

impl FixtureLibrary {
    pub fn new(providers: Vec<Box<dyn FixtureLibraryProvider>>) -> Self {
        FixtureLibrary { providers }
    }

    pub fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        self.providers
            .iter()
            .filter_map(|provider| provider.get_definition(id))
            .collect::<Vec<_>>()
            .first()
            .cloned()
    }
}

pub trait FixtureLibraryProvider {
    fn get_definition(&self, id: &str) -> Option<FixtureDefinition>;
}
