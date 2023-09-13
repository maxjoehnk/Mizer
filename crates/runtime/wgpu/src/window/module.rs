use mizer_module::{Module, Runtime};

use super::processor::WindowProcessor;
use super::EventLoopHandle;

pub struct WindowModule;

impl Module for WindowModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        runtime.add_processor(WindowProcessor);
        runtime.injector_mut().provide(EventLoopHandle::new());

        Ok(())
    }
}
