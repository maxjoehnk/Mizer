use std::future::Future;
use std::ops::Deref;
use mizer_command_executor::{SendableCommand};
use futures::future::BoxFuture;
use futures::FutureExt;
use smallvec::SmallVec;

mod ast;
mod parser;
mod commands;

#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct Id(SmallVec<[u32; 2]>);

impl Deref for Id {
    type Target = [u32];

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl Id {
    pub fn single(id: u32) -> Self {
        Self(SmallVec::from_slice(&[id]))
    }
    
    pub fn new(slice: &[u32]) -> Self {
        if slice.is_empty() {
            panic!("Id cannot be empty");
        }
        
        Self(SmallVec::from_slice(slice))
    }
    
    pub fn first(&self) -> u32 {
        self.0[0]
    }
    
    pub fn depth(&self) -> usize {
        self.0.len()
    }
}

pub trait CommandLineContext: Send + Sync {
    fn execute_command<'a>(&self, command: impl SendableCommand<'a> + 'static) -> anyhow::Result<()>;
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

