use mizer_node::{Inject, InjectDyn, SelectVariant};
use mizer_protocol_mqtt::MqttConnectionManager;

pub use self::input::*;
pub use self::output::*;

mod input;
mod output;

trait MqttInjectorExt {
    fn get_connections(&self) -> Vec<SelectVariant>;
}

impl<I: ?Sized + InjectDyn> MqttInjectorExt for I {
    fn get_connections(&self) -> Vec<SelectVariant> {
        let connection_manager = self.inject::<MqttConnectionManager>();

        connection_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| SelectVariant::Item {
                value: id.clone().into(),
                label: connection.address.url.to_string().into(),
            })
            .collect()
    }
}
