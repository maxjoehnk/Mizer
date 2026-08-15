use std::path::Path;
use mizer_module::*;

use crate::in_main_loop_executor::InMainLoopExecutor;
use crate::{CommandExecutor, CommandExecutorApi, CommandHistory, CommandProcessor};
use crate::write_ahead_log::WriteAheadLog;

pub struct CommandExecutorModule;

module_name!(CommandExecutorModule);

impl Module for CommandExecutorModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let (executor, worker) = InMainLoopExecutor::new();
        let executor_api = CommandExecutorApi {
            executor,
            api_injector: Default::default(),
        };
        context.provide_api(executor_api);
        let executor = CommandExecutor::new();
        let history = CommandHistory::new();
        context.provide(history);
        context.provide(executor);
        context.add_processor(CommandProcessor::new(worker));

        context.add_event_processor(WriteAheadLogProcessor);

        let write_ahead_log = WriteAheadLog;
        context.provide(write_ahead_log);

        Ok(())
    }
}

struct WriteAheadLogProcessor;

impl EventProcessor for WriteAheadLogProcessor {
    fn new_project(&self, injector: &Injector) -> anyhow::Result<()> {
        let log = injector.try_inject::<WriteAheadLog>()
            .ok_or_else(|| anyhow::anyhow!("WriteAheadLog not found"))?;
        log.truncate()?;

        Ok(())
    }

    fn load_project(&self, injector: &Injector, _path: &Path) -> anyhow::Result<()> {
        let log = injector.try_inject::<WriteAheadLog>()
            .ok_or_else(|| anyhow::anyhow!("WriteAheadLog not found"))?;
        let commands = log.read()?;

        if commands.is_empty() {
            return Ok(());
        }

        tracing::warn!("Unsaved changes found: {}", commands.len());

        Ok(())
    }

    fn save_project(&self, injector: &Injector, _path: &Path) -> anyhow::Result<()> {
        let log = injector.try_inject::<WriteAheadLog>()
            .ok_or_else(|| anyhow::anyhow!("WriteAheadLog not found"))?;
        log.truncate()?;

        Ok(())
    }


}
