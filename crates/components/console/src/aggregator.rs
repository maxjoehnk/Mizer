use std::sync::Arc;
use futures::StreamExt;
use parking_lot::RwLock;
use mizer_message_bus::MessageBus;
use crate::{ConsoleHistory, ConsoleMessage};
use crate::bus::{ConsoleBus, init_bus};

pub struct ConsoleAggregator {
    receiver: flume::Receiver<ConsoleMessage>,
    bus: MessageBus<ConsoleMessage>,
    buffer: Arc<RwLock<Vec<ConsoleMessage>>>,
}

impl ConsoleAggregator {
    pub(crate) fn init() -> anyhow::Result<(Self, ConsoleHistory)> {
        let (tx, rx) = flume::unbounded();
        init_bus(ConsoleBus::new(tx))?;
        let message_bus = MessageBus::new();
        message_bus.set_keep_last_event(false);
        let buffer = Arc::new(RwLock::new(Vec::new()));

        let aggregator = Self {
            receiver: rx,
            bus: message_bus.clone(),
            buffer: buffer.clone(),
        };
        let history = ConsoleHistory {
            bus: message_bus,
            buffer,
        };

        Ok((aggregator, history))
    }

    pub(crate) async fn distribute(self) {
        let mut stream = self.receiver.into_stream();
        while let Some(msg) = stream.next().await {
            self.bus.send(msg.clone());
            let mut buffer = self.buffer.write();
            buffer.push(msg);
        }
    }
}
