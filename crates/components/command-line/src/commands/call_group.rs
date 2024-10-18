use mizer_command_executor::*;
use mizer_fixtures::GroupId;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Call<Groups, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(CallGroupCommand {
            group_id: GroupId(self.target_entity.id),
        })?;
        
        Ok(())
    }
}
