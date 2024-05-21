use crate::{TimecodeControl, TimecodeControlId, TimecodeManager};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddTimecodeControlCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddTimecodeControlCommand {
    type Dependencies = Ref<TimecodeManager>;
    type State = TimecodeControlId;
    type Result = TimecodeControl;

    fn label(&self) -> String {
        format!("Add Timecode Control '{}'", self.name)
    }

    fn apply(&self, manager: &TimecodeManager) -> anyhow::Result<(Self::Result, Self::State)> {
        let control = manager.add_timecode_control(self.name.clone());
        let id = control.id;

        Ok((control, id))
    }

    fn revert(&self, manager: &TimecodeManager, control_id: Self::State) -> anyhow::Result<()> {
        manager.remove_timecode_control(control_id);

        Ok(())
    }
}
