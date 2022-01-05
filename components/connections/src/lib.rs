use derive_more::From;

pub mod midi_device_profile {
    pub use mizer_protocol_midi::{Control, ControlType, DeviceProfile, Group, Page};
}

pub use mizer_protocol_midi::{MidiEvent, MidiMessage};

#[derive(From, Debug, Clone)]
pub enum Connection {
    Midi(MidiView),
    Dmx(DmxView),
}

impl Connection {
    pub fn name(&self) -> String {
        match self {
            Connection::Midi(device) => device.name.clone(),
            Connection::Dmx(device) => device.name.clone(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MidiView {
    pub name: String,
    pub device_profile: Option<String>,
}

#[derive(Debug, Clone)]
pub struct DmxView {
    pub name: String,
    pub output_id: String,
}
