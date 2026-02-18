use std::ffi::c_char;
use std::sync::Arc;

use parking_lot::Mutex;

use mizer_runtime::NodePreviewRef;
use mizer_util::StructuredData;

use crate::apis::programmer::FFIColorValue;
use crate::apis::transport::Timecode;
use crate::pointer_inventory::PointerInventory;
use crate::types::{drop_pointer, Array, FFIFromPointer};

pub struct NodeHistory {
    preview_ref: NodePreviewRef,
    pointer_inventory: Mutex<PointerInventory>,
}

impl NodeHistory {
    pub fn new(preview_ref: NodePreviewRef) -> Self {
        Self {
            preview_ref,
            pointer_inventory: Default::default(),
        }
    }

    // TODO: This should probably drop old inventory after 2 generations
    fn convert(&self, data: StructuredData) -> FFIStructuredData {
        let mut inventory = self.pointer_inventory.lock();
        convert_with_inventory(data, &mut inventory)
    }
}

fn convert_with_inventory(
    data: StructuredData,
    inventory: &mut PointerInventory,
) -> FFIStructuredData {
    match data {
        StructuredData::Boolean(bool) => FFIStructuredData::boolean(bool),
        StructuredData::Float(float) => FFIStructuredData::float(float),
        StructuredData::Int(int) => FFIStructuredData::int(int),
        StructuredData::Text(text) => FFIStructuredData::text(inventory.allocate_string(text)),
        StructuredData::Array(array) => FFIStructuredData::array(
            array
                .into_iter()
                .map(|item| convert_with_inventory(item, inventory))
                .collect(),
        ),
        StructuredData::Object(map) => FFIStructuredData::object(
            map.into_iter()
                .map(|(key, value)| FFIStructuredDataObjectEntry {
                    key: inventory.allocate_string(key),
                    value: convert_with_inventory(value, inventory),
                })
                .collect(),
        ),
        StructuredData::Null => FFIStructuredData::null(),
    }
}

#[derive(Clone, Copy)]
#[repr(C)]
pub struct FFIStructuredData {
    pub r#type: FFIStructuredDataType,
    pub value: FFIStructuredDataValue,
}

impl FFIStructuredData {
    fn text(text: *const c_char) -> Self {
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
    pub text: *const c_char,
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
    pub key: *const c_char,
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
