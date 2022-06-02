use derive_more::From;
use mizer_devices::*;

pub mod midi_device_profile {
    pub use mizer_protocol_midi::{Control, ControlType, DeviceProfile, Group, Page};
}

pub use mizer_protocol_midi::{MidiEvent, MidiMessage};

#[derive(From, Debug, Clone)]
pub enum Connection {
    Midi(MidiView),
    Dmx(DmxView),
    Helios(HeliosView),
    EtherDream(EtherDreamView),
    Gamepad(GamepadView),
}

impl Connection {
    pub fn name(&self) -> String {
        match self {
            Connection::Midi(device) => device.name.clone(),
            Connection::Dmx(device) => device.name.clone(),
            Connection::Helios(device) => device.name.clone(),
            Connection::EtherDream(device) => device.name.clone(),
            Connection::Gamepad(device) => device.name.clone(),
        }
    }
}

impl From<DeviceRef> for Connection {
    fn from(device: DeviceRef) -> Self {
        match device {
            DeviceRef::Helios(view) => view.into(),
            DeviceRef::EtherDream(view) => view.into(),
            DeviceRef::Gamepad(view) => view.into(),
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
    pub config: DmxConfig,
}

#[derive(Debug, Clone)]
pub enum DmxConfig {
    Artnet { host: String, port: u16 },
    Sacn,
}
