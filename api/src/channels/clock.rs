use crate::deps::{Receiver, Sender, channel, TryRecvError};
use super::{GenericChannel, GenericSender};

#[derive(Debug, Copy, Clone)]
pub struct ClockBeat {
    pub delta: f64,
    pub downbeat: bool,
}

pub type ClockChannel = GenericChannel<ClockBeat>;
pub type ClockSender = GenericSender<ClockBeat>;
