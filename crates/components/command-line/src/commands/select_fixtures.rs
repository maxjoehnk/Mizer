use mizer_command_executor::*;
use mizer_fixtures::FixtureId;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Select<Fixtures, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: vec![FixtureId::Fixture(self.target_entity.id)]
        })?;

        Ok(())
    }
}

impl Command for Select<Fixtures, Range> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: (self.target_entity.from..=self.target_entity.to).map(|id| FixtureId::Fixture(id)).collect()
        })?;

        Ok(())
    }
}
