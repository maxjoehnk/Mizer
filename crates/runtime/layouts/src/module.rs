use crate::debug_ui_pane::LayoutsDebugUiPane;
use crate::project_handler::LayoutProjectHandler;
use mizer_module::{module_name, Module, ModuleContext};

pub struct LayoutsModule;

module_name!(LayoutsModule);

impl Module for LayoutsModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.add_debug_ui_pane(LayoutsDebugUiPane);
        context.add_project_handler(LayoutProjectHandler);

        Ok(())
    }
}
