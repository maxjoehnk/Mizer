use crate::apis::transport::Timecode;
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
pub extern "C" fn read_dial_value(ptr: *const LayoutRef, path: *const c_char) -> FFIDialValue {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_dial_value(&node_path).unwrap_or_default();
    let ffi_value = FFIDialValue {
        value: value.value,
        min: value.min,
        max: value.max,
        is_percentage: if value.percentage { 1 } else { 0 },
    };

    std::mem::forget(ffi);

    ffi_value
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
pub extern "C" fn read_clock_value(ptr: *const LayoutRef, path: *const c_char) -> Timecode {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = ffi.view.get_clock_value(&node_path).unwrap_or_default();

    std::mem::forget(ffi);

    value.into()
}

#[no_mangle]
pub extern "C" fn read_control_color(
    ptr: *const LayoutRef,
    path: *const c_char,
) -> FFIControlColor {
    let path = unsafe { CStr::from_ptr(path) };
    let path = path.to_str().unwrap();
    let node_path = NodePath(path.to_string());
    let ffi = Arc::from_pointer(ptr);

    let value = if let Some(value) = ffi.view.get_control_color(&node_path) {
        FFIControlColor {
            has_color: 1,
            color_red: value.red,
            color_green: value.green,
            color_blue: value.blue,
        }
    } else {
        FFIControlColor {
            has_color: 0,
            color_red: 0.,
            color_green: 0.,
            color_blue: 0.,
        }
    };

    std::mem::forget(ffi);

    value
}

#[no_mangle]
pub extern "C" fn drop_layout_pointer(ptr: *const LayoutRef) {
    drop_pointer(ptr);
}

#[derive(Default)]
#[repr(C)]
pub struct FFIControlColor {
    pub has_color: u8,
    pub color_red: f64,
    pub color_green: f64,
    pub color_blue: f64,
}

#[derive(Default)]
#[repr(C)]
pub struct FFIDialValue {
    pub value: f64,
    pub min: f64,
    pub max: f64,
    pub is_percentage: u8,
}
