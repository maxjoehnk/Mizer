use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for GoForward<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for GoBackward<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

#[cfg(test)]
mod tests {
    use crate::commands::tests::assert_command;
    use super::*;

    #[test]
    pub fn parse_go_forward() {
        let expected = GoForward {
            target_type: Sequences,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("go sequence 1", expected);
    }

    #[test]
    pub fn parse_go_backward() {
        let expected = GoBackward {
            target_type: Sequences,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("go- sequence 1", expected);
    }
}
