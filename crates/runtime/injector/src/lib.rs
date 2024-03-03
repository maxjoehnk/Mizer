use std::any::{Any, type_name, TypeId};
use std::collections::HashMap;
use std::fmt::Formatter;

#[derive(Default)]
pub struct Injector {
    // TODO: maybe use RefCell here
    services: HashMap<TypeId, Box<dyn Any>>,
}

pub trait Inject {
    fn try_inject<T: 'static>(&self) -> Option<&T>;
    
    fn inject<T: 'static>(&self) -> &T {
        self.try_inject().unwrap_or_else(|| panic!("Unable to inject {}", type_name::<T>()))
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
}

impl Inject for Injector {
    fn try_inject<T: 'static>(&self) -> Option<&T> {
        let id = TypeId::of::<T>();
        self.services
            .get(&id)
            .and_then(|service| service.downcast_ref())
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
    fn get_should_return_provided_service(value: u64) {
        let mut injector = Injector::new();
        let service = TestService { value };
        injector.provide(service);

        let service = injector.get::<TestService>().unwrap();

        assert_eq!(value, service.value);
    }

    #[test_case(1, 2)]
    #[test_case(5, 0)]
    fn get_mut_should_return_provided_service_as_mutable(value: u64, next: u64) {
        let mut injector = Injector::new();
        let service = TestService { value };
        injector.provide(service);

        let service = injector.get_mut::<TestService>().unwrap();
        service.value = next;

        let service = injector.get::<TestService>().unwrap();
        assert_eq!(next, service.value);
    }
}
