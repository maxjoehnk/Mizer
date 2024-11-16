use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Clear {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(ClearProgrammerCommand)?;

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use crate::commands::tests::assert_command;
    use super::*;

    #[test]
    pub fn parse() {
        assert_command("clear", Clear);
    }
}
