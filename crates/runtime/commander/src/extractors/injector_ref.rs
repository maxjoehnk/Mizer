use mizer_injector::Injector;
use crate::ExtractDependencies;

// TODO: Access to the injector is highly dangerous as it allows for mutable and immutable access to the same objects
pub struct InjectorRef;

impl<'a> ExtractDependencies<'a> for InjectorRef {
    type Type = &'a Injector;

    fn extract(injector: &'a mut Injector) -> Self::Type {
        injector
    }
}
