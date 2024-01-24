use std::collections::HashMap;

use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventChannelHandler, EventSink, RegisteredEventChannel};

use mizer_api::handlers::TransportHandler;
use mizer_api::RuntimeApi;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::impl_into_flutter_value;
use crate::plugin::event_sink::EventSinkSubscriber;

pub struct TransportEventChannel<R: RuntimeApi, AR: AsyncRuntime> {
    context: Context,
    handler: TransportHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl_into_flutter_value!(mizer_api::proto::transport::Transport);

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> EventChannelHandler
    for TransportEventChannel<R, AR>
{
    fn register_event_sink(&mut self, sink: EventSink, _: Value) {
        let id = sink.id();
        let stream = self.handler.transport_stream();
        let subscription = self.runtime.subscribe(
            stream.stream(),
            EventSinkSubscriber::new(sink, &self.context),
        );
        self.subscriptions.insert(id, subscription);
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            subscription.unsubscribe();
        }
    }
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> TransportEventChannel<R, AR> {
    pub fn new(handler: TransportHandler<R>, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/transport/watch")
    }
}
