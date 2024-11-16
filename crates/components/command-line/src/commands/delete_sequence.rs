use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;

impl Command for Delete<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(DeleteSequenceCommand {
            sequence_id: self.target_entity.id.first(),
        })?;

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;

    #[test]
    pub fn parse() {
        let expected = Delete {
            target_type: Sequences,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("delete sequence 1", expected);
    }
}
