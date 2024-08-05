use crate::ConsoleMessage;
use mizer_message_bus::{MessageBus, Subscriber};
use parking_lot::RwLock;
use std::sync::Arc;

#[derive(Clone)]
pub struct ConsoleHistory {
    pub(crate) bus: MessageBus<ConsoleMessage>,
    pub(crate) buffer: Arc<RwLock<Vec<ConsoleMessage>>>,
}

impl ConsoleHistory {
    pub fn get_history(&self) -> Vec<ConsoleMessage> {
        self.buffer.read().clone()
    }

    pub fn subscribe(&self) -> Subscriber<ConsoleMessage> {
        self.bus.subscribe()
    }
}
