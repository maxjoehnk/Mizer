use crate::{TimecodeControl, TimecodeManager};
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};

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
