use crate::types::{drop_pointer, FFIFromPointer};
use mizer_node::NodePath;
use mizer_runtime::LayoutsView;
use parking_lot::Mutex;
use std::collections::HashMap;
use std::ffi::{CStr, CString};
use std::os::raw::c_char;
use std::sync::Arc;

pub struct LayoutRef {
    pub view: LayoutsView,
    labels: Mutex<HashMap<*const c_char, CString>>,
}

impl LayoutRef {
    pub fn new(view: LayoutsView) -> Self {
        Self {
            view,
            labels: Default::default(),
        }
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
pub extern "C" fn read_dial_value(ptr: *const LayoutRef, path: *const c_char) -> f64 {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_dial_value(&node_path).unwrap_or_default();

    std::mem::forget(ffi);

    value
}

#[no_mangle]
pub extern "C" fn read_button_value(ptr: *const LayoutRef, path: *const c_char) -> u8 {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_button_value(&node_path).unwrap_or_default();

    std::mem::forget(ffi);

    value.into()
}

#[no_mangle]
pub extern "C" fn read_label_value(ptr: *const LayoutRef, path: *const c_char) -> *const c_char {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_label_value(&node_path).unwrap_or_default();
    let value = value.to_string();
    let value = CString::new(value).unwrap();
    let value_pointer = value.as_ptr();
    {
        let mut labels = ffi.labels.lock();
        labels.insert(value_pointer, value);
    }

    std::mem::forget(ffi);

    value_pointer
}

#[no_mangle]
pub extern "C" fn drop_layout_pointer(ptr: *const LayoutRef) {
    drop_pointer(ptr);
}
