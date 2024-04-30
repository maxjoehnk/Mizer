use std::sync::OnceLock;
use crate::{ConsoleCategory, ConsoleLevel, ConsoleMessage};

static BUS: OnceLock<ConsoleBus> = OnceLock::new();

pub(crate) fn get_bus() -> &'static ConsoleBus {
    BUS.get().unwrap()
}

pub(crate) fn init_bus(bus: ConsoleBus) -> anyhow::Result<()> {
    BUS.set(bus)
        .map_err(|_| anyhow::anyhow!("Unable to setup console bus"))
}

pub struct ConsoleBus {
    sender: flume::Sender<ConsoleMessage>,
}

impl ConsoleBus {
    pub(crate) fn new(sender: flume::Sender<ConsoleMessage>) -> Self {
        Self { sender }
    }

    pub(crate) fn log(&self, level: ConsoleLevel, category: ConsoleCategory, message: String) {
        let timestamp = chrono::Utc::now().timestamp_millis() as u64;
        if let Err(err) = self.sender.send(ConsoleMessage {
            level,
            message,
            category,
            timestamp,
        }) {
            tracing::error!("Unable to send message to console bus: {err:?}");
        }
    }
}
