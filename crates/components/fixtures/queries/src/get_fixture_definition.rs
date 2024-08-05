use mizer_commander::{Query, Ref};
use mizer_fixtures::definition::FixtureDefinition;
use mizer_fixtures::library::FixtureLibrary;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct GetFixtureDefinitionQuery {
    pub definition_id: String,
}

impl<'a> Query<'a> for GetFixtureDefinitionQuery {
    type Dependencies = Ref<FixtureLibrary>;
    type Result = Option<FixtureDefinition>;

    fn query(&self, fixture_library: &FixtureLibrary) -> anyhow::Result<Self::Result> {
        Ok(fixture_library.get_definition(&self.definition_id))
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
