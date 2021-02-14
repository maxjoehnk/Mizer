use std::sync::atomic::AtomicBool;
use std::sync::atomic::Ordering;
use std::ops::Deref;
use std::sync::Arc;
use crossbeam::epoch;
use crate::{ReceiverGuard, NodePortPayload};
use std::fmt::Debug;

#[derive(Clone)]
pub struct Swap<T> {
    buffer: Arc<epoch::Atomic<T>>,
    dirty: Arc<AtomicBool>,
}

impl<T> Swap<T> {
    pub fn new() -> Self {
        Swap {
            buffer: Default::default(),
            dirty: Default::default(),
        }
    }

    pub fn store(&self, data: T) {
        let owned = epoch::Owned::new(data);
        self.buffer.store(owned, Ordering::Release);
        self.dirty.store(true, Ordering::Release);
    }

    pub fn get(&self) -> Option<SwapReadGuard<T>> {
        self.dirty.swap(false, Ordering::AcqRel).then(|| {
            SwapReadGuard::new(&self.buffer)
        })
    }
}

pub struct SwapReadGuard<'a, T> {
    buffer: &'a epoch::Atomic<T>,
    guard: epoch::Guard,
}

impl<'a, T> SwapReadGuard<'a, T> {
    fn new(buffer: &'a epoch::Atomic<T>) -> Self {
        SwapReadGuard {
            buffer,
            guard: epoch::pin(),
        }
    }

    // TODO: read when acquiring guard
    fn read(&self) -> epoch::Shared<T> {
        self.buffer.load(Ordering::Acquire, &self.guard)
    }
}

impl<'a, T> Deref for SwapReadGuard<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        let ptr = self.read();
        if ptr.is_null() {
            panic!("tried to read from null ptr");
        }
        unsafe { ptr.deref() }
    }
}

impl<'a, T> ReceiverGuard<T> for SwapReadGuard<'a, NodePortPayload<T>> where T: Debug + Clone + PartialEq {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn get_should_return_initial_value() {
        let buffer = vec![1, 2, 3, 4, 5];
        let swap = Swap::new();
        swap.store(buffer.clone());

        let guard = swap.get().unwrap();
        let result = guard.deref();

        assert_eq!(result, &buffer);
    }

    #[test]
    fn store_should_allow_writing_while_reading() {
        let buffer1 = vec![1, 2, 3, 4, 5];
        let buffer2 = vec![5, 4, 1, 2, 3];
        let swap = Swap::new();
        swap.store(buffer1.clone());
        let guard = swap.get().unwrap();
        let result = guard.deref();

        swap.store(buffer2);

        assert_eq!(result, &buffer1);
    }

    #[test]
    fn reading_get_after_dropping_guard_should_return_new_buffer() {
        let buffer1 = vec![1, 2, 3, 4, 5];
        let buffer2 = vec![5, 4, 1, 2, 3];
        let swap = Swap::new();
        swap.store(buffer1.clone());
        let guard1 = swap.get().unwrap();
        let first_read = guard1.deref();
        swap.store(buffer2.clone());

        let guard2 = swap.get().unwrap();
        let second_read = guard2.deref();

        assert_eq!(first_read, &buffer1);
        assert_eq!(second_read, &buffer2);
    }
}
