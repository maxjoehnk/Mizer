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
