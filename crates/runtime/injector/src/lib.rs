use std::any::{type_name, Any, TypeId};
use std::collections::HashMap;
use std::fmt::Formatter;

#[derive(Default)]
pub struct Injector {
    // TODO: maybe use RefCell here
    services: HashMap<TypeId, Box<dyn Any>>,
}

pub trait InjectDyn {
    fn try_inject_dyn(&self, type_id: TypeId) -> Option<&Box<dyn Any>>;
}

pub trait InjectDynMut: InjectDyn {
    fn try_inject_dyn_mut(&mut self, type_id: TypeId) -> Option<&mut Box<dyn Any>>;

    fn try_inject_dyn_mut_with_slice(
        &mut self,
        type_id: TypeId,
    ) -> Option<(&mut Box<dyn Any>, InjectorSlice)>;
}

pub trait Inject {
    fn try_inject<T: 'static>(&self) -> Option<&T>;

    fn inject<T: 'static>(&self) -> &T {
        self.try_inject()
            .unwrap_or_else(|| panic!("Unable to inject {}", type_name::<T>()))
    }
}

pub trait InjectMut: Inject {
    fn try_inject_mut<T: 'static>(&mut self) -> Option<&mut T>;

    fn inject_mut<T: 'static>(&mut self) -> &mut T {
        self.try_inject_mut()
            .unwrap_or_else(|| panic!("Unable to inject {}", type_name::<T>()))
    }

    fn try_inject_mut_with_slice<T: 'static>(&mut self) -> Option<(&mut T, InjectorSlice)>;

    fn inject_mut_with_slice<T: 'static>(&mut self) -> (&mut T, InjectorSlice) {
        self.try_inject_mut_with_slice()
            .unwrap_or_else(|| panic!("Unable to inject {}", type_name::<T>()))
    }
}

impl<I: ?Sized + InjectDyn> Inject for I {
    fn try_inject<T: 'static>(&self) -> Option<&T> {
        self.try_inject_dyn(TypeId::of::<T>())
            .and_then(|service| service.downcast_ref())
    }
}

impl<I: ?Sized + InjectDynMut> InjectMut for I {
    fn try_inject_mut<T: 'static>(&mut self) -> Option<&mut T> {
        self.try_inject_dyn_mut(TypeId::of::<T>())
            .and_then(|service| service.downcast_mut())
    }

    fn try_inject_mut_with_slice<T: 'static>(&mut self) -> Option<(&mut T, InjectorSlice)> {
        let (service, injector) = self.try_inject_dyn_mut_with_slice(TypeId::of::<T>())?;
        let service = service.downcast_mut()?;

        Some((service, injector))
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
        self.services.insert(id, service);
    }

    pub fn get<T: 'static>(&self) -> Option<&T> {
        let id = TypeId::of::<T>();
        self.services
            .get(&id)
            .and_then(|service| service.downcast_ref())
    }

    pub fn get_mut<T: 'static>(&mut self) -> Option<&mut T> {
        let id = TypeId::of::<T>();
        self.services
            .get_mut(&id)
            .and_then(|service| service.downcast_mut())
    }

    // TODO: add safe way to access mutable and immutable parts of the injector
    pub fn get_slice_mut<T: 'static>(&mut self) -> Option<(&mut T, &mut Injector)> {
        let injector1: &mut Injector = unsafe { std::mem::transmute_copy(&self) };

        let service = injector1.get_mut::<T>()?;

        Some((service, self))
    }
}

impl InjectDyn for Injector {
    fn try_inject_dyn(&self, type_id: TypeId) -> Option<&Box<dyn Any>> {
        self.services.get(&type_id)
    }
}

impl InjectDynMut for Injector {
    fn try_inject_dyn_mut(&mut self, type_id: TypeId) -> Option<&mut Box<dyn Any>> {
        self.services.get_mut(&type_id)
    }

    fn try_inject_dyn_mut_with_slice(
        &mut self,
        type_id: TypeId,
    ) -> Option<(&mut Box<dyn Any>, InjectorSlice)> {
        let injector1: &mut Injector = unsafe { std::mem::transmute_copy(&self) };

        let service = injector1.try_inject_dyn_mut(type_id)?;

        Some((
            service,
            InjectorSlice {
                injector: self,
                blocked: type_id,
            },
        ))
    }
}

pub struct InjectorSlice<'a> {
    injector: &'a mut dyn InjectDynMut,
    blocked: TypeId,
}

impl<'a> InjectDyn for InjectorSlice<'a> {
    fn try_inject_dyn(&self, type_id: TypeId) -> Option<&Box<dyn Any>> {
        if type_id == self.blocked {
            return None;
        }
        self.injector.try_inject_dyn(type_id)
    }
}

impl<'a> InjectDynMut for InjectorSlice<'a> {
    fn try_inject_dyn_mut(&mut self, type_id: TypeId) -> Option<&mut Box<dyn Any>> {
        if type_id == self.blocked {
            return None;
        }
        self.injector.try_inject_dyn_mut(type_id)
    }

    fn try_inject_dyn_mut_with_slice(
        &mut self,
        type_id: TypeId,
    ) -> Option<(&mut Box<dyn Any>, InjectorSlice)> {
        if type_id == self.blocked {
            return None;
        }
        self.injector.try_inject_dyn_mut_with_slice(type_id)
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    struct TestService {
        value: u64,
    }

    #[test_case(1)]
    #[test_case(5)]
    fn inject_should_return_provided_service(value: u64) {
        let mut injector = Injector::new();
        let service = TestService { value };
        injector.provide(service);

        let service = injector.inject::<TestService>();

        assert_eq!(value, service.value);
    }

    #[test_case(1, 2)]
    #[test_case(5, 0)]
    fn inject_mut_should_return_provided_service_as_mutable(value: u64, next: u64) {
        let mut injector = Injector::new();
        let service = TestService { value };
        injector.provide(service);

        let service = injector.inject_mut::<TestService>();
        service.value = next;

        let service = injector.inject::<TestService>();
        assert_eq!(next, service.value);
    }
}
