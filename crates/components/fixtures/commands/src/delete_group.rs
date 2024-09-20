use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::Group;
use mizer_fixtures::GroupId;

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteGroupCommand {
    pub id: GroupId,
}

impl<'a> Command<'a> for DeleteGroupCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = Group;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Group {}", self.id)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let group = fixture_manager
            .delete_group(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.id))?;

        Ok(((), group))
    }

    fn revert(&self, fixture_manager: &FixtureManager, group: Self::State) -> anyhow::Result<()> {
        fixture_manager.groups.insert(group.id, group);

        Ok(())
    }
}
