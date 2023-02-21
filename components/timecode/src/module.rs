use crate::processor::TimecodeProcessor;
use crate::TimecodeManager;
use mizer_module::{Module, Runtime};

pub struct TimecodeModule(TimecodeManager);

impl TimecodeModule {
    pub fn new() -> (Self, TimecodeManager) {
        let manager = TimecodeManager::new();

        (Self(manager.clone()), manager)
    }
}

impl Module for TimecodeModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        runtime.add_processor(Box::new(TimecodeProcessor::new(self.0.clone())));
        runtime.injector_mut().provide(self.0);

        Ok(())
    }
}
