use crate::apis::transport::Timecode;
use crate::pointer_inventory::PointerInventory;
use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_node::NodePreviewRef;
use mizer_timecode::TimecodeStateAccess;
use mizer_util::StructuredData;
use parking_lot::Mutex;
use std::ffi::c_char;
use std::sync::Arc;

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
    }
}

pub struct NodePreview {
    pub timecode: TimecodeStateAccess,
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
