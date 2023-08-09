use mizer_util::Subscriber;
use nativeshell::codec::Value;
use nativeshell::shell::{Context, EventSink, RunLoopSender};
use nativeshell::util::Capsule;
use std::fmt::Debug;
use std::sync::{Arc, Mutex};

pub struct EventSinkSubscriber {
    capsule: Arc<Mutex<Capsule<InnerSubscriber>>>,
    sender: RunLoopSender,
}

struct InnerSubscriber {
    sink: EventSink,
}

impl<E: Send + Sync + mizer_api::Message + Debug> Subscriber<E> for EventSinkSubscriber {
    fn next(&self, event: E) {
        log::trace!("send msg {:?}", event);
        let msg = event.encode_to_vec();
        self.run_in_run_loop(move |inner| inner.send(msg));
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
