use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;

use crate::discovery::CitpDiscovery;
use crate::handler::CitpConnectionHandler;
use crate::manager::CitpConnectionManager;
use crate::processor::UpdatedCitpConnectionProcessor;

pub struct CitpModule;

module_name!(CitpModule);

impl Module for CitpModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let (handle_sender, handle_receiver) = flume::unbounded();
        let (connection_sender, connection_receiver) = flume::unbounded();
        let connection_manager = CitpConnectionManager::new(handle_receiver)?;
        context.provide(connection_manager);
        let fixture_manager = context.try_get::<FixtureManager>().cloned();
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
        context.add_processor(UpdatedCitpConnectionProcessor);

        Ok(())
    }
}
