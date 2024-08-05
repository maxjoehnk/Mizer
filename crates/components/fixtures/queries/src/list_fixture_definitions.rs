use mizer_commander::{Query, Ref};
use mizer_fixtures::definition::FixtureDefinition;
use mizer_fixtures::library::FixtureLibrary;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListFixtureDefinitionsQuery {
    pub gdtf: bool,
    pub ofl: bool,
    pub qlc: bool,
    pub mizer: bool,
}

impl Default for ListFixtureDefinitionsQuery {
    fn default() -> Self {
        Self {
            gdtf: true,
            ofl: true,
            qlc: true,
            mizer: true,
        }
    }
}

impl<'a> Query<'a> for ListFixtureDefinitionsQuery {
    type Dependencies = Ref<FixtureLibrary>;
    type Result = Vec<FixtureDefinition>;

    fn query(&self, fixture_library: &FixtureLibrary) -> anyhow::Result<Self::Result> {
        Ok(fixture_library
            .list_definitions()
            .into_iter()
            .filter(|definition| {
                (self.gdtf && definition.provider == "GDTF")
                    || (self.ofl && definition.provider == "Open Fixture Library")
                    || (self.qlc && definition.provider == "QLC+")
                    || (self.mizer && definition.provider == "Mizer")
            })
            .collect())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
