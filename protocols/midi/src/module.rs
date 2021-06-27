use mizer_module::{Runtime, Module};
use crate::connections::MidiConnectionManager;

pub struct MidiModule;

impl Module for MidiModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        runtime.injector_mut().provide(MidiConnectionManager::new());

        Ok(())
    }
}
