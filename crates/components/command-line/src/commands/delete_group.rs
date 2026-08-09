use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;
use mizer_fixtures::GroupId;

impl Command for Delete<Groups, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(DeleteGroupCommand {
            id: self.target_entity.id.first().into(),
        })?;

        Ok(())
    }
}

impl Command for Delete<Groups, Range> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        let result = context.execute_query(ListGroupsQuery)?;
        let result = result.into_iter().map(|group| Id::from(group.id)).collect::<Vec<_>>();
        let ids = self.target_entity.evaluate_range(&result);
        for id in ids {
            context.execute_command(DeleteGroupCommand {
                id: id.into(),
            })?;
        }

        Ok(())
    }
}

impl From<Id> for GroupId {
    fn from(id: Id) -> Self {
        GroupId(id.first())
    }
}

impl From<GroupId> for Id {
    fn from(id: GroupId) -> Self {
        Id::single(id.0)
    }
}

#[cfg(test)]
mod tests {
    use crate::commands::tests::assert_command;

    use super::*;

    #[test]
    pub fn parse_single() {
        let expected = Delete {
            target_type: Groups,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command("delete group 1", expected);
    }

    #[test]
    pub fn parse_range() {
        let expected = Delete {
            target_type: Groups,
            target_entity: Range { from: Id::single(1), to: Id::single(10) },
        };

        assert_command("delete group 1..10", expected);
    }
}
