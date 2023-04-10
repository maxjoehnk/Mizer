use std::iter::FromIterator;
use std::sync::Arc;

#[derive(Clone, Copy)]
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
            array: vec.as_ptr(),
        };
        std::mem::forget(vec);

        array
    }
}

impl<T> FromIterator<T> for Array<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let vec: Vec<T> = iter.into_iter().collect();

        vec.into()
    }
}

/// Split into two traits so FFIFromPointer can be kept internal to the ffi crate
pub trait FFIToPointer<T>: FFIFromPointer<T> {
    fn to_pointer(&self) -> u64;
}

pub trait FFIFromPointer<T> {
    fn from_pointer(ptr: *const T) -> Self;
}

impl<T> FFIFromPointer<T> for Arc<T> {
    fn from_pointer(ptr: *const T) -> Arc<T> {
        unsafe { Arc::from_raw(ptr) }
    }
}

impl<T> FFIToPointer<T> for Arc<T> {
    fn to_pointer(&self) -> u64 {
        let ptr = Arc::into_raw(Arc::clone(self));

        ptr as u64
    }
}

pub fn drop_pointer<T>(ptr: *const T) {
    let ffi: Arc<T> = Arc::from_pointer(ptr);

    drop(ffi);
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::Arc;

    #[test]
    fn creating_pointer_should_increase_reference_count() {
        let data = Arc::new(0);

        let _ = data.to_pointer();

        assert_eq!(Arc::strong_count(&data), 2);
    }

    #[test]
    fn dropping_pointer_should_decreate_reference_count() {
        let data = Arc::new(0);
        let ptr = data.to_pointer() as *const i32;

        drop_pointer(ptr);

        assert_eq!(Arc::strong_count(&data), 1);
    }

    #[test]
    fn reading_pointer_should_not_increase_reference_count() {
        let data = Arc::new(0);
        let ptr = data.to_pointer() as *const i32;

        let content = Arc::<i32>::from_pointer(ptr);
        std::mem::forget(content);

        assert_eq!(Arc::strong_count(&data), 2);
    }
}
