use std::sync::Arc;

use mizer_timecode::{TimecodeId, TimecodeManager};

use crate::apis::transport::Timecode;
use crate::types::{drop_pointer, FFIFromPointer};

pub struct TimecodeApi {
    timecode_manager: TimecodeManager,
}

impl TimecodeApi {
    pub fn new(timecode_manager: TimecodeManager) -> Self {
        Self { timecode_manager }
    }
}

#[no_mangle]
pub extern "C" fn read_timecode_clock(ptr: *const TimecodeApi, timecode_id: u32) -> Timecode {
    let ffi = Arc::from_pointer(ptr);

    let Some(state) = ffi
        .timecode_manager
        .get_state_access(TimecodeId(timecode_id))
    else {
        std::mem::forget(ffi);

        return Timecode::default();
    };

    let timecode = state.get_timecode().map(Timecode::from).unwrap_or_default();

    std::mem::forget(ffi);

    timecode
}

#[no_mangle]
pub extern "C" fn drop_timecode_pointer(ptr: *const TimecodeApi) {
    drop_pointer(ptr);
}
