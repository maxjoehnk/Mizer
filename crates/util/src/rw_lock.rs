// We have to use std::sync::RwLock here instead of parking_lot as parking_lot is not safe across dynamic library boundaries.
// This is because parking_lot uses global state when lock contention occurs which isn't shared to the ffi dylib.
type InternalRwLock<T> = std::sync::RwLock<T>;
type InternalRwLockReadGuard<'a, T> = std::sync::RwLockReadGuard<'a, T>;
type InternalRwLockWriteGuard<'a, T> = std::sync::RwLockWriteGuard<'a, T>;

#[derive(Debug)]
pub struct RwLock<T> {
    inner: InternalRwLock<T>,
    #[cfg(debug_assertions)]
    id: uuid::Uuid,
}

impl<T: Default> Default for RwLock<T> {
    fn default() -> Self {
        Self::new(Default::default())
    }
}

impl<T> RwLock<T> {
    pub fn new(value: T) -> Self {
        Self {
            inner: InternalRwLock::new(value),
            #[cfg(debug_assertions)]
            id: uuid::Uuid::new_v4(),
        }
    }

    pub fn read(&self) -> RwLockReadGuard<'_, T> {
        #[cfg(debug_assertions)]
        tracing::trace!("Trying to acquire read lock for id: {}", self.id);
        let guard = self.inner.read().unwrap();
        #[cfg(debug_assertions)]
        tracing::trace!("Acquired read lock for id: {}", self.id);

        RwLockReadGuard {
            inner: guard,
            #[cfg(debug_assertions)]
            id: self.id,
        }
    }

    pub fn write(&self) -> RwLockWriteGuard<'_, T> {
        #[cfg(debug_assertions)]
        tracing::trace!("Trying to acquire write lock for id: {}", self.id);
        let guard = self.inner.write().unwrap();
        #[cfg(debug_assertions)]
        tracing::trace!("Acquired write lock for id: {}", self.id);

        RwLockWriteGuard {
            inner: guard,
            #[cfg(debug_assertions)]
            id: self.id,
        }
    }
}

pub struct RwLockReadGuard<'a, T> {
    inner: InternalRwLockReadGuard<'a, T>,
    #[cfg(debug_assertions)]
    id: uuid::Uuid,
}

impl<'a, T> Drop for RwLockReadGuard<'a, T> {
    fn drop(&mut self) {
        #[cfg(debug_assertions)]
        tracing::trace!("Dropping read lock for id: {}", self.id);
    }
}

impl<'a, T> std::ops::Deref for RwLockReadGuard<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &*self.inner
    }
}

pub struct RwLockWriteGuard<'a, T> {
    inner: InternalRwLockWriteGuard<'a, T>,
    #[cfg(debug_assertions)]
    id: uuid::Uuid,
}

impl<'a, T> Drop for RwLockWriteGuard<'a, T> {
    fn drop(&mut self) {
        #[cfg(debug_assertions)]
        tracing::trace!("Dropping write lock for id: {}", self.id);
    }
}

impl<'a, T> std::ops::Deref for RwLockWriteGuard<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &*self.inner
    }
}

impl<'a, T> std::ops::DerefMut for RwLockWriteGuard<'a, T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut *self.inner
    }
}
