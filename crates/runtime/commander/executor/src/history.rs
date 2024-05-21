use crate::{CommandExecutor, CommandImpl};
use mizer_module::Injector;
use std::time::{SystemTime, UNIX_EPOCH};
use crate::executor::CommandKey;

pub struct CommandHistory {
    commands: CommandCursor<(CommandImpl, CommandKey, SystemTime)>,
}

impl CommandHistory {
    pub(crate) fn new() -> Self {
        Self {
            commands: CommandCursor::new(),
        }
    }

    pub(crate) fn add_entry(&mut self, command: impl Into<CommandImpl>, key: CommandKey) {
        let command = command.into();
        self.commands.push((command, key, SystemTime::now()));
    }

    pub(crate) fn undo(
        &mut self,
        executor: &mut CommandExecutor,
        injector: &mut Injector,
    ) -> anyhow::Result<()> {
        if let Some((command, key, _)) = self.commands.back() {
            command.revert(injector, executor, key)
        } else {
            Ok(())
        }
    }

    pub(crate) fn redo(
        &mut self,
        executor: &mut CommandExecutor,
        injector: &mut Injector,
    ) -> anyhow::Result<()> {
        if let Some((command, key, _)) = self.commands.forward() {
            command.apply(injector, executor, Some(*key))?;
            Ok(())
        } else {
            Ok(())
        }
    }

    pub fn items(&self) -> Vec<(String, u128)> {
        self.commands
            .commands
            .iter()
            .map(|(cmd, _key, time)| {
                let label = cmd.label();
                let timestamp = time
                    .duration_since(UNIX_EPOCH)
                    .unwrap_or_default()
                    .as_millis();

                (label, timestamp)
            })
            .collect()
    }

    pub fn index(&self) -> usize {
        self.commands
            .cursor
            .0
            .map(|pointer| pointer + 1)
            .unwrap_or_default()
    }
}

#[derive(Debug)]
struct CommandCursor<T> {
    commands: Vec<T>,
    cursor: OptionIndex,
}

impl<T> CommandCursor<T> {
    pub fn new() -> Self {
        Self {
            commands: Default::default(),
            cursor: Default::default(),
        }
    }

    pub fn is_empty(&self) -> bool {
        self.commands.is_empty()
    }

    pub fn push(&mut self, command: T) {
        if self.commands.is_empty() {
            self.commands.push(command);
            self.cursor = OptionIndex(Some(0));
            return;
        }

        self.commands.truncate(self.cursor + 1usize);
        self.commands.push(command);
        self.cursor += 1i32;
    }

    pub fn get(&self) -> Option<&T> {
        self.cursor.0.and_then(|cursor| self.commands.get(cursor))
    }

    pub fn back(&mut self) -> Option<&T> {
        if let Some(cursor) = self.cursor.0 {
            let current = self.commands.get(cursor);
            self.cursor -= 1i32;

            current
        } else {
            None
        }
    }

    pub fn forward(&mut self) -> Option<&T> {
        if let Some(cursor) = self.cursor.0 {
            if cursor > self.commands.len() {
                return None;
            }
        }
        self.cursor += 1;
        self.get()
    }
}

#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
struct OptionIndex(Option<usize>);

impl std::ops::SubAssign<i32> for OptionIndex {
    fn sub_assign(&mut self, rhs: i32) {
        if let Some(index) = self.0 {
            let index = index as i32;
            if index - rhs < 0 {
                self.0 = None;
            } else {
                self.0 = Some((index - rhs) as usize);
            }
        }
    }
}

impl std::ops::AddAssign<i32> for OptionIndex {
    fn add_assign(&mut self, rhs: i32) {
        if let Some(index) = self.0 {
            let index = index as i32;
            if index + rhs < 0 {
                self.0 = None;
            } else {
                self.0 = Some((index + rhs) as usize);
            }
        } else if rhs > 0 {
            self.0 = Some(rhs as usize - 1);
        }
    }
}

impl std::ops::Add<usize> for OptionIndex {
    type Output = usize;

    fn add(self, rhs: usize) -> Self::Output {
        if let Some(index) = self.0 {
            index + rhs
        } else {
            rhs - 1
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::history::CommandCursor;

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    struct Command(i32);

    #[test]
    fn push_should_add_command() {
        let mut cursor = CommandCursor::<Command>::new();
        let command = Command(1);

        cursor.push(command);

        let result = cursor.get();
        assert_eq!(Some(&command), result);
    }

    #[test]
    fn is_empty_should_return_true() {
        let cursor = CommandCursor::<Command>::new();

        let result = cursor.is_empty();

        assert!(result);
    }

    #[test]
    fn back_should_move_cursor_back() {
        let mut cursor = CommandCursor::<Command>::new();
        let command1 = Command(1);
        cursor.push(command1);
        let command2 = Command(2);
        cursor.push(command2);

        let result = cursor.back();

        assert_eq!(Some(&command2), result);
        assert_eq!(Some(&command1), cursor.get());
    }

    #[test]
    fn back_should_move_cursor_behind_first_item() {
        let mut cursor = CommandCursor::<Command>::new();
        let command = Command(1);
        cursor.push(command);

        let result = cursor.back();

        assert_eq!(Some(&command), result);
        assert_eq!(None, cursor.get());
    }

    #[test]
    fn forward_should_move_cursor_to_first_item() {
        let mut cursor = CommandCursor::<Command>::new();
        let command = Command(1);
        cursor.push(command);
        cursor.back();

        let result = cursor.forward();

        assert_eq!(Some(&command), result);
    }

    #[test]
    fn forward_should_move_cursor_forward() {
        let mut cursor = CommandCursor::<Command>::new();
        let command = Command(2);
        cursor.push(Command(1));
        cursor.push(command);
        cursor.back();

        let result = cursor.forward();

        assert_eq!(Some(&command), result);
    }

    #[test]
    fn push_should_drop_old_forward_history() {
        let mut cursor = CommandCursor::<Command>::new();
        let command = Command(3);
        cursor.push(Command(1));
        cursor.push(Command(2));
        cursor.back();

        cursor.push(command);

        let result = cursor.get();
        assert_eq!(Some(&command), result);
        assert_eq!(None, cursor.forward());
    }

    #[test]
    fn push_should_drop_old_forward_history_when_reverting_all_commands() {
        let mut cursor = CommandCursor::<Command>::new();
        let command = Command(2);
        cursor.push(Command(1));
        cursor.back();

        cursor.push(command);

        let result = cursor.get();
        assert_eq!(Some(&command), result);
        assert_eq!(None, cursor.forward());
    }
}
