use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use mizer_fixtures::definition::FixtureDefinition;
use mizer_fixtures::library::FixtureLibrary;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListFixtureDefinitionsQuery;

impl<'a> Query<'a> for ListFixtureDefinitionsQuery {
    type Dependencies = Ref<FixtureLibrary>;
    type Result = Vec<FixtureDefinition>;

    fn query(&self, fixture_library: &FixtureLibrary) -> anyhow::Result<Self::Result> {
        Ok(fixture_library.list_definitions())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
