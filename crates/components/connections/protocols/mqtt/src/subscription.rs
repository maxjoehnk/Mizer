use crate::connections::MqttEvent;
use mizer_message_bus::Subscriber;

pub struct MqttSubscription {
    pub(crate) connection_id: String,
    pub(crate) path: String,
    pub(crate) subscriber: Subscriber<MqttEvent>,
}

impl MqttSubscription {
    pub fn connection_id(&self) -> &str {
        &self.connection_id
    }

    pub fn path(&self) -> &str {
        &self.path
    }

    pub fn next_event(&self) -> Option<MqttEvent> {
        loop {
            match self.subscriber.read() {
                None => return None,
                Some(event) if event.topic == self.path => return Some(event),
                _ => (),
            }
        }
    }
}
