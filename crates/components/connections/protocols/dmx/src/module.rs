use mizer_module::*;

use crate::processor::DmxProcessor;
use crate::DmxConnectionManager;

pub struct DmxModule;

module_name!(DmxModule);

impl Module for DmxModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let dmx_manager = DmxConnectionManager::new();
        context.provide(dmx_manager);
        context.add_processor(DmxProcessor);

        Ok(())
    }
}
