use mizer_module::*;

use crate::connections::OscConnectionManager;
use crate::project_handler::OscProjectHandler;

pub struct OscModule;

module_name!(OscModule);

impl Module for OscModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.provide(OscConnectionManager::new());
        context.add_project_handler(OscProjectHandler);

        Ok(())
    }
}
