use std::sync::Arc;

use mizer_message_bus::Subscriber;

use crate::types::{drop_pointer, FFIFromPointer};

pub struct StatusApi {
    fps_counter: Subscriber<f64>,
}

impl StatusApi {
    pub fn new(fps_counter: Subscriber<f64>) -> Self {
        Self { fps_counter }
    }
}

#[no_mangle]
pub extern "C" fn read_fps(ptr: *const StatusApi) -> f64 {
    let ffi = Arc::from_pointer(ptr);

    let fps = ffi.fps_counter.read_last().unwrap_or_default();

    std::mem::forget(ffi);

    fps
}

#[no_mangle]
pub extern "C" fn drop_status_pointer(ptr: *const StatusApi) {
    drop_pointer(ptr);
}
