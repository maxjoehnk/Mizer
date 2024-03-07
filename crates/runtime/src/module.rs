use crate::debug_ui_pane::NodesDebugUiPane;
use mizer_module::*;

pub struct RuntimeModule;

module_name!(RuntimeModule);

impl Module for RuntimeModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.add_debug_ui_pane(NodesDebugUiPane);

        Ok(())
    }
}
