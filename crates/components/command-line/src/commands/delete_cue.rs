use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;

impl Command for Delete<Cues, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(DeleteCueCommand {
            sequence_id: self.target_entity.id[0],
            cue_id: self.target_entity.id[1]
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
            target_type: Cues,
            target_entity: Single { id: Id::new([1, 1]) },
        };

        assert_command("delete cue 1.1", expected);
    }
}
