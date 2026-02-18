use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::{discover_devices, TraktorX1Ref};
// use crate::WebcamRef;

pub struct TraktorX1Module;

module_name!(TraktorX1Module);

impl Module for TraktorX1Module {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let connection_storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let connection_storage_handle = connection_storage_view.remote_access::<TraktorX1Ref>();

        discover_devices(connection_storage_handle)?;

        Ok(())
    }
}
