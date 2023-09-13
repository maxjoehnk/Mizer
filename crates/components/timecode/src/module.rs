use mizer_module::{Module, Runtime};

use crate::processor::TimecodeProcessor;
use crate::TimecodeManager;

pub struct TimecodeModule(TimecodeManager);

impl TimecodeModule {
    pub fn new() -> (Self, TimecodeManager) {
        let manager = TimecodeManager::new();

        (Self(manager.clone()), manager)
    }
}

impl Module for TimecodeModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        runtime.add_processor(TimecodeProcessor::new(self.0.clone()));
        runtime.injector_mut().provide(self.0);

        Ok(())
    }
}
