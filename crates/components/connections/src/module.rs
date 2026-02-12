use mizer_connection_contracts::{ConnectionStorageView, ConnectionStorage};
use mizer_module::*;
use crate::processor::RemoteConnectionStorageProcessor;

pub struct ConnectionsModule;

module_name!(ConnectionsModule);

impl Module for ConnectionsModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let connections_storage = ConnectionStorage::new();
        let view = ConnectionStorageView::default();
        context.provide(connections_storage);
        context.provide(view.clone());
        context.provide_api(view);
        context.add_processor(RemoteConnectionStorageProcessor);

        Ok(())
    }
}
