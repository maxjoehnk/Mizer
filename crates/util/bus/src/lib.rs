use flume::r#async::RecvStream;
use flume::TryRecvError;
use futures::Stream;
use parking_lot::RwLock;
use std::ops::Deref;
use std::pin::Pin;
use std::sync::{Arc, Weak};
use std::task::{Context, Poll};

#[derive(Clone)]
pub struct MessageBus<T: Clone + Send + Sync> {
    senders: Arc<RwLock<Vec<Weak<flume::Sender<T>>>>>,
    last_event: Arc<RwLock<Option<T>>>,
}

impl<T: Clone + Send + Sync + 'static> Default for MessageBus<T> {
    fn default() -> Self {
        Self::new()
    }
}

impl<T: Clone + Send + Sync + 'static> MessageBus<T> {
    pub fn new() -> Self {
        Self {
            senders: Default::default(),
            last_event: Default::default(),
        }
    }

    pub fn send(&self, msg: T) {
        let senders = self.senders.read();
        let (active, dropped) = senders
            .iter()
            .map(|sender| sender.upgrade())
            .partition::<Vec<_>, _>(|sender| sender.is_some());

        let active_count = active.len();

        for sender in active {
            let sender = sender.unwrap();
            if let Err(err) = sender.send(msg.clone()) {
                log::error!("Sending message to subscriber failed: {:?}", err);
            }
        }

        let mut last_event = self.last_event.write();
        *last_event = Some(msg);

        log::trace!(
            "Send msg to {} / {} subscribers. {} dropped subscribers remaining",
            active_count,
            senders.len(),
            dropped.len()
        );
    }

    pub fn subscribe(&self) -> Subscriber<T> {
        let mut senders = self.senders.write();
        let (tx, rx) = flume::unbounded();
        if let Some(last_event) = self.last_event.read().deref() {
            log::trace!("Informing about last event");
            tx.send(last_event.clone()).unwrap();
        }
        let sender = Arc::new(tx);
        senders.push(Arc::downgrade(&sender));

        Subscriber::new(sender, rx)
    }
}

pub struct Subscriber<T> {
    _sender: Arc<flume::Sender<T>>,
    recv: flume::Receiver<T>,
}

impl<T: Clone + Send + Sync + 'static> Subscriber<T> {
    fn new(sender: Arc<flume::Sender<T>>, recv: flume::Receiver<T>) -> Self {
        Self {
            _sender: sender,
            recv,
        }
    }

    pub fn read(&self) -> Option<T> {
        match self.recv.try_recv() {
            Ok(value) => Some(value),
            Err(TryRecvError::Empty) => None,
            Err(_) => {
                log::error!("Bus Subscriber has disconnected");

                None
            }
        }
    }

    pub async fn read_async(&self) -> anyhow::Result<T> {
        let value = self.recv.recv_async().await?;

        Ok(value)
    }

    pub fn iter(&self) -> impl Iterator<Item = T> + '_ {
        self.recv.try_iter()
    }

    pub fn into_stream(self) -> impl Stream<Item = T> {
        SubscriberStream(self._sender, self.recv.into_stream())
    }
}

struct SubscriberStream<T: 'static>(Arc<flume::Sender<T>>, RecvStream<'static, T>);

impl<T: Clone + Send + Sync + 'static> Stream for SubscriberStream<T> {
    type Item = T;

    fn poll_next(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Option<Self::Item>> {
        Pin::new(&mut self.1).poll_next(cx)
    }

    fn size_hint(&self) -> (usize, Option<usize>) {
        self.1.size_hint()
    }
}

#[cfg(test)]
mod tests {
    use crate::MessageBus;

    #[test]
    fn subscriber_should_receive_msg() {
        let msg = "Test".to_string();
        let bus = MessageBus::new();
        let subscriber = bus.subscribe();
        bus.send(msg.clone());

        let result = subscriber.read();

        assert_eq!(Some(msg), result);
    }

    #[test]
    fn multiple_subscribers_should_receive_msg() {
        let msg = "Test".to_string();
        let bus = MessageBus::new();
        let subscriber1 = bus.subscribe();
        let subscriber2 = bus.subscribe();
        bus.send(msg.clone());

        let result1 = subscriber1.read();
        let result2 = subscriber2.read();

        assert_eq!(Some(msg.clone()), result1);
        assert_eq!(Some(msg), result2);
    }

    #[test]
    fn read_should_return_none_when_no_messages_left() {
        let msg = "Test".to_string();
        let bus = MessageBus::new();
        let subscriber = bus.subscribe();
        bus.send(msg);
        subscriber.read();

        let result = subscriber.read();

        assert_eq!(None, result);
    }
}
