use std::fmt::{Display, Formatter};
use std::time::Duration;

use chrono::Utc;
use serde::{Deserialize, Serialize};

use mizer_message_bus::{MessageBus, Subscriber};

#[derive(Clone, Default)]
pub struct StatusBus {
    fps_bus: MessageBus<f64>,
    status_message_bus: MessageBus<Option<StatusMessage>>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct StatusMessage {
    pub message: String,
    pub timeout: Option<Duration>,
    pub created_at: chrono::DateTime<Utc>,
}

impl Display for StatusMessage {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{} - {}",
            self.created_at.time().format("%H:%M").to_string(),
            self.message
        )
    }
}

impl StatusBus {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add_status_message(&self, message: impl Into<String>, timeout: Option<Duration>) {
        // TODO: implement timeout
        let message = message.into();
        let created_at = Utc::now();
        let message = StatusMessage {
            message,
            timeout,
            created_at,
        };
        self.status_message_bus.send(Some(message));
    }

    pub fn send_fps(&self, fps: f64) {
        self.fps_bus.send(fps);
    }

    pub fn subscribe_fps(&self) -> Subscriber<f64> {
        self.fps_bus.subscribe()
    }

    pub fn subscribe_status_messages(&self) -> Subscriber<Option<StatusMessage>> {
        self.status_message_bus.subscribe()
    }
}
