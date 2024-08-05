use mizer_commander::{Query, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::Group;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListGroupsQuery;

impl<'a> Query<'a> for ListGroupsQuery {
    type Dependencies = Ref<FixtureManager>;
    type Result = Vec<Group>;

    fn query(&self, fixture_manager: &FixtureManager) -> anyhow::Result<Self::Result> {
        let groups = fixture_manager
            .get_groups()
            .into_iter()
            .map(|g| g.clone())
            .collect();

        Ok(groups)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
