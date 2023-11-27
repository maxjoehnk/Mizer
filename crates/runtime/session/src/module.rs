use mizer_module::*;

use crate::SessionManager;

pub struct SessionModule;

module_name!(SessionModule);

impl Module for SessionModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let manager = SessionManager::new()?;
        manager.emit_update();
        if let Err(err) = manager.start_discovery() {
            log::error!("Unable to start session discovery: {err:?}");
        }
        context.provide_api(manager);

        Ok(())
    }
}
