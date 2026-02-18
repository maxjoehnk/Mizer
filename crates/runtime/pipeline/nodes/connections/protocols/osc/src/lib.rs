pub use argument_type::OscArgumentType;
pub use input::*;
use mizer_node::{Inject, SelectVariant};
use mizer_protocol_osc::OscConnectionManager;
pub use output::*;

mod argument_type;
mod input;
mod output;

trait OscInjectorExt {
    fn get_connections(&self) -> Vec<SelectVariant>;
}

impl<T: Inject> OscInjectorExt for T {
    fn get_connections(&self) -> Vec<SelectVariant> {
        let connection_manager = self.inject::<OscConnectionManager>();

        connection_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| SelectVariant::Item {
                value: id.clone().into(),
                label: connection.name.clone().into(),
            })
            .collect()
    }
}
