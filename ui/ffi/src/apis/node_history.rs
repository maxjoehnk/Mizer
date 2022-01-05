use crate::types::{drop_pointer, Array, FFIFromPointer};
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

pub struct NodeHistory {
    pub history: Arc<NonEmptyPinboard<Vec<f64>>>,
}

#[no_mangle]
pub extern "C" fn read_node_history(ptr: *const NodeHistory) -> Array<f64> {
    let ffi = Arc::from_pointer(ptr);

    let values = ffi.history.read();

    std::mem::forget(ffi);

    values.into()
}

#[no_mangle]
pub extern "C" fn drop_node_history_pointer(ptr: *const NodeHistory) {
    drop_pointer(ptr);
}
