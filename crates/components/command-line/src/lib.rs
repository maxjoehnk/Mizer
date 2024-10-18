use std::future::Future;
use mizer_command_executor::{SendableCommand};
use futures::future::BoxFuture;
use futures::FutureExt;
use mizer_ui_api::dialog::Dialog;

mod ast;
mod parser;
mod commands;

pub trait CommandLineContext: Send + Sync {
    fn execute_command<'a>(&self, command: impl SendableCommand<'a> + 'static) -> anyhow::Result<()>;
    async fn show_dialog(&self, dialog: Dialog) -> anyhow::Result<Option<String>>;
}

trait BoxCommand<TContext: CommandLineContext> {
    fn boxed(self) -> Box<dyn BoxCommand<TContext>>;

    fn execute<'a>(&'a self, context: &'a TContext) -> BoxFuture<'a, anyhow::Result<()>>;
}

impl<T: Command + 'static, TContext: CommandLineContext> BoxCommand<TContext> for T {
    fn boxed(self) -> Box<dyn BoxCommand<TContext>> {
        Box::new(self)
    }

    fn execute<'a>(&'a self, context: &'a TContext) -> BoxFuture<'a, anyhow::Result<()>> {
        self.execute(context).boxed()
    }
}

trait Command: Send + Sync {
    fn execute(&self, context: &impl CommandLineContext) -> impl Future<Output = anyhow::Result<()>> + Send;
}

pub async fn try_parse_as_command<TContext: CommandLineContext>(context: &TContext, input: &str) -> anyhow::Result<()> {
    let tokens = parser::parse(input)?;
    tracing::debug!("Tokens: {tokens:?}");
    let command = ast::parse(tokens)?;

    command.execute(context).await?;

    Ok(())
}

