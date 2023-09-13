use mizer_module::{Module, Runtime};

use crate::connections::OscConnectionManager;

pub struct OscModule;

impl Module for OscModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(OscConnectionManager::new());

        Ok(())
    }
}
