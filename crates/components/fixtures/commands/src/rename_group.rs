use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::GroupId;

#[derive(Debug, Deserialize, Serialize)]
pub struct RenameGroupCommand {
    pub id: GroupId,
    pub name: String,
}

impl<'a> Command<'a> for RenameGroupCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!("Name {} {}", self.id, self.name)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut group = fixture_manager
            .groups
            .get_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.id))?;

        let mut name = self.name.clone();
        std::mem::swap(&mut group.name, &mut name);

        Ok(((), name))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        mut label: Self::State,
    ) -> anyhow::Result<()> {
        let mut group = fixture_manager
            .groups
            .get_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.id))?;

        std::mem::swap(&mut group.name, &mut label);

        Ok(())
    }
}
