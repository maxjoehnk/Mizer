use std::ops::Deref;
use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureId, GroupId};
use serde::{Deserialize, Serialize};
use mizer_fixtures::selection::FixtureSelection;

#[derive(Debug, Deserialize, Serialize)]
pub struct AssignFixturesToGroupCommand {
    pub group_id: GroupId,
    pub fixture_ids: Vec<FixtureId>,
}

impl<'a> Command<'a> for AssignFixturesToGroupCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = FixtureSelection;
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
        let fixture_ids = group.selection.deref().clone();
        group.selection.add_fixtures(self.fixture_ids.clone());

        Ok(((), fixture_ids))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        selection: Self::State,
    ) -> anyhow::Result<()> {
        let mut group = fixture_manager
            .groups
            .get_mut(&self.group_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.group_id))?;
        group.selection = selection.into();

        Ok(())
    }
}
