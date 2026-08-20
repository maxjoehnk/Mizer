use std::ffi::{c_char, CString};
use std::sync::Arc;

use mizer_runtime::NodePreviewRef;
use mizer_util::StructuredData;

use crate::apis::programmer::FFIColorValue;
use crate::apis::transport::Timecode;
use crate::types::{drop_pointer, Array, FFIFromPointer};

pub struct NodeHistory {
    preview_ref: NodePreviewRef,
}

impl NodeHistory {
    pub fn new(preview_ref: NodePreviewRef) -> Self {
        Self {
            preview_ref,
        }
    }

    fn convert(&self, data: StructuredData) -> FFIStructuredData {
        match data {
            StructuredData::Boolean(bool) => FFIStructuredData::boolean(bool),
            StructuredData::Float(float) => FFIStructuredData::float(float),
            StructuredData::Int(int) => FFIStructuredData::int(int),
            StructuredData::Text(text) => FFIStructuredData::text(CString::new(text).unwrap_or_default().into_raw()),
            StructuredData::Array(array) => FFIStructuredData::array(
                array
                    .into_iter()
                    .map(|item| self.convert(item))
                    .collect(),
            ),
            StructuredData::Object(map) => FFIStructuredData::object(
                map.into_iter()
                    .map(|(key, value)| FFIStructuredDataObjectEntry {
                        key: CString::new(key).unwrap_or_default().into_raw(),
                        value: self.convert(value),
                    })
                    .collect(),
            ),
            StructuredData::Null => FFIStructuredData::null(),
        }
    }
}

#[derive(Clone, Copy)]
#[repr(C)]
pub struct FFIStructuredData {
    pub r#type: FFIStructuredDataType,
    pub value: FFIStructuredDataValue,
}

impl FFIStructuredData {
    fn text(text: *mut c_char) -> Self {
        Self {
            r#type: FFIStructuredDataType::Text,
            value: FFIStructuredDataValue { text },
        }
    }

    fn float(float: f64) -> Self {
        Self {
            r#type: FFIStructuredDataType::Float,
            value: FFIStructuredDataValue {
                floating_point: float,
            },
        }
    }

    fn int(int: i64) -> Self {
        Self {
            r#type: FFIStructuredDataType::Int,
            value: FFIStructuredDataValue { integer: int },
        }
    }

    fn boolean(boolean: bool) -> Self {
        Self {
            r#type: FFIStructuredDataType::Boolean,
            value: FFIStructuredDataValue {
                boolean: boolean.into(),
            },
        }
    }

    fn array(array: Array<FFIStructuredData>) -> Self {
        Self {
            r#type: FFIStructuredDataType::Array,
            value: FFIStructuredDataValue { array },
        }
    }

    fn object(object: Array<FFIStructuredDataObjectEntry>) -> Self {
        Self {
            r#type: FFIStructuredDataType::Object,
            value: FFIStructuredDataValue { object },
        }
    }

    fn null() -> Self {
        Self {
            r#type: FFIStructuredDataType::Null,
            value: FFIStructuredDataValue { null: () },
        }
    }

    pub(crate) fn as_array(&self) -> Option<Array<FFIStructuredData>> {
        if let FFIStructuredDataType::Array = self.r#type {
            Some(unsafe { self.value.array })
        } else {
            None
        }
    }

    pub(crate) fn as_object(&self) -> Option<Array<FFIStructuredDataObjectEntry>> {
        if let FFIStructuredDataType::Object = self.r#type {
            Some(unsafe { self.value.object })
        } else {
            None
        }
    }

    pub(crate) fn as_text(&self) -> Option<CString> {
        if let FFIStructuredDataType::Text = self.r#type {
            Some(unsafe { CString::from_raw(self.value.text) })
        } else {
            None
        }
    }
}

#[derive(Clone, Copy)]
#[repr(C)]
pub enum FFIStructuredDataType {
    Text = 0,
    Float = 1,
    Int = 2,
    Boolean = 3,
    Array = 4,
    Object = 5,
    Null = 6,
}

#[derive(Clone, Copy)]
#[repr(C)]
pub union FFIStructuredDataValue {
    pub text: *mut c_char,
    pub floating_point: f64,
    pub integer: i64,
    pub boolean: u8,
    pub array: Array<FFIStructuredData>,
    pub object: Array<FFIStructuredDataObjectEntry>,
    pub null: (),
}

#[derive(Clone, Copy)]
#[repr(C)]
pub struct FFIStructuredDataObjectEntry {
    pub key: *mut c_char,
    pub value: FFIStructuredData,
}

#[no_mangle]
pub extern "C" fn read_node_history(ptr: *const NodeHistory) -> Array<f64> {
    let ffi = Arc::from_pointer(ptr);

    let values = ffi.preview_ref.read_history().unwrap_or_default();

    std::mem::forget(ffi);

    values.into()
}

#[no_mangle]
pub extern "C" fn read_node_data_preview(ptr: *const NodeHistory) -> FFIStructuredData {
    let ffi = Arc::from_pointer(ptr);

    let data = ffi.preview_ref.read_data().unwrap_or_default();
    let data = ffi.convert(data);

    std::mem::forget(ffi);

    data
}

#[no_mangle]
pub extern "C" fn read_node_color_preview(ptr: *const NodeHistory) -> FFIColorValue {
    let ffi = Arc::from_pointer(ptr);

    let data = ffi.preview_ref.read_color().unwrap_or_default();

    std::mem::forget(ffi);

    FFIColorValue {
        red: data.red,
        green: data.green,
        blue: data.blue,
    }
}

#[no_mangle]
pub extern "C" fn read_node_timecode_preview(ptr: *const NodeHistory) -> Timecode {
    let ffi = Arc::from_pointer(ptr);

    let data = ffi.preview_ref.read_timecode().unwrap_or_default();

    std::mem::forget(ffi);

    data.into()
}

#[no_mangle]
pub extern "C" fn drop_node_history_pointer(ptr: *const NodeHistory) {
    drop_pointer(ptr);
}

#[no_mangle]
pub extern "C" fn read_node_multi_preview(ptr: *const NodeHistory) -> Array<f64> {
    let ffi = Arc::from_pointer(ptr);

    let values = ffi.preview_ref.read_multi().unwrap_or_default();

    std::mem::forget(ffi);

    values.into()
}

#[no_mangle]
pub extern "C" fn drop_structured_data(data: FFIStructuredData) {
    if let Some(array) = data.as_array() {
        let vec = array.into_vec();
        for item in vec {
            drop_structured_data(item);
        }
    }else if let Some(object) = data.as_object() {
        let vec = object.into_vec();
        for item in vec {
            let key = unsafe { CString::from_raw(item.key) };
            drop(key);
            drop_structured_data(item.value);
        }
    }else if let Some(text) = data.as_text() {
        drop(text)
    }
}
