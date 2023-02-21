use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};

use crate::{TimecodeId, TimecodeManager, TimecodeTrack};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddTimecodeCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddTimecodeCommand {
    type Dependencies = Ref<TimecodeManager>;
    type State = TimecodeId;
    type Result = TimecodeTrack;

    fn label(&self) -> String {
        format!("Add Timecode '{}'", self.name)
    }

    fn apply(&self, manager: &TimecodeManager) -> anyhow::Result<(Self::Result, Self::State)> {
        let timecode = manager.add_timecode(self.name.clone());
        let id = timecode.id;

        Ok((timecode, id))
    }

    fn revert(&self, manager: &TimecodeManager, timecode_id: Self::State) -> anyhow::Result<()> {
        manager.remove_timecode(timecode_id);

        Ok(())
    }
}
