use super::processor::WindowProcessor;
use super::EventLoopHandle;
use mizer_module::{Module, Runtime};

pub struct WindowModule;

impl Module for WindowModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        runtime.add_processor(Box::new(WindowProcessor));
        runtime.injector_mut().provide(EventLoopHandle::new());

        Ok(())
    }
}
