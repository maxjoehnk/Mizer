use crate::ast::*;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;

impl Command for Clear {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(ClearProgrammerCommand)?;

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;

    #[test]
    pub fn parse() {
        assert_command("clear", Clear);
    }
}
