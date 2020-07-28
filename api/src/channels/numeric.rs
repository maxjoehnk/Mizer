use crate::deps::{Receiver, Sender, channel, TryRecvError};
use super::{GenericChannel, GenericSender};

pub type NumericChannel = GenericChannel<f64>;
pub type NumericSender = GenericSender<f64>;
