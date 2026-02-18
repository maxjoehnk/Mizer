use std::net::Ipv4Addr;
use std::sync::Arc;
use derive_more::From;

use mizer_devices::*;
pub use mizer_connection_contracts::*;
pub use mizer_g13::G13Ref;
pub use mizer_gamepads::*;
pub use mizer_protocol_citp::{CitpKind, CitpModule, CitpConnectionHandle};
pub use mizer_protocol_dmx::{ArtnetOutput, DmxOutput, SacnOutput};
pub use mizer_protocol_laser::{EtherDreamLaser, HeliosLaser};
pub use mizer_protocol_midi::{MidiEvent, MidiMessage};
pub use mizer_protocol_mqtt::{MqttConnectionExt, MqttSubscription, MqttOutput, MqttConnection};
pub use mizer_protocol_osc::{OscMessage, OscType};
pub use mizer_protocol_osc::{OscConnection, OscOutput, OscSubscription, OscColor, OscConnectionExt};
pub use mizer_protocol_pro_dj_link::{CDJView, DJMView, ProDjLinkExt};
pub use mizer_ndi::{NdiSourceRef, NdiSource};
pub use mizer_traktor_kontrol_x1::TraktorX1Ref;
pub use mizer_webcams::*;
pub use crate::module::ConnectionsModule;

mod module;
mod processor;

pub mod midi_device_profile {
    pub use mizer_protocol_midi::{
        Control, DeviceControl, DeviceProfile, Group, MidiDeviceControl, MidiDeviceProfileRegistry,
        Page,
    };
}

pub trait ConnectionStorageExt {
    fn get_connection_views(&self) -> Vec<ConnectionView>;
}

impl ConnectionStorageExt for ConnectionStorage {
    fn get_connection_views(&self) -> Vec<ConnectionView> {
        let artnet_outputs = self.fetch::<(ConnectionId, Option<Name>, ArtnetOutput)>()
            .into_iter()
            .map(|(id, name, output)| DmxOutputView {
                output_id: id.to_stable().to_string(),
                name: name.cloned().map(Into::into).unwrap_or_else(|| output.name().into()),
                config: DmxOutputConfig::Artnet {
                    host: output.host.clone(),
                    port: output.port,
                },
            })
        .map(ConnectionView::DmxOutput);

        let sacn_outputs = self.fetch::<(ConnectionId, Option<Name>, SacnOutput)>()
            .into_iter()
            .map(|(id, name, output)| DmxOutputView {
                output_id: id.to_stable().to_string(),
                name: name.cloned().map(Into::into).unwrap_or_else(|| output.name().into()),
                config: DmxOutputConfig::Sacn {
                    priority: output.priority
                },
            })
            .map(ConnectionView::DmxOutput);

        let osc_connections = self.fetch::<(ConnectionId, Name, OscConnection)>()
            .into_iter()
            .map(|(id, name, osc)| OscView {
                connection_id: id.to_stable().to_string(),
                name: name.clone().into(),
                input_port: osc.address.input_port,
                output_host: osc.address.output_host.to_string(),
                output_port: osc.address.output_port,
            })
            .map(ConnectionView::Osc);

        let webcams = self.fetch::<(ConnectionId, Option<Name>, WebcamRef)>()
            .into_iter()
            .map(|(id, name, webcam)| WebcamView {
                id: id.to_stable().to_string(),
                name: name.cloned().map(Into::into).unwrap_or_else(|| webcam.name().into()),
            })
            .map(ConnectionView::Webcam);

        let citp_connections = self.fetch::<(ConnectionId, Option<Name>, CitpConnectionHandle)>()
            .into_iter()
            .map(|(id, name, citp)| CitpView {
                connection_id: id.to_stable(),
                name: name.cloned().map(Into::into).unwrap_or_else(|| citp.name.to_string().into()),
                kind: citp.kind,
                state: citp.state.clone(),
            })
            .map(ConnectionView::Citp);

        let ether_dream_connections = self.fetch::<(ConnectionId, Name, Has<EtherDreamLaser>)>()
            .into_iter()
            .map(|(id, name)| {
                EtherDreamView {
                    id: id.to_stable().to_string(),
                    name: name.clone().into()
                }
            })
            .map(ConnectionView::EtherDream);

        let helios_connections = self.fetch::<(ConnectionId, Name, HeliosLaser)>()
            .into_iter()
            .map(|(id, name, laser)| {
                HeliosView {
                    id: id.to_stable().to_string(),
                    name: name.clone().into(),
                    firmware: laser.firmware,
                }
            })
            .map(ConnectionView::Helios);

        let mqtt_connections = self.fetch::<(ConnectionId, Name, MqttConnection)>()
            .into_iter()
            .map(|(id, name, connection)| MqttView {
                connection_id: id.to_stable().to_string(),
                name: name.clone().into(),
                url: connection.address.url.to_string(),
                username: connection.address.username.clone(),
                password: connection.address.password.clone(),
            })
            .map(ConnectionView::Mqtt);

        let g13_connections = self.fetch::<(ConnectionId, Has<G13Ref>)>()
            .into_iter()
            .map(|id| G13View {
                id: id.to_stable().to_string(),
            })
            .map(ConnectionView::G13);

        let gamepad_connections = self.fetch::<(ConnectionId, Name, GamepadRef)>()
            .into_iter()
            .map(|(id, name, gamepad)| GamepadView {
                id: id.to_stable().to_string(),
                name: name.clone().into(),
                state: gamepad.state(),
            })
            .map(ConnectionView::Gamepad);

        let ndi_connections = self.fetch::<(ConnectionId, Name, Has<NdiSourceRef>)>()
            .into_iter()
            .map(|(id, name)| NdiSourceView {
                id: id.to_stable().to_string(),
                name: name.clone().into()
            })
            .map(ConnectionView::NdiSource);

        let cdj_connections = self.fetch::<(ConnectionId, CDJView)>()
            .into_iter()
            .map(|(id, cdj)| {
                ConnectionView::Cdj {
                    id: id.to_stable().to_string(),
                    state: cdj.clone(),
                }
            });

        let djm_connections = self.fetch::<(ConnectionId, DJMView)>()
            .into_iter()
            .map(|(id, djm)| {
                ConnectionView::Djm {
                    id: id.to_stable().to_string(),
                    state: djm.clone(),
                }
            });

        let x1_connections = self.fetch::<(ConnectionId, Has<TraktorX1Ref>)>()
            .into_iter()
            .map(|id| ConnectionView::TraktorKontrolX1(TraktorKontrolX1View {
                id: id.to_stable().to_string(),
            }));

        artnet_outputs
            .chain(sacn_outputs)
            .chain(osc_connections)
            .chain(citp_connections)
            .chain(webcams)
            .chain(ether_dream_connections)
            .chain(helios_connections)
            .chain(mqtt_connections)
            .chain(g13_connections)
            .chain(gamepad_connections)
            .chain(ndi_connections)
            .chain(cdj_connections)
            .chain(djm_connections)
            .chain(x1_connections)
            .collect()
    }
}

#[derive(From, Debug, Clone)]
pub enum ConnectionView {
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
    Cdj { id: String, state: CDJView },
    Djm { id: String, state: DJMView },
    Citp(CitpView),
}

impl ConnectionView {
    pub fn id(&self) -> String {
        match self {
            ConnectionView::DmxOutput(c) => c.output_id.clone(),
            ConnectionView::DmxInput(c) => c.input_id.clone(),
            ConnectionView::Osc(o) => o.connection_id.clone(),
            ConnectionView::Webcam(o) => o.id.clone(),
            ConnectionView::Helios(c) => c.id.clone(),
            ConnectionView::EtherDream(c) => c.id.clone(),
            ConnectionView::G13(c) => c.id.clone(),
            ConnectionView::TraktorKontrolX1(c) => c.id.clone(),
            ConnectionView::NdiSource(c) => c.id.clone(),
            ConnectionView::Gamepad(c) => c.id.clone(),
            ConnectionView::Mqtt(c) => c.connection_id.clone(),
            ConnectionView::Citp(c) => c.connection_id.to_string(),
            ConnectionView::Cdj { id, .. } => id.clone(),
            ConnectionView::Djm { id, .. } => id.clone(),
            // TODO
            ConnectionView::Midi(device) => Default::default(),
        }
    }

    pub fn name(&self) -> Arc<String> {
        match self {
            ConnectionView::Midi(device) => device.name.clone().into(),
            ConnectionView::DmxOutput(device) => device.name.clone(),
            ConnectionView::DmxInput(device) => device.name.clone(),
            ConnectionView::Helios(device) => device.name.clone(),
            ConnectionView::EtherDream(device) => device.name.clone(),
            ConnectionView::Gamepad(device) => device.name.clone(),
            ConnectionView::Mqtt(connection) => connection.name.clone(),
            ConnectionView::Osc(connection) => connection.name.clone(),
            ConnectionView::G13(_) => "Logitech G13".to_string().into(),
            ConnectionView::TraktorKontrolX1 { .. } => "Traktor Kontrol X1".to_string().into(),
            ConnectionView::Webcam(connection) => connection.name.clone(),
            ConnectionView::NdiSource(connection) => connection.name.clone(),
            ConnectionView::Cdj { state: cdj, .. } => cdj.device.name.clone().into(),
            ConnectionView::Djm { state: djm, .. } => djm.device.name.clone().into(),
            ConnectionView::Citp(citp) => citp.name.clone(),
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
    pub name: Arc<String>,
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
    pub name: Arc<String>,
    pub input_id: String,
    pub config: DmxInputConfig,
}

#[derive(Debug, Clone)]
pub enum DmxInputConfig {
    Artnet { host: Ipv4Addr, port: u16 },
}

#[derive(Debug, Clone)]
pub struct MqttView {
    pub name: Arc<String>,
    pub connection_id: String,
    pub url: String,
    pub username: Option<String>,
    pub password: Option<String>,
}

#[derive(Debug, Clone)]
pub struct OscView {
    pub name: Arc<String>,
    pub connection_id: String,
    pub output_host: String,
    pub output_port: u16,
    pub input_port: u16,
}

#[derive(Debug, Clone)]
pub struct CitpView {
    pub name: Arc<String>,
    pub connection_id: StableConnectionId,
    pub kind: CitpKind,
    pub state: String,
}
