use std::collections::HashMap;

use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventChannelHandler, EventSink, RegisteredEventChannel};

use mizer_api::handlers::TimecodeHandler;
use mizer_api::proto::timecode::AllTimecodes;
use mizer_api::RuntimeApi;
use mizer_util::{AsyncRuntime, StreamSubscription};

use crate::impl_into_flutter_value;
use crate::plugin::event_sink::EventSinkSubscriber;

pub struct MonitorTimecodeChannel<R: RuntimeApi, AR: AsyncRuntime> {
    context: Context,
    handler: TimecodeHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl_into_flutter_value!(AllTimecodes);

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> EventChannelHandler
    for MonitorTimecodeChannel<R, AR>
{
    fn register_event_sink(&mut self, sink: EventSink, _: Value) {
        let id = sink.id();
        let stream = self.handler.observe_timecodes();
        let subscription = self
            .runtime
            .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
        self.subscriptions.insert(id, subscription);
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            log::trace!("Dropped timecode subscription");
            subscription.unsubscribe();
        }
    }
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> MonitorTimecodeChannel<R, AR> {
    pub fn new(handler: TimecodeHandler<R>, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/timecode/watch")
    }
}
