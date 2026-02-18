use super::ExtractDependencies;
use crate::ExtractDependenciesQuery;
use mizer_injector::{Inject, InjectionScope};

// TODO: implement as macro
impl<'a, T1: 'static + ExtractDependencies<'a>, T2: 'static + ExtractDependencies<'a>>
    ExtractDependencies<'a> for (T1, T2)
{
    type Type = (T1::Type, T2::Type);

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);

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

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);

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

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);
        let t4 = T4::extract(injector);

        (t1, t2, t3, t4)
    }
}

impl<
        'a,
        T1: 'static + ExtractDependencies<'a>,
        T2: 'static + ExtractDependencies<'a>,
        T3: 'static + ExtractDependencies<'a>,
        T4: 'static + ExtractDependencies<'a>,
        T5: 'static + ExtractDependencies<'a>,
    > ExtractDependencies<'a> for (T1, T2, T3, T4, T5)
{
    type Type = (T1::Type, T2::Type, T3::Type, T4::Type, T5::Type);

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);
        let t4 = T4::extract(injector);
        let t5 = T5::extract(injector);

        (t1, t2, t3, t4, t5)
    }
}

impl<
        'a,
        T1: 'static + ExtractDependencies<'a>,
        T2: 'static + ExtractDependencies<'a>,
        T3: 'static + ExtractDependencies<'a>,
        T4: 'static + ExtractDependencies<'a>,
        T5: 'static + ExtractDependencies<'a>,
        T6: 'static + ExtractDependencies<'a>,
    > ExtractDependencies<'a> for (T1, T2, T3, T4, T5, T6)
{
    type Type = (T1::Type, T2::Type, T3::Type, T4::Type, T5::Type, T6::Type);

    fn extract(injector: &'a InjectionScope) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);
        let t4 = T4::extract(injector);
        let t5 = T5::extract(injector);
        let t6 = T6::extract(injector);

        (t1, t2, t3, t4, t5, t6)
    }
}

impl<'a> ExtractDependenciesQuery<'a> for () {
    type Type = ();

    fn extract(_: &'a impl Inject) -> Self::Type {
        ()
    }
}

impl<
    'a,
    T1: 'static + ExtractDependenciesQuery<'a>,
    T2: 'static + ExtractDependenciesQuery<'a>,
> ExtractDependenciesQuery<'a> for (T1, T2)
{
    type Type = (T1::Type, T2::Type);

    fn extract(injector: &'a impl Inject) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);

        (t1, t2)
    }
}

impl<
    'a,
    T1: 'static + ExtractDependenciesQuery<'a>,
    T2: 'static + ExtractDependenciesQuery<'a>,
    T3: 'static + ExtractDependenciesQuery<'a>,
> ExtractDependenciesQuery<'a> for (T1, T2, T3)
{
    type Type = (T1::Type, T2::Type, T3::Type);

    fn extract(injector: &'a impl Inject) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);

        (t1, t2, t3)
    }
}

impl<
    'a,
    T1: 'static + ExtractDependenciesQuery<'a>,
    T2: 'static + ExtractDependenciesQuery<'a>,
    T3: 'static + ExtractDependenciesQuery<'a>,
    T4: 'static + ExtractDependenciesQuery<'a>,
> ExtractDependenciesQuery<'a> for (T1, T2, T3, T4)
{
    type Type = (T1::Type, T2::Type, T3::Type, T4::Type);

    fn extract(injector: &'a impl Inject) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);
        let t4 = T4::extract(injector);

        (t1, t2, t3, t4)
    }
}

impl<
    'a,
    T1: 'static + ExtractDependenciesQuery<'a>,
    T2: 'static + ExtractDependenciesQuery<'a>,
    T3: 'static + ExtractDependenciesQuery<'a>,
    T4: 'static + ExtractDependenciesQuery<'a>,
    T5: 'static + ExtractDependenciesQuery<'a>,
> ExtractDependenciesQuery<'a> for (T1, T2, T3, T4, T5)
{
    type Type = (T1::Type, T2::Type, T3::Type, T4::Type, T5::Type);

    fn extract(injector: &'a impl Inject) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);
        let t4 = T4::extract(injector);
        let t5 = T5::extract(injector);

        (t1, t2, t3, t4, t5)
    }
}

impl<
        'a,
        T1: 'static + ExtractDependenciesQuery<'a>,
        T2: 'static + ExtractDependenciesQuery<'a>,
        T3: 'static + ExtractDependenciesQuery<'a>,
        T4: 'static + ExtractDependenciesQuery<'a>,
        T5: 'static + ExtractDependenciesQuery<'a>,
        T6: 'static + ExtractDependenciesQuery<'a>,
    > ExtractDependenciesQuery<'a> for (T1, T2, T3, T4, T5, T6)
{
    type Type = (T1::Type, T2::Type, T3::Type, T4::Type, T5::Type, T6::Type);

    fn extract(injector: &'a impl Inject) -> Self::Type {
        let t1 = T1::extract(injector);
        let t2 = T2::extract(injector);
        let t3 = T3::extract(injector);
        let t4 = T4::extract(injector);
        let t5 = T5::extract(injector);
        let t6 = T6::extract(injector);

        (t1, t2, t3, t4, t5, t6)
    }
}
