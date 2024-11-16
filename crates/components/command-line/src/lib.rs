use downcast::downcast;
use futures::future::BoxFuture;
use futures::FutureExt;
use mizer_command_executor::{SendableCommand, SendableQuery};
use std::fmt::Debug;
use std::future::Future;
use std::ops::Deref;

mod ast;
mod commands;
mod parser;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct Id {
    array: [u32; 2],
    len: usize,
}

impl Deref for Id {
    type Target = [u32];

    fn deref(&self) -> &Self::Target {
        &self.array[..self.len]
    }
}

impl PartialOrd for Id {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Id {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.deref().cmp(other.deref())
    }
}

impl Id {
    pub fn single(id: u32) -> Self {
        Self {
            array: [id, 0],
            len: 1,
        }
    }

    pub fn new(slice: [u32; 2]) -> Self {
        Self {
            array: slice,
            len: 2,
        }
    }

    pub fn first(&self) -> u32 {
        self.array[0]
    }

    pub fn depth(&self) -> usize {
        self.len
    }
}

pub trait CommandLineContext: Send + Sync {
    fn execute_command<'a>(
        &self,
        command: impl SendableCommand<'a> + 'static,
    ) -> anyhow::Result<()>;
    fn execute_query<'a, TQuery: SendableQuery<'a> + 'static>(
        &self,
        query: TQuery,
    ) -> anyhow::Result<TQuery::Result>;
}

trait BoxCommand<TContext: CommandLineContext>: downcast::Any {
    fn boxed(self) -> Box<dyn BoxCommand<TContext>>;

    fn execute<'a>(&'a self, context: &'a TContext) -> BoxFuture<'a, anyhow::Result<()>>;
}

downcast!(<X> dyn BoxCommand<X> where X: CommandLineContext);

impl<T: Command + 'static, TContext: CommandLineContext> BoxCommand<TContext> for T {
    fn boxed(self) -> Box<dyn BoxCommand<TContext>> {
        Box::new(self)
    }

    fn execute<'a>(&'a self, context: &'a TContext) -> BoxFuture<'a, anyhow::Result<()>> {
        self.execute(context).boxed()
    }
}

trait Command: Debug + Send + Sync + PartialEq {
    fn execute(
        &self,
        context: &impl CommandLineContext,
    ) -> impl Future<Output = anyhow::Result<()>> + Send;
}

pub(crate) fn try_parse_as_command<TContext: CommandLineContext>(
    input: &str,
) -> anyhow::Result<Box<dyn BoxCommand<TContext>>> {
    let tokens = parser::parse(input)?;
    tracing::debug!("Tokens: {tokens:?}");
    let command = ast::parse(tokens)?;

    Ok(command)
}

pub async fn try_execute<TContext: CommandLineContext + 'static>(
    context: &TContext,
    input: &str,
) -> anyhow::Result<()> {
    let command = try_parse_as_command(input)?;

    command.execute(context).await?;

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::cmp::Ordering;
    use test_case::test_case;

    #[test_case(Id::single(1), Id::single(2), Ordering::Less)]
    #[test_case(Id::single(2), Id::single(1), Ordering::Greater)]
    #[test_case(Id::single(1), Id::single(1), Ordering::Equal)]
    #[test_case(Id::new([1, 1]), Id::new([1, 2]), Ordering::Less)]
    #[test_case(Id::single(1), Id::new([1, 1]), Ordering::Less)]
    #[test_case(Id::single(2), Id::new([1, 1]), Ordering::Greater)]
    fn cmp_should_order_ids(id1: Id, id2: Id, expected: Ordering) {
        let result = id1.cmp(&id2);

        assert_eq!(result, expected);
    }
}
