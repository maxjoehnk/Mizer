use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::{G13DiscoveryService, G13Ref};

pub struct G13Module;

module_name!(G13Module);

impl Module for G13Module {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let sender = storage_view.remote_access::<G13Ref>();

        let service = G13DiscoveryService::new(sender)?;
        std::thread::Builder::new()
            .name("G13 Discovery".to_string())
            .spawn(move || service.run())?;

        Ok(())
    }
}
