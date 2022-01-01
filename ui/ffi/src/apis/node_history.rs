use std::sync::Arc;
use pinboard::NonEmptyPinboard;
use crate::types::{Array, drop_pointer, FFIFromPointer};

pub struct NodeHistory {
    pub history: Arc<NonEmptyPinboard<Vec<f64>>>
}

#[no_mangle]
pub extern fn read_node_history(ptr: *const NodeHistory) -> Array<f64> {
    let ffi = Arc::from_pointer(ptr);

    let values = ffi.history.read();

    std::mem::forget(ffi);

    values.into()
}

#[no_mangle]
pub extern fn drop_node_history_pointer(ptr: *const NodeHistory) {
    drop_pointer(ptr);
}

