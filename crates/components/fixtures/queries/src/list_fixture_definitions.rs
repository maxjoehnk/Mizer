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
        let mut providers = vec![];
        if self.qlc {
            providers.push("QLC+");
        }
        if self.ofl {
            providers.push("Open Fixture Library");
        }
        if self.gdtf {
            providers.push("GDTF");
        }
        if self.mizer {
            providers.push("Mizer");
        }
        let definitions = fixture_library.list_definitions_by_providers(&providers);
        
        Ok(definitions)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
