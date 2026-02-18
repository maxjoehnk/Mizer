use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::{CDJView, DJMView};
use crate::discovery::ProDJLinkDiscoveryService;

pub struct ProDjLinkModule;

module_name!(ProDjLinkModule);

impl Module for ProDjLinkModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let cdj_handle = storage_view.remote_access::<CDJView>();
        let djm_handle = storage_view.remote_access::<DJMView>();

        if !context.settings().connections.pro_dj_link.enabled {
            return Ok(());
        }

        context.spawn(async {
            match ProDJLinkDiscoveryService::new(cdj_handle, djm_handle).await {
                Ok(service) => {
                    service.run().await;
                }
                Err(err) => tracing::error!("Failed to start pro dj link discovery service: {err:?}"),
            }
        });

        Ok(())
    }
}
