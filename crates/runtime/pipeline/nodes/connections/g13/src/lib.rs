use mizer_connections::ConnectionStorage;
pub use self::input::*;
pub use self::output::*;
use mizer_g13::G13Ref;
use mizer_node::{Inject, SelectVariant};

mod input;
mod output;

trait G13InjectorExt {
    fn get_devices(&self) -> Vec<SelectVariant>;
}

impl<T: Inject> G13InjectorExt for T {
    fn get_devices(&self) -> Vec<SelectVariant> {
        let device_manager = self.inject::<ConnectionStorage>();

        device_manager
            .query::<G13Ref>()
            .into_iter()
            .map(|(id, _, _)| {
                SelectVariant::Item {
                    label: "G13".to_string().into(),
                    value: id.to_stable().to_string().into(),
                }
            })
            .collect()
    }
}
