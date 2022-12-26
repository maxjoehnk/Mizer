use crate::types::{drop_pointer, FFIFromPointer};
use mizer_node::NodePath;
use mizer_runtime::LayoutsView;
use std::ffi::CStr;
use std::os::raw::c_char;
use std::sync::Arc;

pub struct LayoutRef {
    pub view: LayoutsView,
}

impl LayoutRef {
    pub fn new(view: LayoutsView) -> Self {
        Self { view }
    }
}

#[no_mangle]
pub extern "C" fn read_fader_value(ptr: *const LayoutRef, path: *const c_char) -> f64 {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_fader_value(&node_path).unwrap_or_default();

    std::mem::forget(ffi);

    value
}

#[no_mangle]
pub extern "C" fn read_button_value(ptr: *const LayoutRef, path: *const c_char) -> bool {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_button_value(&node_path).unwrap_or_default();

    std::mem::forget(ffi);

    value
}

#[no_mangle]
pub extern "C" fn drop_layout_pointer(ptr: *const LayoutRef) {
    drop_pointer(ptr);
}
