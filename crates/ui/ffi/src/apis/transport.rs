use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_clock::ClockSnapshot;

use crate::types::{drop_pointer, FFIFromPointer};

pub struct Transport {
    pub clock_ref: Arc<NonEmptyPinboard<ClockSnapshot>>,
}

#[derive(Default)]
#[repr(C)]
pub struct Timecode {
    pub hours: u64,
    pub minutes: u64,
    pub seconds: u64,
    pub frames: u64,
    pub is_negative: u8,
}

impl From<mizer_clock::Timecode> for Timecode {
    fn from(tc: mizer_clock::Timecode) -> Self {
        Self {
            hours: tc.hours,
            minutes: tc.minutes,
            seconds: tc.seconds,
            frames: tc.frames,
            is_negative: tc.negative.into(),
        }
    }
}

#[no_mangle]
pub extern "C" fn read_timecode(ptr: *const Transport) -> Timecode {
    let ffi = Arc::from_pointer(ptr);

    let snapshot = ffi.clock_ref.read();

    std::mem::forget(ffi);

    snapshot.time.into()
}

#[no_mangle]
pub extern "C" fn drop_transport_pointer(ptr: *const Transport) {
    drop_pointer(ptr);
}
