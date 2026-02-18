use mizer_commander::{Command, ExtractDependencies, ExtractDependenciesQuery, Query};
use mizer_processing::{Inject, InjectionScope, Injector};
use std::any::{Any, TypeId};
use std::collections::HashMap;
use std::time::Instant;

#[derive(Default)]
pub struct CommandExecutor {
    states: HashMap<CommandKey, Box<dyn Any>>,
    command_index_counter: u64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) struct CommandIndex(u64);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub(crate) struct CommandKey {
    command_type: TypeId,
    command_index: CommandIndex,
}

impl CommandExecutor {
    pub fn new() -> Self {
        Self::default()
    }

    fn next_command_key<'a, T: Command<'a> + 'static>(&mut self, _command: &T) -> CommandKey {
        let next_index = self.command_index_counter;
        self.command_index_counter += 1;

        CommandKey {
            command_type: TypeId::of::<T>(),
            command_index: CommandIndex(next_index),
        }
    }

    pub(crate) fn apply<'a, T: Command<'a> + 'static>(
        &'a mut self,
        injector: &'a InjectionScope,
        command: &T,
        command_key: Option<CommandKey>,
    ) -> anyhow::Result<(T::Result, CommandKey)> {
        tracing::debug!("Applying command {:?}", command);
        mizer_console::info(mizer_console::ConsoleCategory::Commands, command.label());
        let dependencies = T::Dependencies::extract(injector);
        let (result, state) = command.apply(dependencies)?;
        let key = command_key.unwrap_or_else(|| self.next_command_key(command));
        tracing::trace!("Inserting state for Command key: {key:?}");
        self.states.insert(key, Box::new(state));

        Ok((result, key))
    }

    pub(crate) fn revert<'a, T: Command<'a> + 'static>(
        &'a mut self,
        injector: &'a InjectionScope,
        command: &T,
        command_key: &CommandKey,
    ) -> anyhow::Result<()> {
        tracing::debug!("Reverting command {:?}", command);
        mizer_console::info!(
            mizer_console::ConsoleCategory::Commands,
            "Undo: {}",
            command.label()
        );
        let dependencies = T::Dependencies::extract(injector);
        tracing::trace!("Requesting state for Command key: {command_key:?}");
        let state = self.states.remove(command_key).ok_or_else(|| {
            anyhow::anyhow!("Missing state for command reversion with key {command_key:?}")
        })?;
        let state = state.downcast::<T::State>().unwrap();
        command.revert(dependencies, *state)
    }

    pub fn query<'a, T: Query<'a> + 'static>(
        &'a self,
        injector: &'a impl Inject,
        query: &T,
    ) -> anyhow::Result<T::Result> {
        let before = Instant::now();
        let dependencies = T::Dependencies::extract(injector);
        let result = query.query(dependencies);
        let after = Instant::now();
        tracing::debug!("Executed query {query:?} in {:?}", after - before);

        result
    }
}
