use crate::debug_ui_pane::NodesDebugUiPane;
use crate::pipeline::RuntimeProcessor;
use crate::Pipeline;
use mizer_module::*;
use crate::project_handler::PipelineProjectHandler;

pub struct RuntimeModule;

module_name!(RuntimeModule);

impl Module for RuntimeModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let pipeline = Pipeline::new();
        context.provide(pipeline);
        context.add_processor(RuntimeProcessor);
        context.add_debug_ui_pane(NodesDebugUiPane);
        context.add_project_handler(PipelineProjectHandler);

        Ok(())
    }
}
