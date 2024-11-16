pub use mizer_commander::Command;
use mizer_module::ApiInjector;
use mizer_processing::Injector;
use parking_lot::RwLock;
use std::any::{type_name, TypeId};
use std::sync::Arc;

pub use crate::executor::CommandExecutor;
pub use crate::history::CommandHistory;
use crate::in_main_loop_executor::{InMainLoopExecutionWorker, InMainLoopExecutor};
pub use crate::module::CommandExecutorModule;
pub use crate::processor::CommandProcessor;

pub use self::commands::*;
pub use self::queries::*;

mod aggregates;
mod commands;
mod executor;
mod history;
mod in_main_loop_executor;
mod module;
mod processor;
mod queries;

pub trait ICommandExecutor {
    fn run_command<'a, T: SendableCommand<'a> + 'static>(
        &self,
        command: T,
    ) -> anyhow::Result<T::Result>
    where
        T::Result: Send + Sync;

    fn execute_query<'a, T: SendableQuery<'a> + 'static>(
        &self,
        query: T,
    ) -> anyhow::Result<T::Result>;

    fn undo(&self) -> anyhow::Result<()>;
    fn redo(&self) -> anyhow::Result<()>;
}

#[derive(Clone)]
pub struct CommandExecutorApi {
    executor: InMainLoopExecutor,
    api_injector: Arc<RwLock<Option<ApiInjector>>>,
}

impl ICommandExecutor for CommandExecutorApi {
    fn run_command<'a, T: SendableCommand<'a> + 'static>(
        &self,
        command: T,
    ) -> anyhow::Result<T::Result>
    where
        T::Result: Send + Sync,
    {
        let cmd = command.into();
        let result: anyhow::Result<_> =
            self.executor.run_in_main_loop(move |executor, injector| {
                let (result, key) = cmd.apply(injector, executor, None)?;
                let history = injector.get_mut::<CommandHistory>().unwrap();
                history.add_entry(cmd, key);

                Ok(result)
            })?;
        let result = result?;
        let result = result.downcast::<T::Result>().unwrap();

        Ok(*result)
    }

    fn execute_query<'a, T: SendableQuery<'a> + 'static>(
        &self,
        query: T,
    ) -> anyhow::Result<T::Result>
    where
        T::Result: Send + Sync,
    {
        let _stopwatch = mizer_util::stopwatch!("Executed query from api {query:?}");
        let requires_main_loop = query.requires_main_loop();
        let query = query.into();
        let result = if requires_main_loop {
            self.executor
                .run_in_main_loop(move |_, injector| query.query(injector))?
        } else {
            query.query(self.api_injector.read().as_ref().unwrap())
        };
        let result = result?.downcast::<T::Result>().unwrap_or_else(|got| {
            panic!(
                "Expected query result to be of type {} ({:?}), but got {:?}",
                type_name::<T::Result>(),
                TypeId::of::<T::Result>(),
                (*got).type_id()
            );
        });

        Ok(*result)
    }

    fn undo(&self) -> anyhow::Result<()> {
        self.executor.run_in_main_loop(move |executor, injector| {
            let injector1: &mut Injector = unsafe { std::mem::transmute_copy(&injector) };
            let history = injector1.get_mut::<CommandHistory>().unwrap();
            history.undo(executor, injector)
        })??;

        Ok(())
    }

    fn redo(&self) -> anyhow::Result<()> {
        self.executor.run_in_main_loop(move |executor, injector| {
            let injector1: &mut Injector = unsafe { std::mem::transmute_copy(&injector) };
            let history = injector1.get_mut::<CommandHistory>().unwrap();
            history.redo(executor, injector)
        })??;

        Ok(())
    }
}

impl CommandExecutorApi {
    pub fn provide_injector(&self, api_injector: ApiInjector) {
        self.api_injector.write().replace(api_injector);
    }
}
