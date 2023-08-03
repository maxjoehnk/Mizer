use mizer_module::{Module, Runtime};

pub struct ProDjLinkModule;

impl Module for ProDjLinkModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();

        Ok(())
    }
}
