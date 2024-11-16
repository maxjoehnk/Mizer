use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Delete<Groups, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(DeleteGroupCommand {
            id: self.target_entity.id.first().into(),
        })?;

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use crate::commands::tests::assert_command;

    use super::*;

    #[test]
    pub fn parse() {
        let expected = Delete {
            target_type: Groups,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("delete group 1", expected);
    }
}
