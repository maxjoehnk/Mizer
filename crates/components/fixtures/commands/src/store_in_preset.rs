use mizer_commander::{Command, Ref};
use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct StoreInPresetCommand {
    pub id: PresetId,
    pub values: Vec<FixtureControlValue>,
}

impl<'a> Command<'a> for StoreInPresetCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = Vec<FixtureControlValue>;
    type Result = ();

    fn label(&self) -> String {
        format!("Store {}", self.id)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let values = fixture_manager.store_in_preset(self.id, self.values.clone())?;

        Ok(((), values))
    }

    fn revert(&self, fixture_manager: &FixtureManager, values: Self::State) -> anyhow::Result<()> {
        fixture_manager.store_in_preset(self.id, values)?;

        Ok(())
    }
}
