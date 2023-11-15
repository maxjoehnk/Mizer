use mizer_module::*;
use mizer_wgpu::window::EventLoopHandle;

use crate::EguiDebugUi;

pub struct EguiDebugUiModule;

module_name!(EguiDebugUiModule);

impl Module for EguiDebugUiModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        if let Some(handle) = context.try_get::<EventLoopHandle>() {
            let ui = EguiDebugUi::new(handle)?;

            context.provide(ui);
        }

        Ok(())
    }
}
