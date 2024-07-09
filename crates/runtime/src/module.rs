use crate::debug_ui_pane::NodesDebugUiPane;
use mizer_module::*;
use crate::Pipeline;
use crate::pipeline::RuntimeProcessor;

pub struct RuntimeModule;

module_name!(RuntimeModule);

impl Module for RuntimeModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let pipeline = Pipeline::new();
        context.provide(pipeline);
        context.add_processor(RuntimeProcessor);
        context.add_debug_ui_pane(NodesDebugUiPane);

        Ok(())
    }
}
