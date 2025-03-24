use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::GroupId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct CallGroupCommand {
    pub group_id: GroupId,
}

impl<'a> Command<'a> for CallGroupCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Call {}", self.group_id)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        if let Some(group) = fixture_manager.get_group(self.group_id) {
            let mut programmer = fixture_manager.get_programmer();
            programmer.select_group(&group);
        }

        Ok(((), ()))
    }

    fn revert(&self, fixture_manager: &FixtureManager, _: Self::State) -> anyhow::Result<()> {
        // TODO: Implement revert for programmer

        Ok(())
    }
}
