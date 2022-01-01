use futures::prelude::*;
use futures::StreamExt;
use mizer_util::{AsyncRuntime, StreamSubscription, Subscriber};
use tokio::runtime::Handle;
use tokio::task::JoinHandle;

#[derive(Clone)]
pub struct TokioRuntime {
    runtime: Handle,
}

impl TokioRuntime {
    pub fn new(handle: &Handle) -> Self {
        Self {
            runtime: handle.clone(),
        }
    }
}

impl AsyncRuntime for TokioRuntime {
    type Subscription = TokioSubscription;

    fn subscribe<E: Sync + Send + 'static>(
        &self,
        stream: impl Stream<Item = E> + Send + 'static,
        handler: impl Subscriber<E> + 'static,
    ) -> Self::Subscription {
        let future = StreamExt::for_each(stream, move |item| {
            handler.next(item);
            futures::future::ready(())
        });
        let handle = self.runtime.spawn(future);

        TokioSubscription(handle)
    }
}

pub struct TokioSubscription(JoinHandle<()>);

impl StreamSubscription for TokioSubscription {
    fn unsubscribe(self) {
        self.0.abort();
    }
}
