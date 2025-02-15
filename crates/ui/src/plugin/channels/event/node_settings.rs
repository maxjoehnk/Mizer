use std::collections::HashMap;

use nativeshell::codec::Value;
use nativeshell::shell::{EventChannelHandler, EventSink, RegisteredEventChannel};
use nativeshell::Context;

use mizer_api::handlers::{NodesHandler};
use mizer_api::proto::nodes::*;
use mizer_api::RuntimeApi;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::impl_into_flutter_value;
use crate::plugin::event_sink::EventSinkSubscriber;

pub struct NodeSettingsEventChannel<AR: AsyncRuntime, R> {
    context: Context,
    handler: NodesHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl_into_flutter_value!(NodeSettings);

impl<AR: AsyncRuntime + 'static, R: RuntimeApi + 'static> EventChannelHandler
    for NodeSettingsEventChannel<AR, R>
{
    fn register_event_sink(&mut self, sink: EventSink, value: Value) {
        let Value::String(path) = value else {
            return;
        };
        
        let id = sink.id();
        tracing::debug!("register_event_sink {}", id);
        let stream = self.handler.observe_node_settings(path);
        let subscription = self
            .runtime
            .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
        self.subscriptions.insert(id, subscription);
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        tracing::debug!("unregister_event_sink {}", sink_id);
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            tracing::trace!("Dropped node settings subscription");
            subscription.unsubscribe();
        }
    }
}

impl<AR: AsyncRuntime + 'static, R: RuntimeApi + 'static> NodeSettingsEventChannel<AR, R> {
    pub fn new(handler: NodesHandler<R>, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/nodes/settings")
    }
}
