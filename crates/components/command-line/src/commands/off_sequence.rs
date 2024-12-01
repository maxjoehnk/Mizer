use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;

impl Command for Off<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(StopSequenceCommand {
            sequence_id: self.target_entity.id.first(),
        })
    }
}

impl Command for Off<Sequences, All> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        let sequences = context.execute_query(ListSequencesQuery)?;
        for sequence in sequences {
            context.execute_command(StopSequenceCommand {
                sequence_id: sequence.id,
            })?;
        }

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;

    #[test]
    pub fn parse() {
        let expected = Off {
            target_type: Sequences,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("off sequence 1", expected);
    }
}
