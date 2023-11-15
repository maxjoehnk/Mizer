use mizer_module::*;

use crate::in_main_loop_executor::InMainLoopExecutor;
use crate::{CommandExecutor, CommandExecutorApi, CommandHistory, CommandProcessor};

pub struct CommandExecutorModule;

module_name!(CommandExecutorModule);

impl Module for CommandExecutorModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let (executor, worker) = InMainLoopExecutor::new();
        let executor_api = CommandExecutorApi(executor);
        context.provide_api(executor_api);
        let executor = CommandExecutor::new();
        let history = CommandHistory::new();
        context.provide(history);
        context.add_processor(CommandProcessor::new(executor, worker));

        Ok(())
    }
}
