pub use self::immutable_ref::Ref;
pub use self::mutable_ref::RefMut;
use mizer_injector::Injector;
pub use sub_command::*;

mod immutable_ref;
mod mutable_ref;
mod sub_command;
mod tuples;

pub trait ExtractDependencies<'a> {
    type Type;

    fn extract(injector: &'a mut Injector) -> Self::Type;
}
