use crate::debug_ui_pane::PlanDebugUiPane;
use mizer_module::{module_name, Module, ModuleContext};

pub struct PlansModule;

module_name!(PlansModule);

impl Module for PlansModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        context.add_debug_ui_pane(PlanDebugUiPane);

        Ok(())
    }
}
