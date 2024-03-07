use mizer_module::*;
use mizer_wgpu::window::EventLoopHandle;

use crate::render_handle::Pane;
use crate::EguiDebugUi;

pub struct EguiDebugUiModule(pub Vec<Pane>);

module_name!(EguiDebugUiModule);

impl Module for EguiDebugUiModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        if let Some(handle) = context.try_get::<EventLoopHandle>() {
            let ui = EguiDebugUi::new(handle, self.0)?;

            context.provide(ui);
        }

        Ok(())
    }
}
