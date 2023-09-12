use mizer_module::*;

use crate::processor::DmxProcessor;
use crate::DmxConnectionManager;

pub struct DmxModule;

impl Module for DmxModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let dmx_manager = DmxConnectionManager::new();
        runtime.injector_mut().provide(dmx_manager);
        runtime.add_processor(DmxProcessor);

        Ok(())
    }
}
