use mizer_module::{Module, Runtime};

use crate::connections::MqttConnectionManager;

pub struct MqttModule;

impl Module for MqttModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(MqttConnectionManager::new());

        Ok(())
    }
}
