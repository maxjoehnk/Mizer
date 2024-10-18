use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Clear {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(ClearProgrammerCommand)?;

        Ok(())
    }
}
