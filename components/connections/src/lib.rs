use derive_more::From;
use mizer_protocol_midi::MidiDevice;

#[derive(From, Debug, Clone)]
pub enum Connection {
    Midi(MidiView),
}

impl Connection {
    pub fn name(&self) -> String {
        match self {
            Connection::Midi(device) => device.name.clone(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MidiView {
    pub name: String
}
