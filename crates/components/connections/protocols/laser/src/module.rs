use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::{EtherDreamLaser, HeliosLaser, Laser};

pub struct LaserModule;

module_name!(LaserModule);

impl Module for LaserModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {

        let connection_storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let ether_dream_handle = connection_storage_view.remote_access::<EtherDreamLaser>();
        let helios_handle = connection_storage_view.remote_access::<HeliosLaser>();

        if context.settings().connections.ether_dream.enabled {
            std::thread::Builder::new()
                .name("Ether Dream Discovery".to_string())
                .spawn(move|| {
                    if let Err(err) = EtherDreamLaser::find_devices(ether_dream_handle) {
                        tracing::error!("ether dream discovery failed: {:?}", err);
                    }
                })?;
        }

        std::thread::Builder::new()
            .name("Helios Discovery".to_string())
            .spawn(move|| {
                if let Err(err) = HeliosLaser::find_devices(helios_handle) {
                    tracing::error!("helios discovery failed: {:?}", err);
                }
            })?;

        Ok(())
    }
}
