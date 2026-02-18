use std::any::{type_name, Any, TypeId};
use std::cell::UnsafeCell;
use std::collections::HashMap;
use std::fmt::{Debug, Formatter};
use std::ops::{Deref, DerefMut};
use std::sync::atomic::AtomicU8;
use std::sync::Arc;

const BORROWED_MUT: u8 = u8::MAX;

#[derive(Default)]
pub struct Injector {
    services: HashMap<TypeId, UnsafeCell<Box<dyn Any>>>,
    borrows: Arc<HashMap<TypeId, AtomicU8>>,
}

pub struct InjectionScope<'a> {
    injector: &'a Injector,
    borrows: Arc<HashMap<TypeId, AtomicU8>>,
    scope_borrows: HashMap<TypeId, AtomicU8>,
}

pub struct ReadOnlyInjectionScope<'a>(InjectionScope<'a>);

impl Inject for ReadOnlyInjectionScope<'_> {
    fn try_inject<T: 'static>(&self) -> Option<&T> {
        self.0.try_inject()
    }
}

impl Debug for InjectionScope<'_> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("InjectionScope")
            .field("borrowed_types", &self.scope_borrows)
            .finish()
    }
}

impl<'a> InjectionScope<'a> {
    fn new<'b: 'a>(injector: &'b Injector, borrows: &Arc<HashMap<TypeId, AtomicU8>>) -> Self {
        Self {
            injector,
            borrows: Arc::clone(borrows),
            scope_borrows: borrows
                .keys()
                .map(|id| (*id, AtomicU8::new(0)))
                .collect(),
        }
    }

    pub fn scope(&self) -> InjectionScope<'_> {
        Self::new(self.injector, &self.borrows)
    }

    pub fn read_only_scope(&self) -> ReadOnlyInjectionScope<'_> {
        ReadOnlyInjectionScope(self.scope())
    }
}

pub trait Inject {
    fn try_inject<T: 'static>(&self) -> Option<&T>;

    fn inject<T: 'static>(&self) -> &T {
        self.try_inject()
            .unwrap_or_else(|| panic!("Unable to inject {}", type_name::<T>()))
    }
}

#[allow(clippy::mut_from_ref)]
pub trait InjectMut: Inject {
    fn try_inject_mut<T: 'static>(&self) -> Option<&mut T>;
    fn inject_mut<T: 'static>(&self) -> &mut T {
        self.try_inject_mut()
            .unwrap_or_else(|| panic!("Unable to inject {}", type_name::<T>()))
    }
}

impl std::fmt::Debug for Injector {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("Injector").finish()
    }
}

impl Injector {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn provide<T: 'static>(&mut self, service: T) {
        let id = TypeId::of::<T>();
        let service = Box::new(service);
        self.services.insert(id, UnsafeCell::new(service));
        Arc::get_mut(&mut self.borrows)
            .unwrap()
            .insert(id, AtomicU8::new(0));
    }

    pub fn try_borrow<T: 'static>(&self) -> Option<Borrowed<'_, T>> {
        let type_id = TypeId::of::<T>();
        let borrows = Arc::clone(&self.borrows);
        let borrow_state = borrows.get(&type_id)?;
        if borrow_state.fetch_add(1, std::sync::atomic::Ordering::Relaxed) == BORROWED_MUT {
            panic!("Service {} is borrowed mutably", type_name::<T>());
        }

        Some(Borrowed { service: unsafe { self.get::<T>() }, borrows })
    }

    pub fn borrow<T: 'static>(&self) -> Borrowed<'_, T> {
        self.try_borrow::<T>().unwrap()
    }

    pub fn try_borrow_mut<T: 'static>(&self) -> Option<BorrowedMut<'_, T>> {
        let type_id = TypeId::of::<T>();
        let borrows = Arc::clone(&self.borrows);
        let borrow_state = borrows.get(&type_id)?;
        if borrow_state.swap(BORROWED_MUT, std::sync::atomic::Ordering::Relaxed) > 0 {
            panic!("Service {} is borrowed already", type_name::<T>());
        }

        Some(BorrowedMut { service: unsafe { self.get_mut::<T>() }, borrows })
    }

    pub fn borrow_mut<T: 'static>(&self) -> BorrowedMut<'_, T> {
        self.try_borrow_mut::<T>().unwrap()
    }

    pub fn scope(&self) -> InjectionScope<'_> {
        InjectionScope::new(self, &self.borrows)
    }

    pub fn read_only_scope(&self) -> ReadOnlyInjectionScope<'_> {
        ReadOnlyInjectionScope(self.scope())
    }

    unsafe fn get<T: 'static>(&self) -> Option<&T> {
        let id = TypeId::of::<T>();
        if self
            .borrows
            .get(&id)?
            .load(std::sync::atomic::Ordering::Relaxed)
            == BORROWED_MUT
        {
            panic!("Service {} is borrowed mutably", type_name::<T>());
        }
        let service = self.services.get(&id)?;
        let service = unsafe { service.get().as_ref() }.unwrap();

        service.downcast_ref::<T>()
    }

    #[allow(clippy::mut_from_ref)]
    unsafe fn get_mut<T: 'static>(&self) -> Option<&mut T> {
        let id = TypeId::of::<T>();
        let service = self.services.get(&id)?;
        let service = unsafe { service.get().as_mut() }.unwrap();

        service.downcast_mut::<T>()
    }
}

impl Inject for InjectionScope<'_> {
    fn try_inject<T: 'static>(&self) -> Option<&T> {
        let id = TypeId::of::<T>();
        let borrow_state = self.borrows.get(&id)?;
        if borrow_state.fetch_add(1, std::sync::atomic::Ordering::Relaxed) == BORROWED_MUT {
            panic!("Service {} is borrowed mutably", type_name::<T>());
        }
        self.scope_borrows
            .get(&id)
            .unwrap()
            .fetch_add(1, std::sync::atomic::Ordering::Relaxed);

        unsafe { self.injector.get::<T>() }
    }
}

impl InjectMut for InjectionScope<'_> {
    fn try_inject_mut<T: 'static>(&self) -> Option<&mut T> {
        let id = TypeId::of::<T>();
        let borrow_state = self.borrows.get(&id)?;
        if borrow_state.swap(BORROWED_MUT, std::sync::atomic::Ordering::Relaxed) > 0 {
            panic!("Service {} is borrowed already", type_name::<T>());
        }
        self.scope_borrows
            .get(&id)
            .unwrap()
            .store(BORROWED_MUT, std::sync::atomic::Ordering::Relaxed);

        unsafe { self.injector.get_mut::<T>() }
    }
}

impl Drop for InjectionScope<'_> {
    fn drop(&mut self) {
        for (id, state) in self.scope_borrows.iter() {
            let state = state.load(std::sync::atomic::Ordering::Relaxed);
            let borrow_state = self.borrows.get(id).unwrap();
            if state == BORROWED_MUT {
                borrow_state.store(0, std::sync::atomic::Ordering::Relaxed);
            } else {
                borrow_state.fetch_sub(state, std::sync::atomic::Ordering::Relaxed);
            }
        }
    }
}

pub struct Borrowed<'a, T: 'static> {
    service: Option<&'a T>,
    borrows: Arc<HashMap<TypeId, AtomicU8>>,
}

impl<'a, T> Deref for Borrowed<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        self.service.as_ref().expect("Borrowed service dereferenced after dropped")
    }
}

impl<'a, T> Drop for Borrowed<'a, T> {
    fn drop(&mut self) {
        self.service = None;
        let id = TypeId::of::<T>();
        self.borrows.get(&id).unwrap().fetch_sub(1, std::sync::atomic::Ordering::Relaxed);
    }
}

pub struct BorrowedMut<'a, T: 'static> {
    service: Option<&'a mut T>,
    borrows: Arc<HashMap<TypeId, AtomicU8>>,
}

impl<'a, T> Deref for BorrowedMut<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        self.service.as_ref().expect("Borrowed service dereferenced after dropped")
    }
}

impl<'a, T> DerefMut for BorrowedMut<'a, T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.service.as_mut().expect("Borrowed service dereferenced after dropped")
    }
}

impl<'a, T> Drop for BorrowedMut<'a, T> {
    fn drop(&mut self) {
        self.service = None;
        let id = TypeId::of::<T>();
        self.borrows.get(&id).unwrap().store(0, std::sync::atomic::Ordering::Relaxed);
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    #[derive(Default)]
    struct TestService {
        value: u64,
    }

    #[test_case(1)]
    #[test_case(5)]
    fn get_should_return_provided_service(value: u64) {
        let mut injector = Injector::new();
        let service = TestService { value };
        injector.provide(service);

        let service = injector.borrow::<TestService>();

        assert_eq!(value, service.value);
    }

    #[test_case(1, 2)]
    #[test_case(5, 0)]
    fn scope_should_allow_mutable_borrow(value: u64, next: u64) {
        let mut injector = Injector::new();
        let service = TestService { value };
        injector.provide(service);

        {
            let scope = injector.scope();
            let service = scope.inject_mut::<TestService>();
            service.value = next;
        }

        let service = injector.borrow::<TestService>();
        assert_eq!(next, service.value);
    }

    #[test]
    #[should_panic(expected = "Service mizer_injector::tests::TestService is borrowed already")]
    fn inject_mut_should_panic_on_multiple_mutable_borrows_in_different_scopes() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);
        let scope1 = injector.scope();
        let scope2 = injector.scope();

        let _mutable_borrow = scope1.inject_mut::<TestService>();
        let _mutable_borrow = scope2.inject_mut::<TestService>();
    }

    #[test]
    #[should_panic(expected = "Service mizer_injector::tests::TestService is borrowed already")]
    fn inject_mut_should_panic_on_multiple_mutable_borrows_in_same_scope() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);
        let scope = injector.scope();

        let _mutable_borrow = scope.inject_mut::<TestService>();
        let _mutable_borrow = scope.inject_mut::<TestService>();
    }

    #[test]
    #[should_panic(expected = "Service mizer_injector::tests::TestService is borrowed already")]
    fn inject_mut_should_panic_when_service_is_borrowed() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);
        let scope = injector.scope();

        let _borrow = scope.inject::<TestService>();
        let _mutable_borrow = scope.inject_mut::<TestService>();
    }

    #[test]
    #[should_panic(expected = "Service mizer_injector::tests::TestService is borrowed mutably")]
    fn inject_should_panic_when_service_is_mutable_borrowed() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);
        let scope = injector.scope();

        let _mutable_borrow = scope.inject_mut::<TestService>();
        let _borrow = scope.inject::<TestService>();
    }

    #[test]
    fn borrowing_mutable_after_each_other_should_not_panic() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);

        {
            let scope = injector.scope();
            let _mutable_borrow = scope.inject_mut::<TestService>();
        }

        {
            let scope = injector.scope();
            let _mutable_borrow = scope.inject_mut::<TestService>();
        }
    }

    #[test]
    #[should_panic(expected = "Service mizer_injector::tests::TestService is borrowed mutably")]
    fn borrowing_from_injector_while_mutable_borrow_is_active_in_scope_should_panic() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);
        let scope = injector.scope();
        let _mutable_borrow = scope.inject_mut::<TestService>();

        let _borrow = injector.borrow::<TestService>();
    }

    #[test]
    #[should_panic(expected = "Service mizer_injector::tests::TestService is borrowed already")]
    fn mutable_borrow_from_scope_should_panic_when_injector_borrow_is_alive() {
        let mut injector = Injector::new();
        let service = TestService::default();
        injector.provide(service);
        let scope = injector.scope();
        let _borrowed = injector.borrow::<TestService>();

        let _mutable_borrow = scope.inject_mut::<TestService>();
    }
}
