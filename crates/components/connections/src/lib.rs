use std::net::Ipv4Addr;

use derive_more::From;

use mizer_devices::*;
use mizer_protocol_citp::CitpConnectionId;
pub use mizer_protocol_citp::CitpKind;
pub use mizer_protocol_midi::{MidiEvent, MidiMessage};
pub use mizer_protocol_osc::{OscMessage, OscType};
pub use mizer_protocol_pro_dj_link::{CDJView, DJMView};

pub mod midi_device_profile {
    pub use mizer_protocol_midi::{
        Control, DeviceControl, DeviceProfile, Group, MidiDeviceControl, MidiDeviceProfileRegistry,
        Page,
    };
}

#[derive(From, Debug, Clone)]
pub enum Connection {
    Midi(MidiView),
    DmxOutput(DmxOutputView),
    DmxInput(DmxInputView),
    Helios(HeliosView),
    EtherDream(EtherDreamView),
    Gamepad(GamepadView),
    Mqtt(MqttView),
    Osc(OscView),
    G13(G13View),
    TraktorKontrolX1(TraktorKontrolX1View),
    Webcam(WebcamView),
    NdiSource(NdiSourceView),
    Cdj(CDJView),
    Djm(DJMView),
    Citp(CitpView),
}

impl Connection {
    pub fn name(&self) -> String {
        match self {
            Connection::Midi(device) => device.name.clone(),
            Connection::DmxOutput(device) => device.name.clone(),
            Connection::DmxInput(device) => device.name.clone(),
            Connection::Helios(device) => device.name.clone(),
            Connection::EtherDream(device) => device.name.clone(),
            Connection::Gamepad(device) => device.name.clone(),
            Connection::Mqtt(connection) => connection.name.clone(),
            Connection::Osc(connection) => connection.name.clone(),
            Connection::G13(_) => "Logitech G13".to_string(),
            Connection::TraktorKontrolX1(_) => "Traktor Kontrol X1".to_string(),
            Connection::Webcam(connection) => connection.name.clone(),
            Connection::NdiSource(connection) => connection.name.clone(),
            Connection::Cdj(cdj) => cdj.device.name.clone(),
            Connection::Djm(djm) => djm.device.name.clone(),
            Connection::Citp(citp) => citp.name.clone(),
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
            DeviceRef::TraktorKontrolX1(view) => view.into(),
            DeviceRef::Webcam(view) => view.into(),
            DeviceRef::NdiSource(view) => view.into(),
            DeviceRef::PioneerCDJ(view) => view.into(),
            DeviceRef::PioneerDJM(view) => view.into(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MidiView {
    pub name: String,
    pub device_profile: Option<String>,
}

#[derive(Debug, Clone)]
pub struct DmxOutputView {
    pub name: String,
    pub output_id: String,
    pub config: DmxOutputConfig,
}

#[derive(Debug, Clone)]
pub enum DmxOutputConfig {
    Artnet { host: String, port: u16 },
    Sacn { priority: u8 },
}

#[derive(Debug, Clone)]
pub struct DmxInputView {
    pub name: String,
    pub input_id: String,
    pub config: DmxInputConfig,
}

#[derive(Debug, Clone)]
pub enum DmxInputConfig {
    Artnet { host: Ipv4Addr, port: u16 },
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

#[derive(Debug, Clone)]
pub struct CitpView {
    pub name: String,
    pub connection_id: CitpConnectionId,
    pub kind: CitpKind,
    pub state: String,
}
