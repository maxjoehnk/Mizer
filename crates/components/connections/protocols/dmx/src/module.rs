use mizer_module::*;
use crate::dmx_monitor::create_monitor;

use crate::processor::DmxProcessor;
use crate::DmxConnectionManager;

pub struct DmxModule;

module_name!(DmxModule);

impl Module for DmxModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let (internal_monitor, public_monitor) = create_monitor();
        let dmx_manager = DmxConnectionManager::new(internal_monitor);
        context.provide(dmx_manager);
        context.provide_api(public_monitor);
        context.add_processor(DmxProcessor);

        Ok(())
    }
}
