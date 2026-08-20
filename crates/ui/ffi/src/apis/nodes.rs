use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_runtime::NodeMetadataRef;
use std::ffi::{c_char, CString};
use std::sync::Arc;

pub struct NodesRef {
    metadata_ref: NodeMetadataRef,
}

impl NodesRef {
    pub fn new(metadata_ref: NodeMetadataRef) -> Self {
        Self {
            metadata_ref,
        }
    }

    fn get_port_metadata<B: FromIterator<FFINodePortMetadata>>(&self) -> B {
        let data = self.metadata_ref.get_all_port_metadata();

        data.into_iter()
            .map(|(path, port, metadata)| FFINodePortMetadata {
                node_path: CString::new(path.to_string()).unwrap_or_default().into_raw(),
                port_id: CString::new(port.to_string()).unwrap_or_default().into_raw(),
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

#[no_mangle]
pub extern "C" fn drop_node_port_metadata(metadata: Array<FFINodePortMetadata>) {
    let vec = metadata.into_vec();
    for metadata in vec {
        unsafe {
            let _ = CString::from_raw(metadata.node_path);
            let _ = CString::from_raw(metadata.port_id);
        }
    }
}

#[repr(C)]
pub struct FFINodePortMetadata {
    pub node_path: *mut c_char,
    pub port_id: *mut c_char,
    pub pushed_value: u8,
}
