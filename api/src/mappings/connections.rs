use crate::models::*;
use protobuf::EnumOrUnknown;

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
                ..Default::default()
            }),
            Dmx(view) => Self::Dmx(DmxConnection {
                outputId: view.output_id.clone(),
                config: Some(match view.config {
                    mizer_connections::DmxConfig::Artnet { host, port } => {
                        dmx_connection::Config::Artnet(ArtnetConfig {
                            name: view.output_id,
                            host,
                            port: port as u32,
                            ..Default::default()
                        })
                    }
                    mizer_connections::DmxConfig::Sacn => {
                        dmx_connection::Config::Sacn(SacnConfig {
                            name: view.output_id,
                            ..Default::default()
                        })
                    }
                }),
                ..Default::default()
            }),
            Helios(laser) => Self::Helios(HeliosConnection {
                name: laser.name,
                firmware: laser.firmware,
                ..Default::default()
            }),
            EtherDream(laser) => Self::EtherDream(EtherDreamConnection {
                name: laser.name,
                ..Default::default()
            }),
            Gamepad(gamepad) => Self::Gamepad(GamepadConnection {
                id: gamepad.id,
                name: gamepad.name,
                ..Default::default()
            }),
            Mqtt(mqtt) => Self::Mqtt(MqttConnection {
                connectionId: mqtt.connection_id,
                url: mqtt.url,
                username: mqtt.username,
                password: mqtt.password,
                ..Default::default()
            }),
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
            mizer_connections::DmxConfig::Sacn => Self::Sacn(SacnConfig::default()),
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
            channel: control.channel as u32,
            note: control.note as u32,
            control_type: EnumOrUnknown::new(control.control_type.into()),
            has_output: control.has_output,
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::ControlType>
    for midi_device_profile::ControlType
{
    fn from(control_type: mizer_connections::midi_device_profile::ControlType) -> Self {
        use mizer_connections::midi_device_profile::ControlType::*;

        match control_type {
            ControlChange => Self::CC,
            Note => Self::Note,
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
