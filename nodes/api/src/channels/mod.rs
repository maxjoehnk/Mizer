mod clock;
mod color;
mod dmx;
mod numeric;
mod pixels;
mod timecode;
mod trigger;

pub use self::clock::*;
pub use self::color::*;
pub use self::dmx::*;
pub use self::numeric::*;
pub use self::pixels::*;
pub use self::timecode::*;
pub use self::trigger::*;

#[derive(Debug, Clone)]
pub struct GenericChannel<T> {
    pub receiver: crate::deps::Receiver<T>,
}

pub struct GenericSender<T>(crate::deps::Sender<T>);

impl<T> GenericSender<T> {
    pub fn send(&self, msg: T) {
        self.0.send(msg);
    }
}

impl<T> From<crate::deps::Sender<T>> for GenericSender<T> {
    fn from(sender: crate::deps::Sender<T>) -> Self {
        GenericSender(sender)
    }
}

impl<T> GenericChannel<T> {
    pub fn new() -> (GenericSender<T>, Self) {
        let (tx, rx) = crate::deps::channel();
        (tx.into(), GenericChannel { receiver: rx })
    }

    pub fn recv(&self) -> Result<Option<T>, crate::deps::TryRecvError> {
        match self.receiver.try_recv() {
            Ok(value) => Ok(Some(value)),
            Err(crate::deps::TryRecvError::Empty) => Ok(None),
            Err(err) => Err(err),
        }
    }

    pub fn recv_all(&self) -> Result<Vec<T>, crate::deps::TryRecvError> {
        let mut events = Vec::new();
        while let Some(event) = self.recv()? {
            events.push(event);
        }
        Ok(events)
    }

    pub fn recv_last(&self) -> Result<Option<T>, crate::deps::TryRecvError> {
        let events = self.recv_all()?;
        Ok(events.into_iter().last())
    }
}
