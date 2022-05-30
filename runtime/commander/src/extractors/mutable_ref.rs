use crate::ExtractDependencies;
use mizer_injector::Injector;
use std::any::type_name;
use std::marker::PhantomData;

pub struct RefMut<T>(PhantomData<T>);

impl<'a, T: 'static> ExtractDependencies<'a> for RefMut<T> {
    type Type = &'a mut T;

    fn extract(injector: &'a mut Injector) -> Self::Type {
        let type_name = type_name::<T>();

        injector
            .get_mut::<T>()
            .unwrap_or_else(|| panic!("Type {} is not available in injector", type_name))
    }
}
