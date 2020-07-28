use crate::deps::{Receiver, Sender, channel as new_channel, TryRecvError};
use super::{GenericChannel, GenericSender};

pub type TriggerChannel = GenericChannel<()>;
pub type TriggerSender = GenericSender<()>;
