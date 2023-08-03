use crate::proto::connections::*;

impl From<mizer_connections::Connection> for Connection {
    fn from(connection: mizer_connections::Connection) -> Self {
        Self {
            name: connection.name(),
            connection: Some(connection.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::Connection> for connection::Connection {
    fn from(connection: mizer_connections::Connection) -> Self {
        use mizer_connections::Connection::*;
        match connection {
            Midi(midi) => Self::Midi(MidiConnection {
                device_profile: midi.device_profile,
            }),
            Dmx(view) => Self::Dmx(DmxConnection {
                output_id: view.output_id.clone(),
                config: Some(match view.config {
                    mizer_connections::DmxConfig::Artnet { host, port } => {
                        dmx_connection::Config::Artnet(ArtnetConfig {
                            name: view.output_id,
                            host,
                            port: port as u32,
                        })
                    }
                    mizer_connections::DmxConfig::Sacn { priority } => {
                        dmx_connection::Config::Sacn(SacnConfig {
                            name: view.output_id,
                            priority: priority as u32,
                        })
                    }
                }),
            }),
            Helios(laser) => Self::Helios(HeliosConnection {
                name: laser.name,
                firmware: laser.firmware,
            }),
            EtherDream(laser) => Self::EtherDream(EtherDreamConnection { name: laser.name }),
            Gamepad(gamepad) => Self::Gamepad(GamepadConnection {
                id: gamepad.id,
                name: gamepad.name,
            }),
            Mqtt(mqtt) => Self::Mqtt(MqttConnection {
                connection_id: mqtt.connection_id,
                url: mqtt.url,
                username: mqtt.username,
                password: mqtt.password,
            }),
            Osc(osc) => Self::Osc(OscConnection {
                connection_id: osc.connection_id,
                output_address: osc.output_host,
                output_port: osc.output_port as u32,
                input_port: osc.input_port as u32,
            }),
            G13(g13) => Self::G13(G13Connection { id: g13.id }),
            Webcam(webcam) => Self::Webcam(WebcamConnection {
                id: webcam.id,
                name: webcam.name,
            }),
            Cdj(cdj) => Self::Cdj(cdj.into()),
            Djm(djm) => Self::Djm(djm.into()),
        }
    }
}

impl From<mizer_connections::CDJView> for PioneerCdjConnection {
    fn from(cdj: mizer_connections::CDJView) -> Self {
        Self {
            id: cdj.id(),
            playback: Some(CdjPlayback {
                frame: cdj.beat as u32,
                bpm: cdj.current_bpm(),
                live: cdj.is_live(),
                playback: (if cdj.is_playing() {
                    cdj_playback::State::Playing
                } else {
                    cdj_playback::State::Cued
                }) as i32,
                track: None,
            }),
            address: cdj.device.ip_addr.to_string(),
            model: cdj.device.name,
            player_number: cdj.device.device_id as u32,
        }
    }
}

impl From<mizer_connections::DJMView> for PioneerDjmConnection {
    fn from(djm: mizer_connections::DJMView) -> Self {
        Self {
            id: djm.id(),
            address: djm.device.ip_addr.to_string(),
            model: djm.device.name,
            player_number: djm.device.device_id as u32,
            ..Default::default()
        }
    }
}

impl From<mizer_connections::DmxConfig> for dmx_connection::Config {
    fn from(config: mizer_connections::DmxConfig) -> Self {
        match config {
            mizer_connections::DmxConfig::Artnet { host, port } => Self::Artnet(ArtnetConfig {
                host,
                port: port as u32,
                ..Default::default()
            }),
            mizer_connections::DmxConfig::Sacn { priority } => Self::Sacn(SacnConfig {
                priority: priority as u32,
                ..Default::default()
            }),
        }
    }
}

impl From<mizer_connections::midi_device_profile::DeviceProfile> for MidiDeviceProfile {
    fn from(device_profile: mizer_connections::midi_device_profile::DeviceProfile) -> Self {
        Self {
            id: device_profile.id,
            manufacturer: device_profile.manufacturer,
            model: device_profile.name,
            pages: device_profile
                .pages
                .into_iter()
                .map(midi_device_profile::Page::from)
                .collect(),
            layout: device_profile.layout,
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::Page> for midi_device_profile::Page {
    fn from(page: mizer_connections::midi_device_profile::Page) -> Self {
        Self {
            name: page.name,
            controls: page
                .controls
                .into_iter()
                .map(midi_device_profile::Control::from)
                .collect(),
            groups: page
                .groups
                .into_iter()
                .map(midi_device_profile::Group::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::Group> for midi_device_profile::Group {
    fn from(page: mizer_connections::midi_device_profile::Group) -> Self {
        Self {
            name: page.name,
            controls: page
                .controls
                .into_iter()
                .map(midi_device_profile::Control::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::Control> for midi_device_profile::Control {
    fn from(control: mizer_connections::midi_device_profile::Control) -> Self {
        Self {
            name: control.name,
            id: control.id,
            has_input: control.input.is_some(),
            has_output: control.output.is_some(),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::MidiEvent> for MonitorMidiResponse {
    fn from(event: mizer_connections::MidiEvent) -> Self {
        MonitorMidiResponse {
            timestamp: event.timestamp,
            message: Some(event.msg.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::OscMessage> for MonitorOscResponse {
    fn from(event: mizer_connections::OscMessage) -> Self {
        Self {
            path: event.addr,
            args: event
                .args
                .into_iter()
                .map(monitor_osc_response::OscArgument::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::OscType> for monitor_osc_response::OscArgument {
    fn from(osc_type: mizer_connections::OscType) -> Self {
        use mizer_connections::OscType::*;
        use monitor_osc_response::osc_argument::*;

        let argument = match osc_type {
            Int(int) => Some(Argument::Int(int)),
            Long(int) => Some(Argument::Long(int)),
            Bool(value) => Some(Argument::Bool(value)),
            Float(value) => Some(Argument::Float(value)),
            Double(value) => Some(Argument::Double(value)),
            Color(value) => Some(Argument::Color(OscColor {
                red: value.red as u32,
                green: value.green as u32,
                blue: value.blue as u32,
                alpha: value.alpha as u32,
                ..Default::default()
            })),
            _ => None,
        };

        Self {
            argument,
            ..Default::default()
        }
    }
}

impl From<mizer_connections::MidiMessage> for monitor_midi_response::Message {
    fn from(msg: mizer_connections::MidiMessage) -> Self {
        use mizer_connections::MidiMessage::*;
        match msg {
            ControlChange(channel, note, value) => Self::Cc(monitor_midi_response::NoteMsg {
                channel: channel as u8 as u32,
                note: note as u32,
                value: value as u32,
                ..Default::default()
            }),
            NoteOff(channel, note, value) => Self::NoteOff(monitor_midi_response::NoteMsg {
                channel: channel as u8 as u32,
                note: note as u32,
                value: value as u32,
                ..Default::default()
            }),
            NoteOn(channel, note, value) => Self::NoteOn(monitor_midi_response::NoteMsg {
                channel: channel as u8 as u32,
                note: note as u32,
                value: value as u32,
                ..Default::default()
            }),
            Sysex((manu1, manu2, manu3), model, data) => {
                Self::SysEx(monitor_midi_response::SysEx {
                    manufacturer1: manu1 as u32,
                    manufacturer2: manu2 as u32,
                    manufacturer3: manu3 as u32,
                    model: model as u32,
                    data,
                    ..Default::default()
                })
            }
            Unknown(data) => Self::Unknown(data),
        }
    }
}
