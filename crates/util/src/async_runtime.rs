use futures::stream::Stream;
use std::future::Future;

pub trait AsyncRuntime: Clone {
    type Subscription: StreamSubscription;

    fn subscribe<E: Sync + Send + 'static>(
        &self,
        stream: impl Stream<Item = E> + Send + 'static,
        handler: impl Subscriber<E> + 'static,
    ) -> Self::Subscription;

    fn block_on<E: Future>(&self, future: E) -> E::Output;
}

pub trait StreamSubscription {
    fn unsubscribe(self);
}

pub trait Subscriber<E: Sync + Send>: Send + Sync {
    fn next(&self, event: E);
}
