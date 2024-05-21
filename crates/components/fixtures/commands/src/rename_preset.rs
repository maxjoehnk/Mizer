use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;

#[derive(Debug, Deserialize, Serialize)]
pub struct RenamePresetCommand {
    pub id: PresetId,
    pub label: String,
}

impl<'a> Command<'a> for RenamePresetCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = Option<String>;
    type Result = ();

    fn label(&self) -> String {
        format!("Rename Preset {} to '{}'", self.id, self.label)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut preset = fixture_manager
            .presets
            .get_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown preset {}", self.id))?;

        let mut name = Some(self.label.clone());
        std::mem::swap(preset.name_mut(), &mut name);

        Ok(((), name))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        mut label: Self::State,
    ) -> anyhow::Result<()> {
        let mut preset = fixture_manager
            .presets
            .get_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown preset {}", self.id))?;

        std::mem::swap(preset.name_mut(), &mut label);

        Ok(())
    }
}
