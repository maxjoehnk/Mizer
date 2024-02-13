use std::thread;

use mizer_module::*;

use super::processor::WindowProcessor;
use super::EventLoopHandle;

pub struct WindowModule;

module_name!(WindowModule);

impl Module for WindowModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        if cfg!(not(target_os = "linux")) && thread::current().name() != Some("main") {
            return Err(anyhow::anyhow!(
                "Windowing functionality can only be used on linux or when running headless."
            ));
        }
        context.add_processor(WindowProcessor);
        context.provide(EventLoopHandle::new()?);

        Ok(())
    }
}
