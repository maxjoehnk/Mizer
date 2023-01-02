use mizer_message_bus::Subscriber;
use rosc::OscMessage;

pub struct OscSubscription {
    pub(crate) connection_id: String,
    pub(crate) subscriber: Subscriber<OscMessage>,
}

impl OscSubscription {
    pub fn connection_id(&self) -> &str {
        &self.connection_id
    }

    pub fn next_event(&self, path: &str) -> Option<OscMessage> {
        loop {
            match self.subscriber.read() {
                None => return None,
                Some(msg) if msg.addr == path => return Some(msg),
                _ => (),
            }
        }
    }

    pub fn events(self) -> Subscriber<OscMessage> {
        self.subscriber
    }
}
