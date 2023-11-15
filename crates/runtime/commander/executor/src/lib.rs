pub use mizer_commander::Command;
use mizer_processing::Injector;

pub use crate::executor::CommandExecutor;
pub use crate::history::CommandHistory;
use crate::in_main_loop_executor::{InMainLoopExecutionWorker, InMainLoopExecutor};
pub use crate::module::CommandExecutorModule;
pub use crate::processor::CommandProcessor;

pub use self::commands::*;

mod aggregates;
mod commands;
mod executor;
mod history;
mod in_main_loop_executor;
mod module;
mod processor;

#[derive(Clone)]
pub struct CommandExecutorApi(InMainLoopExecutor);

impl CommandExecutorApi {
    pub fn run_command<'a, T: SendableCommand<'a> + 'static>(
        &self,
        command: T,
    ) -> anyhow::Result<T::Result>
    where
        T::Result: Send + Sync,
    {
        let cmd = command.into();
        let result = self.0.run_in_main_loop(move |executor, injector| {
            let result = cmd.apply(injector, executor);
            let history = injector.get_mut::<CommandHistory>().unwrap();
            history.add_entry(cmd);

            result
        })??;
        let result = result.downcast::<T::Result>().unwrap();

        Ok(*result)
    }

    pub fn undo(&self) -> anyhow::Result<()> {
        self.0.run_in_main_loop(move |executor, injector| {
            let injector1: &mut Injector = unsafe { std::mem::transmute_copy(&injector) };
            let history = injector1.get_mut::<CommandHistory>().unwrap();
            history.undo(executor, injector)
        })??;

        Ok(())
    }

    pub fn redo(&self) -> anyhow::Result<()> {
        self.0.run_in_main_loop(move |executor, injector| {
            let injector1: &mut Injector = unsafe { std::mem::transmute_copy(&injector) };
            let history = injector1.get_mut::<CommandHistory>().unwrap();
            history.redo(executor, injector)
        })??;

        Ok(())
    }
}
