use crate::ExtractDependencies;
use mizer_injector::{InjectMut, InjectionScope};
use std::marker::PhantomData;

pub struct RefMut<T>(PhantomData<T>);

impl<'a, T: 'static> ExtractDependencies<'a> for RefMut<T> {
    type Type = &'a mut T;

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        injector.inject_mut::<T>()
    }
}
