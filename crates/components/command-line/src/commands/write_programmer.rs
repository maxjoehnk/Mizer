use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Write<Fixtures, Range, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for Write<Fixtures, Range, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for Write<Fixtures, ActiveSelection, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}
