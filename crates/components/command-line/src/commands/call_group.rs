use mizer_command_executor::*;
use mizer_fixtures::GroupId;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Call<Groups, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(CallGroupCommand {
            group_id: GroupId(self.target_entity.id.first()),
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
        let expected = Call {
            target_type: Groups,
            target_entity: Single { id: Id::single(1) },
        };
        
        assert_command("call group 1", expected);
    }
}
