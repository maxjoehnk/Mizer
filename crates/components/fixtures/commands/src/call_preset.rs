use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct CallPresetCommand {
    pub preset_id: PresetId,
}

impl<'a> Command<'a> for CallPresetCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Call {}", self.preset_id)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut programmer = fixture_manager.get_programmer();
        programmer.call_preset(self.preset_id);

        Ok(((), ()))
    }

    fn revert(&self, fixture_manager: &FixtureManager, _: Self::State) -> anyhow::Result<()> {
        // TODO: Implement revert for programmer

        Ok(())
    }
}
