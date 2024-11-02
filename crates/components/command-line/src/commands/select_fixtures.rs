use mizer_command_executor::*;
use mizer_fixtures::FixtureId;
use crate::{Command, CommandLineContext, Id};
use crate::ast::*;

impl Command for Select<Fixtures, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: vec![FixtureId::from(&self.target_entity.id)]
        })?;

        Ok(())
    }
}

impl Command for Select<Fixtures, Range> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: (self.target_entity.from..=self.target_entity.to).map(|id| FixtureId::from(&id)).collect()
        })?;

        Ok(())
    }
}

impl From<&Id> for FixtureId {
    fn from(id: &Id) -> Self {
        match id.depth() {
            1 => FixtureId::Fixture(id.first()),
            2 => FixtureId::SubFixture(id[0], id[1]),
            _ => panic!("Invalid fixture id: {id:?}")
        }
    }
}