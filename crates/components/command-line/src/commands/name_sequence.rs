use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::parser::*;
use crate::ast::*;

impl Command for Name<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}
