use crate::ExtractDependencies;
use mizer_injector::{InjectionScope};

pub struct InjectorRef;

impl<'a> ExtractDependencies<'a> for InjectorRef {
    type Type = InjectionScope<'a>;

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        injector.scope()
    }
}
