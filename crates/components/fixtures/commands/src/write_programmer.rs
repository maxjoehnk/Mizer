use mizer_commander::{Command, Ref};
use mizer_fixtures::definition::{FixtureControl, FixtureControlValue};
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct WriteProgrammerCommand {
    pub value: FixtureControlValue,
}

impl<'a> Command<'a> for WriteProgrammerCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        let control: FixtureControl = self.value.clone().into();

        format!("write {control} @ {:?}", self.value)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut programmer = fixture_manager.get_programmer_mut();

        programmer.write_control(self.value.clone());

        Ok(((), ()))
    }

    fn revert(&self, _fixture_manager: &FixtureManager, _: Self::State) -> anyhow::Result<()> {
        // TODO: Implement revert for programmer

        Ok(())
    }
}
