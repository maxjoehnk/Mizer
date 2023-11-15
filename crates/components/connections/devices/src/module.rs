use mizer_module::*;

use crate::DeviceManager;

pub struct DeviceModule;

module_name!(DeviceModule);

impl Module for DeviceModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let device_manager = DeviceManager::new();
        let discovery_manager = device_manager.clone();
        context.block_in_thread(move || discovery_manager.start_discovery());
        context.provide_api(device_manager.clone());
        context.provide(device_manager);

        Ok(())
    }
}
