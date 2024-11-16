use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;

impl Command for GoForward<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SequenceGoForwardCommand {
            sequence_id: self.target_entity.id.first(),
        })
    }
}

impl Command for GoBackward<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SequenceGoBackwardCommand {
            sequence_id: self.target_entity.id.first(),
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;

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
