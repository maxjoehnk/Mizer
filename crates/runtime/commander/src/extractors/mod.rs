pub use self::immutable_ref::Ref;
pub use self::mutable_ref::RefMut;
pub use injector_ref::*;
use mizer_injector::{Inject, InjectionScope};
pub use sub_command::*;

mod immutable_ref;
mod injector_ref;
mod mutable_ref;
mod sub_command;
mod tuples;

pub trait ExtractDependencies<'a> {
    type Type;

    fn extract(injector: &'a InjectionScope) -> Self::Type;
}

pub trait ExtractDependenciesQuery<'a> {
    type Type;

    fn extract(injector: &'a impl Inject) -> Self::Type;
}
