use derive_more::From;
use mizer_devices::*;

pub mod midi_device_profile {
    pub use mizer_protocol_midi::{
        Control, DeviceControl, DeviceProfile, Group, MidiDeviceControl, Page,
    };
}

pub use mizer_protocol_midi::{MidiEvent, MidiMessage};
pub use mizer_protocol_osc::{OscMessage, OscType};

#[derive(From, Debug, Clone)]
pub enum Connection {
    Midi(MidiView),
    Dmx(DmxView),
    Helios(HeliosView),
    EtherDream(EtherDreamView),
    Gamepad(GamepadView),
    Mqtt(MqttView),
    Osc(OscView),
    G13(G13View),
}

impl Connection {
    pub fn name(&self) -> String {
        match self {
            Connection::Midi(device) => device.name.clone(),
            Connection::Dmx(device) => device.name.clone(),
            Connection::Helios(device) => device.name.clone(),
            Connection::EtherDream(device) => device.name.clone(),
            Connection::Gamepad(device) => device.name.clone(),
            Connection::Mqtt(connection) => connection.name.clone(),
            Connection::Osc(connection) => connection.name.clone(),
            Connection::G13(_) => "Logitech G13".to_string(),
        }
    }
}

impl From<DeviceRef> for Connection {
    fn from(device: DeviceRef) -> Self {
        match device {
            DeviceRef::Helios(view) => view.into(),
            DeviceRef::EtherDream(view) => view.into(),
            DeviceRef::Gamepad(view) => view.into(),
            DeviceRef::G13(view) => view.into(),
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

#[derive(Debug, Clone)]
pub struct MqttView {
    pub name: String,
    pub connection_id: String,
    pub url: String,
    pub username: Option<String>,
    pub password: Option<String>,
}

#[derive(Debug, Clone)]
pub struct OscView {
    pub name: String,
    pub connection_id: String,
    pub output_host: String,
    pub output_port: u16,
    pub input_port: u16,
}
