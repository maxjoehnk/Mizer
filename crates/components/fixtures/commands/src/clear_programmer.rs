use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ClearProgrammerCommand;

impl<'a> Command<'a> for ClearProgrammerCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        "Clear".to_string()
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut programmer = fixture_manager.get_programmer();
        programmer.clear();

        Ok(((), ()))
    }

    fn revert(&self, fixture_manager: &FixtureManager, _: Self::State) -> anyhow::Result<()> {
        // TODO: actually revert the programmer state
        Ok(())
    }
}
