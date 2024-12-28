pub use argument_type::OscArgumentType;
pub use input::*;
use mizer_node::{Inject, InjectDyn, SelectVariant};
use mizer_protocol_osc::OscConnectionManager;
pub use output::*;

mod argument_type;
mod input;
mod output;

trait OscInjectorExt {
    fn get_connections(&self) -> Vec<SelectVariant>;
}

impl<I: ?Sized + InjectDyn> OscInjectorExt for I {
    fn get_connections(&self) -> Vec<SelectVariant> {
        let connection_manager = self.inject::<OscConnectionManager>();

        connection_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| SelectVariant::Item {
                value: id.clone().into(),
                label: connection.address.output_host.to_string().into(),
            })
            .collect()
    }
}
