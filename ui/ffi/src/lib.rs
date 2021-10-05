use std::sync::Arc;
use std::iter::FromIterator;
use pinboard::NonEmptyPinboard;

pub struct NodeHistory {
    pub history: Arc<NonEmptyPinboard<Vec<f64>>>
}

#[no_mangle]
pub extern fn read_node_history(ptr: *const NodeHistory) -> Array<f64> {
    let ffi: Arc<NodeHistory> = FFIPointer::from_pointer(ptr);

    let values = ffi.history.read();

    std::mem::forget(ffi);

    values.into()
}

#[no_mangle]
pub extern fn drop_pointer(ptr: *const NodeHistory) {
    let ffi: Arc<NodeHistory> = FFIPointer::from_pointer(ptr);

    drop(ffi);
}

#[repr(C)]
pub struct Array<T> {
    len: usize,
    array: *const T,
}

impl<T> From<Vec<T>> for Array<T> {
    fn from(mut vec: Vec<T>) -> Self {
        vec.shrink_to_fit();
        let array = Array {
            len: vec.len(),
            array: vec.as_ptr()
        };
        std::mem::forget(vec);

        array
    }
}

impl<T> FromIterator<T> for Array<T> {
    fn from_iter<I: IntoIterator<Item=T>>(iter: I) -> Self {
        let vec: Vec<T> = iter.into_iter().collect();

        vec.into()
    }
}

pub trait FFIPointer<T> {
    fn from_pointer(ptr: *const T) -> Self;

    fn to_pointer(&self) -> u64;
}

impl<T> FFIPointer<T> for Arc<T> {
    fn from_pointer(ptr: *const T) -> Arc<T> {
        unsafe { Arc::from_raw(ptr) }
    }

    fn to_pointer(&self) -> u64 {
        let ptr = Arc::into_raw(Arc::clone(&self));

        ptr as u64
    }
}
