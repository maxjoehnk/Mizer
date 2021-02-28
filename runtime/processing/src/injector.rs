use std::any::{TypeId, Any};
use std::collections::HashMap;

#[derive(Default)]
pub struct Injector {
    services: HashMap<TypeId, Box<dyn Any>>,
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
        self.services.get(&id)
            .and_then(|service| service.downcast_ref())
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    struct TestService {
        value: u64
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
}
