use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::Group;
use mizer_fixtures::GroupId;

#[derive(Debug, Deserialize, Serialize)]
pub struct AddGroupCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddGroupCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = GroupId;
    type Result = Group;

    fn label(&self) -> String {
        format!("Add Group {}", self.name)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let group_id = fixture_manager.add_group(self.name.clone());
        let group = Group {
            id: group_id,
            name: self.name.clone(),
            selection: Default::default(),
        };

        Ok((group, group_id))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        group_id: Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager
            .delete_group(group_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", group_id))?;

        Ok(())
    }
}
