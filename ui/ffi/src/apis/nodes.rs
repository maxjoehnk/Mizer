use crate::pointer_inventory::PointerInventory;
use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_runtime::NodeMetadataRef;
use parking_lot::Mutex;
use std::ffi::c_char;
use std::sync::Arc;

pub struct NodesRef {
    metadata_ref: NodeMetadataRef,
    pointer_inventory: Mutex<PointerInventory>,
}

impl NodesRef {
    pub fn new(metadata_ref: NodeMetadataRef) -> Self {
        Self {
            metadata_ref,
            pointer_inventory: Default::default(),
        }
    }

    fn get_port_metadata<B: FromIterator<FFINodePortMetadata>>(&self) -> B {
        let mut pointer_inventory = self.pointer_inventory.lock();
        let data = self.metadata_ref.get_all_port_metadata();

        data.into_iter()
            .map(|(path, port, metadata)| FFINodePortMetadata {
                node_path: pointer_inventory.allocate_string(path.to_string()),
                port_id: pointer_inventory.allocate_string(port.to_string()),
                pushed_value: metadata.pushed_value.into(),
            })
            .collect()
    }
}

#[no_mangle]
pub extern "C" fn read_node_port_metadata(ptr: *const NodesRef) -> Array<FFINodePortMetadata> {
    let ffi = Arc::from_pointer(ptr);

    let data = ffi.get_port_metadata();

    std::mem::forget(ffi);

    data
}

#[no_mangle]
pub extern "C" fn drop_nodes_pointer(ptr: *const NodesRef) {
    drop_pointer(ptr);
}

#[repr(C)]
pub struct FFINodePortMetadata {
    pub node_path: *const c_char,
    pub port_id: *const c_char,
    pub pushed_value: u8,
}
