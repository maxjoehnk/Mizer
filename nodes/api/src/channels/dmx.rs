use crate::deps::{Receiver, channel as new_channel, TryRecvError};
use crate::{GenericSender, GenericChannel};
use std::collections::HashMap;

#[derive(Debug, Clone)]
pub enum DmxChannel {
    Single {
        channel: u16,
        universe: u16,
        receiver: Receiver<u8>
    },
    Batch {
        universes: HashMap<u16, GenericChannel<Vec<u8>>>
    }
}

pub type SingleDmxSender = GenericSender<u8>;
pub type BatchedDmxSender = Vec<GenericSender<Vec<u8>>>;

impl DmxChannel {
    pub fn single(universe: u16, channel: u16) -> (SingleDmxSender, Self) {
        let (tx, rx) = new_channel();
        let channel = DmxChannel::Single {
            channel,
            universe,
            receiver: rx,
        };
        (tx.into(), channel)
    }

    pub fn batched(start_universe: u16, universe_count: u16) -> (BatchedDmxSender, Self) {
        let mut senders = Vec::new();
        let mut universes = HashMap::new();
        for i in 0..universe_count {
            let (tx, rx) = GenericChannel::new();
            senders.push(tx);
            universes.insert(start_universe + i, rx);
        }
        let channel = DmxChannel::Batch {
            universes
        };
        (senders, channel)
    }

    pub fn recv(&self) -> Result<Option<HashMap<u16, Vec<Option<u8>>>>, TryRecvError> {
        match self {
            DmxChannel::Single {
                receiver,
                universe,
                channel
            } => {
                let mut result = HashMap::new();
                let mut channels = Vec::new();
                for i in 0..512 {
                    if *channel - 1 == i {
                        channels.push(receiver.try_recv().ok());
                    }else {
                        channels.push(None);
                    }
                }
                result.insert(*universe, channels);
                Ok(Some(result))
            },
            DmxChannel::Batch {
                universes
            } => {
                let mut result = HashMap::new();
                for (universe, channel) in universes {
                    let channels = channel.recv_last()?;
                    if let Some(channels) = channels {
                        let channels = channels.into_iter()
                            .map(Option::Some)
                            .collect();
                        result.insert(*universe, channels);
                    }else {
                        continue
                    }

                }
                if universes.is_empty() {
                    Ok(None)
                } else {
                    Ok(Some(result))
                }
            }
        }
        // match self.receiver.try_recv() {
        //     Ok(value) => Ok(Some(value)),
        //     Err(TryRecvError::Empty) => Ok(None),
        //     Err(err) => Err(err),
        // }
    }
}
