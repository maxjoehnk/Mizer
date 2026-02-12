use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::discovery::discover_devices;
use crate::WebcamRef;

pub struct WebcamModule;

module_name!(WebcamModule);

impl Module for WebcamModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let connection_storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let connection_storage_handle = connection_storage_view.remote_access::<WebcamRef>();

        discover_devices(connection_storage_handle);

        Ok(())
    }
}
