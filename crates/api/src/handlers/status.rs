use mizer_message_bus::Subscriber;
use mizer_status_bus::{StatusBus, StatusMessage};

#[derive(Clone)]
pub struct StatusHandler {
    bus: StatusBus,
}

impl StatusHandler {
    pub fn new(status_bus: StatusBus) -> Self {
        Self { bus: status_bus }
    }

    pub fn get_fps_counter(&self) -> Subscriber<f64> {
        self.bus.subscribe_fps()
    }

    pub fn observe_status_messages(&self) -> Subscriber<Option<StatusMessage>> {
        self.bus.subscribe_status_messages()
    }
}
