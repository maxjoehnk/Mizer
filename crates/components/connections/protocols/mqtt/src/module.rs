use mizer_module::*;

use crate::connections::MqttConnectionManager;
use crate::project_handler::MqttProjectHandler;

pub struct MqttModule;

module_name!(MqttModule);

impl Module for MqttModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.provide(MqttConnectionManager::new());
        context.add_project_handler(MqttProjectHandler);

        Ok(())
    }
}
