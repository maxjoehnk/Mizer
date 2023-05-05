use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureId, GroupId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AssignFixturesToGroupCommand {
    pub group_id: GroupId,
    pub fixture_ids: Vec<FixtureId>,
}

impl<'a> Command<'a> for AssignFixturesToGroupCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = Vec<FixtureId>;
    type Result = ();

    fn label(&self) -> String {
        format!("Add Fixtures to Group {}", self.group_id)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut group = fixture_manager
            .groups
            .get_mut(&self.group_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.group_id))?;
        let fixture_ids = group.fixtures.clone();
        let mut add_ids = self.fixture_ids.clone();
        group.fixtures.append(&mut add_ids);

        Ok(((), fixture_ids))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        fixture_ids: Self::State,
    ) -> anyhow::Result<()> {
        let mut group = fixture_manager
            .groups
            .get_mut(&self.group_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.group_id))?;
        group.fixtures = fixture_ids;

        Ok(())
    }
}
