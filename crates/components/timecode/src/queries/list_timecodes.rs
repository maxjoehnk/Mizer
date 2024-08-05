use crate::{TimecodeManager, TimecodeTrack};
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListTimecodeTracksQuery;

impl<'a> Query<'a> for ListTimecodeTracksQuery {
    type Dependencies = Ref<TimecodeManager>;
    type Result = Vec<TimecodeTrack>;

    fn query(&self, timecode_manager: &TimecodeManager) -> anyhow::Result<Self::Result> {
        Ok(timecode_manager.timecodes())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
