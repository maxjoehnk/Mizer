use std::time::Duration;

use mizer_message_bus::{MessageBus, Subscriber};

#[derive(Clone, Default)]
pub struct StatusBus {
    fps_bus: MessageBus<f64>,
    status_message_bus: MessageBus<Option<String>>,
}

impl StatusBus {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add_status_message(&self, message: impl Into<String>, _timeout: Option<Duration>) {
        // TODO: implement timeout
        self.status_message_bus.send(Some(message.into()));
    }

    pub fn send_fps(&self, fps: f64) {
        self.fps_bus.send(fps);
    }

    pub fn subscribe_fps(&self) -> Subscriber<f64> {
        self.fps_bus.subscribe()
    }

    pub fn subscribe_status_messages(&self) -> Subscriber<Option<String>> {
        self.status_message_bus.subscribe()
    }
}
