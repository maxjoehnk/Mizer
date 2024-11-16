use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;
use mizer_fixtures::GroupId;

impl Command for Store<Fixtures, ActiveSelection, Groups, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(AssignProgrammerToGroupCommand {
            group_id: GroupId(self.target_entity.id.first()),
            mode: StoreGroupMode::Merge,
        })?;

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;

    #[test]
    pub fn parse_single() {
        let expected = Store {
            source_type: Fixtures,
            source_entity: ActiveSelection,
            target_type: Groups,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("store group 1", expected);
    }
}
