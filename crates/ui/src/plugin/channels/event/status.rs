use std::collections::HashMap;

use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventChannelHandler, EventSink, RegisteredEventChannel};

use mizer_api::handlers::StatusHandler;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::plugin::event_sink::EventSinkSubscriber;

pub struct MonitorStatusChannel<AR: AsyncRuntime> {
    context: Context,
    handler: StatusHandler,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl<AR: AsyncRuntime + 'static> EventChannelHandler for MonitorStatusChannel<AR> {
    fn register_event_sink(&mut self, sink: EventSink, _: Value) {
        let id = sink.id();
        let stream = self.handler.observe_status_messages().into_stream();
        let subscription = self
            .runtime
            .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
        self.subscriptions.insert(id, subscription);
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            log::trace!("Dropped status subscription");
            subscription.unsubscribe();
        }
    }
}

impl<AR: AsyncRuntime + 'static> MonitorStatusChannel<AR> {
    pub fn new(handler: StatusHandler, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/status/watch")
    }
}
