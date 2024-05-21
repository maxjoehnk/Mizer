use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};

use crate::{TimecodeControlId, TimecodeManager};

#[derive(Debug, Deserialize, Serialize)]
pub struct RenameTimecodeControlCommand {
    pub id: TimecodeControlId,
    pub name: String,
}

impl<'a> Command<'a> for RenameTimecodeControlCommand {
    type Dependencies = Ref<TimecodeManager>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!("Rename Timecode Control {} to '{}'", self.id, self.name)
    }

    fn apply(&self, manager: &TimecodeManager) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous_name = None;
        manager.update_timecode_control(self.id, |control| {
            previous_name = Some(control.name.clone());
            control.name = self.name.clone();
        })?;
        let previous_name =
            previous_name.ok_or_else(|| anyhow::anyhow!("Unable to get previous name"))?;

        Ok(((), previous_name))
    }

    fn revert(&self, manager: &TimecodeManager, previous_name: Self::State) -> anyhow::Result<()> {
        manager.update_timecode_control(self.id, |control| {
            control.name = previous_name;
        })?;

        Ok(())
    }
}
