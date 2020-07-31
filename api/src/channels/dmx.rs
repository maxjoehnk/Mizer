use crate::deps::{Receiver, channel as new_channel, TryRecvError};
use crate::GenericSender;

#[derive(Debug, Clone)]
pub struct DmxChannel {
    pub channel: u8,
    pub universe: u16,
    pub receiver: Receiver<u8>
}
pub type DmxSender = GenericSender<u8>;

impl DmxChannel {
    pub fn new(universe: u16, channel: u8) -> (DmxSender, Self) {
        let (tx, rx) = new_channel();
        let channel = DmxChannel {
            channel,
            universe,
            receiver: rx,
        };
        (tx.into(), channel)
    }

    pub fn recv(&self) -> Result<Option<u8>, TryRecvError> {
        match self.receiver.try_recv() {
            Ok(value) => Ok(Some(value)),
            Err(TryRecvError::Empty) => Ok(None),
            Err(err) => Err(err),
        }
    }
}
