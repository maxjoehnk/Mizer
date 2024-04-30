use std::collections::HashMap;

use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventChannelHandler, EventSink, RegisteredEventChannel};

use mizer_api::handlers::ConsoleHandler;
use mizer_api::proto::console::*;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::impl_into_flutter_value;
use crate::plugin::event_sink::EventSinkSubscriber;

pub struct MonitorConsoleChannel<AR: AsyncRuntime> {
    context: Context,
    handler: ConsoleHandler,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl_into_flutter_value!(ConsoleMessage);

impl<AR: AsyncRuntime + 'static> EventChannelHandler for MonitorConsoleChannel<AR> {
    fn register_event_sink(&mut self, sink: EventSink, _: Value) {
        let id = sink.id();
        let stream = self.handler.observe_console();
        let subscription = self
            .runtime
            .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
        self.subscriptions.insert(id, subscription);
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            tracing::trace!("Dropped console subscription");
            subscription.unsubscribe();
        }
    }
}

impl<AR: AsyncRuntime + 'static> MonitorConsoleChannel<AR> {
    pub fn new(handler: ConsoleHandler, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/console/watch")
    }
}
