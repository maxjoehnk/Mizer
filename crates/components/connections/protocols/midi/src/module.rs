use mizer_module::{Module, Runtime};

use crate::connections::MidiConnectionManager;
use crate::processor::MidiProcessor;

pub struct MidiModule;

impl Module for MidiModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        runtime.injector_mut().provide(MidiConnectionManager::new());
        runtime.add_processor(MidiProcessor);

        Ok(())
    }
}
