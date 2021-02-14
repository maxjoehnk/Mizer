use std::collections::HashMap;
use std::fmt::Debug;
use serde::{Serialize, Deserialize};
use std::ops::Deref;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct NodePortPayload<Item> where Item: Debug + Clone + PartialEq {
    pub channels: HashMap<ChannelId, Item>
}

impl<Item> NodePortPayload<Item> where Item: Debug + Clone + PartialEq {
    pub fn new() -> Self {
        Self {
            channels: Default::default()
        }
    }

    pub fn set_channel<C: Into<ChannelId>>(&mut self, channel: C, value: Item) {
        self.channels.insert(channel.into(), value);
    }
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct NodePortBuffer<Item>(Vec<Item>) where Item: Debug + Clone + PartialEq;

#[derive(Debug, Clone, Hash, PartialEq, Eq, PartialOrd, Ord, Serialize, Deserialize)]
pub struct ChannelId(String);

impl From<String> for ChannelId {
    fn from(id: String) -> Self {
        ChannelId(id)
    }
}

pub trait NodePortReceiver<'a, Item> where Item: Debug + Clone + PartialEq {
    type Guard : ReceiverGuard<Item>;

    fn recv(&'a self) -> Option<Self::Guard>;
}

pub trait ReceiverGuard<Item> : Deref<Target = NodePortPayload<Item>> where Item: Debug + Clone + PartialEq {
}

pub trait NodePortSender<Item> where Item: Debug + Clone + PartialEq {
    fn send(&self, value: NodePortPayload<Item>) -> anyhow::Result<()>;
}

