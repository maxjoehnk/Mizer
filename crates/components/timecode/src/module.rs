use mizer_module::*;

use crate::processor::TimecodeProcessor;
use crate::TimecodeManager;

pub struct TimecodeModule;

module_name!(TimecodeModule);

impl Module for TimecodeModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let manager = TimecodeManager::new();
        context.provide_api(manager.clone());
        context.add_project_handler(manager.clone());
        context.add_processor(TimecodeProcessor::new(manager.clone()));
        context.provide(manager);

        Ok(())
    }
}
