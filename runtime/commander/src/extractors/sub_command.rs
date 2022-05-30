use crate::{Command, ExtractDependencies};
use mizer_injector::Injector;

pub struct SubCommand<T>(T);

pub struct SubCommandRunner<'a, T: Command<'a>>(
    <<T as Command<'a>>::Dependencies as ExtractDependencies<'a>>::Type,
);

impl<'a, T: Command<'a>> SubCommandRunner<'a, T> {
    pub fn apply(self, command: T) -> anyhow::Result<(T::Result, (T, T::State))> {
        let (result, state) = command.apply(self.0)?;

        Ok((result, (command, state)))
    }

    pub fn revert(self, (command, state): (T, T::State)) -> anyhow::Result<()> {
        command.revert(self.0, state)
    }
}

impl<'a, T: Command<'a>> ExtractDependencies<'a> for SubCommand<T> {
    type Type = SubCommandRunner<'a, T>;

    fn extract(injector: &'a mut Injector) -> Self::Type {
        let dependencies = T::Dependencies::extract(injector);

        SubCommandRunner(dependencies)
    }
}

#[macro_export]
macro_rules! sub_command {
    ($command:ty) => {
        ($command, <$command as Command<'a>>::State)
    };
}
