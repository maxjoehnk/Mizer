use crate::StoreGroupMode;
use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::selection::FixtureSelection;
use mizer_fixtures::GroupId;
use serde::{Deserialize, Serialize};
use std::ops::Deref;

#[derive(Debug, Deserialize, Serialize)]
pub struct AssignProgrammerToGroupCommand {
    pub group_id: GroupId,
    pub mode: StoreGroupMode,
}

impl<'a> Command<'a> for AssignProgrammerToGroupCommand {
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
        let old = group.selection.deref().clone();
        let selection = {
            let programmer = fixture_manager.get_programmer();
            programmer.active_selection()
        };
        match self.mode {
            StoreGroupMode::Overwrite => {
                group.selection = selection.into();
            }
            StoreGroupMode::Merge => {
                group
                    .selection
                    .add_fixtures(selection.get_fixtures().into_iter().flatten().collect());
            }
            StoreGroupMode::Subtract => {
                for fixture in selection.get_fixtures().into_iter().flatten() {
                    group.selection.remove(&fixture);
                }
            }
        }

        Ok(((), old))
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
