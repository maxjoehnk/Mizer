use mizer_module::*;

use super::processor::WindowProcessor;
use super::EventLoopHandle;

pub struct WindowModule;

module_name!(WindowModule);

impl Module for WindowModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.add_processor(WindowProcessor);
        context.provide(EventLoopHandle::new());

        Ok(())
    }
}
