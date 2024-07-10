use std::any::{Any, TypeId};
use std::collections::HashMap;
use std::fmt::Formatter;
use std::sync::Arc;
use mizer_processing::Inject;

pub trait ApiService: Any + Send + Sync + Clone {}

impl<T: Any + Send + Sync + Clone> ApiService for T {}

#[derive(Default, Clone)]
pub struct ApiInjector {
    // TODO: maybe use RefCell here
    services: Arc<HashMap<TypeId, Box<dyn Any + Send + Sync>>>,
}

impl std::fmt::Debug for ApiInjector {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("ApiInjector").finish()
    }
}

impl Inject for ApiInjector {
    fn try_inject<T: 'static>(&self) -> Option<&T> {
        let id = TypeId::of::<T>();
        self.services
            .get(&id)
            .and_then(|service| service.downcast_ref())
    }
}

impl ApiInjector {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn require_service<T: 'static + ApiService>(&self) -> T {
        self.inject::<T>().clone()
    }

    pub fn get<T: 'static + ApiService>(&self) -> Option<&T> {
        self.try_inject()
    }

    pub fn provide<T: 'static + ApiService>(&mut self, value: T) {
        let services = Arc::get_mut(&mut self.services).unwrap();
        let id = TypeId::of::<T>();
        let service = Box::new(value);
        services.insert(id, service);
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    #[derive(Clone)]
    struct TestService {
        value: u64,
    }

    #[test_case(1)]
    #[test_case(5)]
    fn get_should_return_provided_service(value: u64) {
        let mut injector = ApiInjector::new();
        let service = TestService { value };
        injector.provide(service);

        let service = injector.get::<TestService>().unwrap();

        assert_eq!(value, service.value);
    }
}
