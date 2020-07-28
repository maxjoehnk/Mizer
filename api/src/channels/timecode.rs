use crate::deps::{Receiver, Sender, channel, TryRecvError};
use super::GenericSender;

#[derive(Debug, Clone, Copy)]
pub struct Timecode {
    pub hour: u8,
    pub minute: u8,
    pub second: u8,
    pub frame: u8
}

#[derive(Debug, Clone)]
pub struct TimecodeChannel {
    pub framerate: u8,
    pub receiver: Receiver<Timecode>
}
pub type TimecodeSender = GenericSender<Timecode>;

impl TimecodeChannel {
    pub fn new() -> (TimecodeSender, Self) {
        let (tx, rx) = channel();
        (tx.into(), TimecodeChannel { framerate: 60, receiver: rx })
    }

    pub fn recv(&self) -> Result<Option<Timecode>, TryRecvError> {
        match self.receiver.try_recv() {
            Ok(value) => Ok(Some(value)),
            Err(TryRecvError::Empty) => Ok(None),
            Err(err) => Err(err),
        }
    }
}
