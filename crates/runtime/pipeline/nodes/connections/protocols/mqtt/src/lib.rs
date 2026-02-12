use mizer_connections::ConnectionStorage;
use mizer_node::{Inject, Injector, SelectVariant};
use mizer_protocol_mqtt::MqttConnection;

pub use self::input::*;
pub use self::output::*;

mod input;
mod output;

trait MqttInjectorExt {
    fn get_connections(&self) -> Vec<SelectVariant>;
}

impl<T: Inject> MqttInjectorExt for T {
    fn get_connections(&self) -> Vec<SelectVariant> {
        let connection_manager = self.inject::<ConnectionStorage>();

        connection_manager
            .query::<MqttConnection>()
            .into_iter()
            .map(|(id, name, connection)| SelectVariant::Item {
                value: id.to_stable().to_string().into(),
                label: name.cloned().unwrap_or_else(|| connection.address.url.to_string().into()),
            })
            .collect()
    }
}
