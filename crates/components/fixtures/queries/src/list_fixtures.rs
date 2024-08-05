use mizer_commander::{Query, Ref};
use mizer_fixtures::fixture::Fixture;
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListFixturesQuery;

impl<'a> Query<'a> for ListFixturesQuery {
    type Dependencies = Ref<FixtureManager>;
    type Result = Vec<Fixture>;

    fn query(&self, fixture_manager: &FixtureManager) -> anyhow::Result<Self::Result> {
        Ok(fixture_manager
            .get_fixtures()
            .into_iter()
            .map(|f| f.clone())
            .collect())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
