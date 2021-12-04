use std::collections::HashMap;
use std::sync::{Arc, Mutex};

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{
    Context, EngineHandle, EventChannelHandler, EventSink, MethodCallHandler, MethodChannel,
    RegisteredEventChannel, RunLoopSender,
};
use nativeshell::util::Capsule;
use protobuf::ProtobufEnum;

use mizer_api::handlers::TransportHandler;
use mizer_api::models::TransportState;
use mizer_api::RuntimeApi;
use mizer_util::{AsyncRuntime, StreamSubscription, Subscriber};

use crate::plugin::channels::MethodReplyExt;

pub struct TransportChannel<R: RuntimeApi> {
    handler: TransportHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for TransportChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "setState" => {
                if let Value::I64(state) = call.args {
                    let state = TransportState::from_i32(state as i32).unwrap();
                    if let Err(err) = self.set_state(state) {
                        resp.respond_error(err);
                    } else {
                        resp.send_ok(Value::Null);
                    }
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> TransportChannel<R> {
    pub fn new(handler: TransportHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/transport", self)
    }

    fn set_state(&self, state: TransportState) -> anyhow::Result<()> {
        self.handler.set_state(state)?;
        Ok(())
    }
}

pub struct TransportEventChannel<R: RuntimeApi, AR: AsyncRuntime> {
    context: Context,
    handler: TransportHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

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

struct EventSinkSubscriber {
    capsule: Arc<Mutex<Capsule<InnerSubscriber>>>,
    sender: RunLoopSender,
}

struct InnerSubscriber {
    sink: EventSink,
}

impl<E: Send + Sync + protobuf::Message> Subscriber<E> for EventSinkSubscriber {
    fn next(&self, event: E) {
        if let Ok(msg) = event.write_to_bytes() {
            self.run_in_run_loop(move |inner| inner.send(msg));
        }
    }
}

impl InnerSubscriber {
    fn send(&self, msg: Vec<u8>) {
        if let Err(err) = self.sink.send_message(&Value::U8List(msg)) {
            log::error!("{:?}", err);
        }
    }
}

impl EventSinkSubscriber {
    pub fn new(sink: EventSink, context: &Context) -> Self {
        let sender = context.get().unwrap().run_loop.borrow().new_sender();
        Self {
            capsule: Arc::new(Mutex::new(Capsule::new_with_sender(
                InnerSubscriber { sink },
                sender.clone(),
            ))),
            sender,
        }
    }

    fn run_in_run_loop<Cb: 'static>(&self, cb: Cb)
    where
        Cb: FnOnce(&InnerSubscriber) -> () + Send,
    {
        let capsule = Arc::clone(&self.capsule);
        self.sender.send(move || {
            let capsule = capsule.try_lock();
            if let Ok(capsule) = capsule {
                if let Some(inner) = capsule.get_ref() {
                    cb(inner);
                }
            }
        });
    }
}
