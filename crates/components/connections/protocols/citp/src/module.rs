use mizer_connection_contracts::{ConnectionStorageView};
use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;
use crate::connection::CitpConnectionHandle;
use crate::discovery::CitpDiscovery;
use crate::handler::CitpConnectionHandler;

pub struct CitpModule;

module_name!(CitpModule);

impl Module for CitpModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let (connection_sender, connection_receiver) = flume::unbounded();
        if !context.settings().connections.citp.enabled {
            return Ok(());
        }
        let connection_storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let handle_sender = connection_storage_view.remote_access::<CitpConnectionHandle>();
        let fixture_manager = context.try_get::<FixtureManager>().as_deref().cloned();
        let mut connection_handler = CitpConnectionHandler::new(
            connection_receiver,
            handle_sender,
            fixture_manager,
            context.status_handle(),
        )?;
        context.block_in_thread(|| async move {
            if let Err(err) = connection_handler.run().await {
                tracing::error!("Error running connection manager: {:?}", err);
            }
        });

        let discovery = context.block_on(CitpDiscovery::new(connection_sender))?;
        context.block_in_thread(|| async move {
            if let Err(err) = discovery.discover().await {
                tracing::error!("Error discovering peers: {:?}", err);
            }
        });

        Ok(())
    }
}
