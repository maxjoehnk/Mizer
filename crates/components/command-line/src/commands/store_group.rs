use mizer_command_executor::*;
use mizer_fixtures::GroupId;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Store<Fixtures, ActiveSelection, Groups, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(AssignProgrammerToGroupCommand {
            group_id: GroupId(self.target_entity.id.first()),
            mode: StoreGroupMode::Merge,
        })?;
        
        Ok(())
    }
}
