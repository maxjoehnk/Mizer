use crate::connections::OscConnectionManager;
use mizer_module::{Module, Runtime};

pub struct OscModule;

impl Module for OscModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(OscConnectionManager::new());

        Ok(())
    }
}
