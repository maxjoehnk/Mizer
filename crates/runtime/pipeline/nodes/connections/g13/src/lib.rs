pub use self::input::*;
pub use self::output::*;
use mizer_devices::{DeviceManager, DeviceRef};
use mizer_node::{Inject, SelectVariant};

mod input;
mod output;

trait G13InjectorExt {
    fn get_devices(&self) -> Vec<SelectVariant>;
}

impl<T: Inject> G13InjectorExt for T {
    fn get_devices(&self) -> Vec<SelectVariant> {
        let device_manager = self.inject::<DeviceManager>();

        device_manager
            .current_devices()
            .into_iter()
            .flat_map(|device| {
                if let DeviceRef::G13(g13) = device {
                    Some(SelectVariant::from(g13.id))
                } else {
                    None
                }
            })
            .collect()
    }
}
