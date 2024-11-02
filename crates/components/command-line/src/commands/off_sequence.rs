use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Off<Sequences, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(StopSequenceCommand {
            sequence_id: self.target_entity.id.first(),
        })
    }
}
