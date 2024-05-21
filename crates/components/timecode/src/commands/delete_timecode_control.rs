use crate::{
    TimecodeControl, TimecodeControlId, TimecodeControlValues, TimecodeId, TimecodeManager,
};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteTimecodeControlCommand {
    pub id: TimecodeControlId,
}

impl<'a> Command<'a> for DeleteTimecodeControlCommand {
    type Dependencies = Ref<TimecodeManager>;
    type State = (TimecodeControl, Vec<(TimecodeId, TimecodeControlValues)>);
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Timecode Control '{}'", self.id)
    }

    fn apply(&self, manager: &TimecodeManager) -> anyhow::Result<(Self::Result, Self::State)> {
        let control = manager
            .remove_timecode_control(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown timecode control {}", self.id))?;

        Ok(((), control))
    }

    fn revert(
        &self,
        manager: &TimecodeManager,
        (control, timecode_values): Self::State,
    ) -> anyhow::Result<()> {
        manager.insert_timecode_control(control, timecode_values);

        Ok(())
    }
}
