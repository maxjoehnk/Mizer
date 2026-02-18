use crate::{ExtractDependencies, ExtractDependenciesQuery};
use mizer_injector::{Inject, InjectionScope};
use std::marker::PhantomData;

pub struct Ref<T>(pub(crate) PhantomData<T>);

impl<'a, T: 'static> ExtractDependencies<'a> for Ref<T> {
    type Type = &'a T;

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        &injector.inject()
    }
}

impl<'a, T: 'static> ExtractDependenciesQuery<'a> for Ref<T> {
    type Type = &'a T;

    fn extract(injector: &'a impl Inject) -> Self::Type {
        injector.inject::<T>()
    }
}
