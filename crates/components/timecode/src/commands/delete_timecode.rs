use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};

use crate::{TimecodeId, TimecodeManager, TimecodeTrack};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteTimecodeCommand {
    pub id: TimecodeId,
}

impl<'a> Command<'a> for DeleteTimecodeCommand {
    type Dependencies = Ref<TimecodeManager>;
    type State = TimecodeTrack;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Timecode '{}'", self.id)
    }

    fn apply(&self, manager: &TimecodeManager) -> anyhow::Result<(Self::Result, Self::State)> {
        let timecode = manager
            .remove_timecode(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown timecode {}", self.id))?;

        Ok(((), timecode))
    }

    fn revert(&self, manager: &TimecodeManager, timecode: Self::State) -> anyhow::Result<()> {
        manager.insert_timecode(timecode);

        Ok(())
    }
}
