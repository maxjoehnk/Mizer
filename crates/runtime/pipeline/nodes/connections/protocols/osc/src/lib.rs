pub use argument_type::OscArgumentType;
pub use input::*;
use mizer_connections::{ConnectionId, ConnectionStorage, Has, Name, OscConnection};
use mizer_node::{Inject, SelectVariant};
pub use output::*;

mod argument_type;
mod input;
mod output;

trait OscInjectorExt {
    fn get_connections(&self) -> Vec<SelectVariant>;
}

impl<T: Inject> OscInjectorExt for T {
    fn get_connections(&self) -> Vec<SelectVariant> {
        let connection_manager = self.inject::<ConnectionStorage>();

        connection_manager
            .fetch::<(ConnectionId, Name, Has<OscConnection>)>()
            .into_iter()
            .map(|(id, name)| SelectVariant::Item {
                value: id.to_stable().to_string().into(),
                label: name.clone().into(),
            })
            .collect()
    }
}
