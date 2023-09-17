use mizer_message_bus::{MessageBus, Subscriber};

#[derive(Clone)]
pub struct StatusHandler {
    fps_counter: MessageBus<f64>,
}

impl StatusHandler {
    pub fn new(fps_counter: MessageBus<f64>) -> Self {
        Self { fps_counter }
    }

    pub fn get_fps_counter(&self) -> Subscriber<f64> {
        self.fps_counter.subscribe()
    }
}
