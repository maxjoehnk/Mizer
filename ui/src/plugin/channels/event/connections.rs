use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventChannelHandler, EventSink, RegisteredEventChannel};
use std::collections::HashMap;

use mizer_api::handlers::ConnectionsHandler;
use mizer_api::RuntimeApi;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::plugin::event_sink::EventSinkSubscriber;

pub struct MonitorMidiEventChannel<R: RuntimeApi, AR: AsyncRuntime> {
    context: Context,
    handler: ConnectionsHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> EventChannelHandler
    for MonitorMidiEventChannel<R, AR>
{
    fn register_event_sink(&mut self, sink: EventSink, value: Value) {
        let id = sink.id();
        if let Value::String(name) = value {
            match self.handler.monitor_midi(name) {
                Ok(stream) => {
                    let subscription = self
                        .runtime
                        .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
                    self.subscriptions.insert(id, subscription);
                }
                Err(err) => log::error!("Monitoring midi device failed {:?}", err),
            }
        }
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            log::trace!("Dropped monitor midi subscription");
            subscription.unsubscribe();
        }
    }
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> MonitorMidiEventChannel<R, AR> {
    pub fn new(handler: ConnectionsHandler<R>, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/connections/midi")
    }
}
