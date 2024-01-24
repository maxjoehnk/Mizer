use std::ops::Deref;
use std::thread::ThreadId;

pub struct ThreadPinned<T>(T, ThreadId);

impl<T> ThreadPinned<T> {
    pub fn new(data: T) -> Self {
        let id = std::thread::current().id();

        Self(data, id)
    }
}

impl<T> Deref for ThreadPinned<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        let current_thread_id = std::thread::current().id();
        assert_eq!(current_thread_id, self.1);

        &self.0
    }
}

impl<T: std::cmp::PartialEq> PartialEq<T> for ThreadPinned<T> {
    fn eq(&self, other: &T) -> bool {
        let value: &T = self.deref();

        value == other
    }
}

impl<T: std::cmp::PartialEq> PartialEq<ThreadPinned<T>> for ThreadPinned<T> {
    fn eq(&self, other: &ThreadPinned<T>) -> bool {
        let value: &T = self.deref();
        let other: &T = other.deref();

        value == other
    }
}

impl<T: std::cmp::PartialEq + std::cmp::Eq> Eq for ThreadPinned<T> {}

impl<T: Default> Default for ThreadPinned<T> {
    fn default() -> Self {
        Self::new(T::default())
    }
}

impl<T> From<T> for ThreadPinned<T> {
    fn from(data: T) -> Self {
        Self::new(data)
    }
}

unsafe impl<T> Sync for ThreadPinned<T> {}

#[cfg(test)]
mod tests {
    use std::ops::Deref;

    use super::ThreadPinned;

    #[test]
    fn it_should_allow_access_from_current_thread() {
        let expected = 0i32;
        let local = ThreadPinned::new(expected);

        let result = local.deref();

        assert_eq!(*result, expected);
    }

    #[test]
    #[should_panic]
    fn it_should_panic_when_accessing_from_different_thread() {
        let handle = std::thread::spawn(|| {
            let state = 0;
            ThreadPinned::new(state)
        });

        if let Ok(result) = handle.join() {
            // This should panic
            let _ = result.deref();
        }
    }

    #[test]
    fn it_should_implement_partial_eq() {
        let expected = 0i32;
        let local = ThreadPinned::new(expected);

        assert!(local == expected);
    }
}
