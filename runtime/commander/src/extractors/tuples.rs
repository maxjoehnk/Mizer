use super::ExtractDependencies;
use mizer_injector::Injector;
use std::any::TypeId;

// TODO: implement as macro
impl<'a, T1: 'static + ExtractDependencies<'a>, T2: 'static + ExtractDependencies<'a>>
    ExtractDependencies<'a> for (T1, T2)
{
    type Type = (T1::Type, T2::Type);

    fn extract(injector: &'a mut Injector) -> Self::Type {
        assert_ne!(TypeId::of::<T1>(), TypeId::of::<T2>());

        let injector1 = unsafe { std::mem::transmute_copy(&injector) };
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector1);

        (t1, t2)
    }
}

impl<
        'a,
        T1: 'static + ExtractDependencies<'a>,
        T2: 'static + ExtractDependencies<'a>,
        T3: 'static + ExtractDependencies<'a>,
    > ExtractDependencies<'a> for (T1, T2, T3)
{
    type Type = (T1::Type, T2::Type, T3::Type);

    fn extract(injector: &'a mut Injector) -> Self::Type {
        assert_ne!(TypeId::of::<T1>(), TypeId::of::<T2>());
        assert_ne!(TypeId::of::<T1>(), TypeId::of::<T3>());

        let injector1 = unsafe { std::mem::transmute_copy(&injector) };
        let injector2 = unsafe { std::mem::transmute_copy(&injector) };
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector1);
        let t3 = T3::extract(injector2);

        (t1, t2, t3)
    }
}

impl<
        'a,
        T1: 'static + ExtractDependencies<'a>,
        T2: 'static + ExtractDependencies<'a>,
        T3: 'static + ExtractDependencies<'a>,
        T4: 'static + ExtractDependencies<'a>,
    > ExtractDependencies<'a> for (T1, T2, T3, T4)
{
    type Type = (T1::Type, T2::Type, T3::Type, T4::Type);

    fn extract(injector: &'a mut Injector) -> Self::Type {
        assert_ne!(TypeId::of::<T1>(), TypeId::of::<T2>());
        assert_ne!(TypeId::of::<T1>(), TypeId::of::<T3>());
        assert_ne!(TypeId::of::<T1>(), TypeId::of::<T4>());

        let injector1 = unsafe { std::mem::transmute_copy(&injector) };
        let injector2 = unsafe { std::mem::transmute_copy(&injector) };
        let injector3 = unsafe { std::mem::transmute_copy(&injector) };
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector1);
        let t3 = T3::extract(injector2);
        let t4 = T4::extract(injector3);

        (t1, t2, t3, t4)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::{ExtractDependencies, Ref};

    #[test]
    #[should_panic]
    fn should_not_allow_multiple_borrows_of_same_type_2() {
        struct Dep;
        type Extractor = (Ref<Dep>, Ref<Dep>);
        let mut injector = Injector::new();

        Extractor::extract(&mut injector);
    }

    #[test]
    #[should_panic]
    fn should_not_allow_multiple_borrows_of_same_type_3() {
        struct Dep;
        type Extractor = (Ref<Dep>, Ref<Dep>, Ref<Dep>);
        let mut injector = Injector::new();

        Extractor::extract(&mut injector);
    }
}
