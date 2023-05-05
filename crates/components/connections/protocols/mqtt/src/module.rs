use crate::connections::MqttConnectionManager;
use mizer_module::{Module, Runtime};

pub struct MqttModule;

impl Module for MqttModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(MqttConnectionManager::new());

        Ok(())
    }
}
