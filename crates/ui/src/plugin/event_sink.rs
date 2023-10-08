use std::fmt::Debug;
use std::sync::{Arc, Mutex};

use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventSink, RunLoopSender};
use nativeshell::util::Capsule;

use mizer_util::Subscriber;

pub struct EventSinkSubscriber {
    capsule: Arc<Mutex<Capsule<InnerSubscriber>>>,
    sender: RunLoopSender,
}

struct InnerSubscriber {
    sink: EventSink,
}

pub trait IntoFlutterValue {
    fn into(self) -> Value;
}

impl IntoFlutterValue for Option<String> {
    fn into(self) -> Value {
        match self {
            Some(s) => Value::String(s),
            None => Value::Null,
        }
    }
}

// This is required as we cannot implement IntoFlutterValue for Option<String>
// when we implement it for every T: mizer_api::Message as another crate could
// implement mizer_api::Message for Option<String> causing conflicting implementations.
#[macro_export]
macro_rules! impl_into_flutter_value {
    ($t: ty) => {
        impl $crate::plugin::event_sink::IntoFlutterValue for $t {
            fn into(self) -> Value {
                use mizer_api::Message;

                Value::U8List(Message::encode_to_vec(&self))
            }
        }
    };
}

impl<E: Send + Sync + IntoFlutterValue + Debug> Subscriber<E> for EventSinkSubscriber {
    fn next(&self, event: E) {
        log::trace!("send msg {:?}", event);
        let msg = event.into();
        self.run_in_run_loop(move |inner| inner.send(msg));
    }
}

impl InnerSubscriber {
    fn send(&self, value: Value) {
        if let Err(err) = self.sink.send_message(&value) {
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
        Cb: FnOnce(&InnerSubscriber) + Send,
    {
        let capsule = Arc::clone(&self.capsule);
        self.sender.send(move || {
            let capsule = capsule.try_lock();
            if let Ok(capsule) = capsule {
                if let Some(inner) = capsule.get_ref() {
                    cb(inner);
                } else {
                    log::error!("Could not acquire subscriber")
                }
            } else {
                log::error!("Could not acquire capsule lock")
            }
        });
    }
}
