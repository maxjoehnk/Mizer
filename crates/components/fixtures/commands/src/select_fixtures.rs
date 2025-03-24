use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::selection::FixtureSelection;
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct SelectFixturesCommand {
    pub fixtures: Vec<FixtureId>,
}
impl<'a> Command<'a> for SelectFixturesCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = FixtureSelection;
    type Result = ();

    fn label(&self) -> String {
        format!("Select {}", self.fixtures.iter().map(|f| f.to_string()).collect::<Vec<_>>().join(", "))
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut programmer = fixture_manager.get_programmer();
        let previous = programmer.active_selection();
        programmer.select_fixtures(self.fixtures.clone());

        Ok(((), previous))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        previous_selection: Self::State,
    ) -> anyhow::Result<()> {
        let mut programmer = fixture_manager.get_programmer();
        programmer.set_selection(previous_selection);

        Ok(())
    }
}
