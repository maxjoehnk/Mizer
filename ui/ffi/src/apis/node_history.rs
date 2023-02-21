use crate::apis::transport::Timecode;
use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_timecode::TimecodeStateAccess;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

pub struct NodeHistory {
    pub history: Arc<NonEmptyPinboard<Vec<f64>>>,
}

pub struct NodePreview {
    pub timecode: TimecodeStateAccess,
}

#[no_mangle]
pub extern "C" fn read_node_history(ptr: *const NodeHistory) -> Array<f64> {
    let ffi = Arc::from_pointer(ptr);

    let values = ffi.history.read();

    std::mem::forget(ffi);

    values.into()
}

#[no_mangle]
pub extern "C" fn read_node_timecode(ptr: *const NodePreview) -> Timecode {
    let ffi = Arc::from_pointer(ptr);
    let timecode = ffi.timecode.get_timecode();

    std::mem::forget(ffi);

    timecode.unwrap_or_default().into()
}

#[no_mangle]
pub extern "C" fn drop_node_history_pointer(ptr: *const NodeHistory) {
    drop_pointer(ptr);
}

#[no_mangle]
pub extern "C" fn drop_node_preview_pointer(ptr: *const NodePreview) {
    drop_pointer(ptr);
}
