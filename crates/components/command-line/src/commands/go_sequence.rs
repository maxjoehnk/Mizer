use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::parser::*;
use crate::ast::*;

impl Command for GoForward<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for GoBackward<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}