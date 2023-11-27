use std::collections::HashMap;

use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventChannelHandler, EventSink, RegisteredEventChannel};

use mizer_api::handlers::SessionHandler;
use mizer_api::proto::session::SessionState;
use mizer_api::RuntimeApi;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::impl_into_flutter_value;
use crate::plugin::event_sink::EventSinkSubscriber;

pub struct MonitorSessionChannel<R: RuntimeApi, AR: AsyncRuntime> {
    context: Context,
    handler: SessionHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl_into_flutter_value!(SessionState);

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> EventChannelHandler
    for MonitorSessionChannel<R, AR>
{
    fn register_event_sink(&mut self, sink: EventSink, _: Value) {
        let id = sink.id();
        match self.handler.watch_session() {
            Ok(stream) => {
                let subscription = self
                    .runtime
                    .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
                self.subscriptions.insert(id, subscription);
            }
            Err(err) => log::error!("Monitoring session failed {:?}", err),
        }
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            log::trace!("Dropped session subscription");
            subscription.unsubscribe();
        }
    }
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> MonitorSessionChannel<R, AR> {
    pub fn new(handler: SessionHandler<R>, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/session/watch")
    }
}
