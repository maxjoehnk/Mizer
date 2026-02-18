use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::discovery::start_discovery;
use crate::NdiSourceRef;

pub struct NdiModule;

module_name!(NdiModule);

impl Module for NdiModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let handle = storage_view.remote_access::<NdiSourceRef>();

        start_discovery(handle)?;
        Ok(())
    }
}
