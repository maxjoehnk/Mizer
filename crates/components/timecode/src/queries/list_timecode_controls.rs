use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use crate::{TimecodeControl, TimecodeManager};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListTimecodeControlsQuery;

impl<'a> Query<'a> for ListTimecodeControlsQuery {
    type Dependencies = Ref<TimecodeManager>;
    type Result = Vec<TimecodeControl>;

    fn query(&self, timecode_manager: &TimecodeManager) -> anyhow::Result<Self::Result> {
        Ok(timecode_manager.controls())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
