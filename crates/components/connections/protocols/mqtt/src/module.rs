use mizer_module::*;

use crate::connections::MqttConnectionManager;

pub struct MqttModule;

module_name!(MqttModule);

impl Module for MqttModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.provide(MqttConnectionManager::new());

        Ok(())
    }
}
