use mizer_commander::{Command, ExtractDependencies};
use mizer_processing::Injector;
use std::any::{Any, TypeId};
use std::collections::hash_map::DefaultHasher;
use std::collections::HashMap;
use std::hash::{Hash, Hasher};

pub struct CommandExecutor {
    states: HashMap<CommandKey, Box<dyn Any>>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct CommandKey {
    command_type: TypeId,
    command_hash: u64,
}

impl CommandExecutor {
    pub fn new() -> Self {
        Self {
            states: Default::default(),
        }
    }

    fn command_key<'a, T: Command<'a> + 'static>(command: &T) -> CommandKey {
        let mut hasher = DefaultHasher::new();
        command.hash(&mut hasher);
        let hash = hasher.finish();

        CommandKey {
            command_type: TypeId::of::<T>(),
            command_hash: hash,
        }
    }

    pub fn apply<'a, T: Command<'a> + 'static>(
        &'a mut self,
        injector: &'a mut Injector,
        command: &T,
    ) -> anyhow::Result<T::Result> {
        log::debug!("Applying command {:?}", command);
        let dependencies = T::Dependencies::extract(injector);
        let (result, state) = command.apply(dependencies)?;
        self.states
            .insert(Self::command_key(command), Box::new(state));

        Ok(result)
    }

    pub fn revert<'a, T: Command<'a> + 'static>(
        &'a mut self,
        injector: &'a mut Injector,
        command: &T,
    ) -> anyhow::Result<()> {
        log::debug!("Reverting command {:?}", command);
        let dependencies = T::Dependencies::extract(injector);
        let state = self
            .states
            .remove(&Self::command_key(command))
            .ok_or_else(|| anyhow::anyhow!("Missing state for command reversion"))?;
        let state = state.downcast::<T::State>().unwrap();
        command.revert(dependencies, *state)
    }
}
