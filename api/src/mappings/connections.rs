use crate::models::*;

impl From<mizer_connections::Connection> for Connection {
    fn from(connection: mizer_connections::Connection) -> Self {
        Self {
            name: connection.name(),
            connection: Some(connection.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::Connection> for Connection_oneof_connection {
    fn from(connection: mizer_connections::Connection) -> Self {
        use mizer_connections::Connection::*;
        match connection {
            Midi(midi) => Self::midi(MidiConnection {
                _device_profile: midi
                    .device_profile
                    .map(MidiConnection_oneof__device_profile::device_profile),
                ..Default::default()
            }),
            Dmx(view) => Self::dmx(DmxConnection {
                outputId: view.output_id.clone(),
                config: Some(match view.config {
                    mizer_connections::DmxConfig::Artnet { host, port } => {
                        DmxConnection_oneof_config::artnet(ArtnetConfig {
                            name: view.output_id,
                            host,
                            port: port as u32,
                            ..Default::default()
                        })
                    }
                    mizer_connections::DmxConfig::Sacn => {
                        DmxConnection_oneof_config::sacn(SacnConfig {
                            name: view.output_id,
                            ..Default::default()
                        })
                    }
                }),
                ..Default::default()
            }),
            Helios(laser) => Self::helios(HeliosConnection {
                name: laser.name,
                firmware: laser.firmware,
                ..Default::default()
            }),
            EtherDream(laser) => Self::etherDream(EtherDreamConnection {
                name: laser.name,
                ..Default::default()
            }),
            Gamepad(gamepad) => Self::gamepad(GamepadConnection {
                id: gamepad.id,
                name: gamepad.name,
                ..Default::default()
            }),
        }
    }
}

impl From<mizer_connections::DmxConfig> for DmxConnection_oneof_config {
    fn from(config: mizer_connections::DmxConfig) -> Self {
        match config {
            mizer_connections::DmxConfig::Artnet { host, port } => Self::artnet(ArtnetConfig {
                host,
                port: port as u32,
                ..Default::default()
            }),
            mizer_connections::DmxConfig::Sacn => Self::sacn(SacnConfig::default()),
        }
    }
}

impl From<mizer_connections::midi_device_profile::DeviceProfile> for MidiDeviceProfile {
    fn from(device_profile: mizer_connections::midi_device_profile::DeviceProfile) -> Self {
        let mut profile = Self {
            id: device_profile.id,
            manufacturer: device_profile.manufacturer,
            model: device_profile.name,
            pages: device_profile
                .pages
                .into_iter()
                .map(MidiDeviceProfile_Page::from)
                .collect(),
            ..Default::default()
        };
        if let Some(layout) = device_profile.layout {
            profile.set_layout(layout);
        }
        profile
    }
}

impl From<mizer_connections::midi_device_profile::Page> for MidiDeviceProfile_Page {
    fn from(page: mizer_connections::midi_device_profile::Page) -> Self {
        Self {
            name: page.name,
            controls: page
                .controls
                .into_iter()
                .map(MidiDeviceProfile_Control::from)
                .collect(),
            groups: page
                .groups
                .into_iter()
                .map(MidiDeviceProfile_Group::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::Group> for MidiDeviceProfile_Group {
    fn from(page: mizer_connections::midi_device_profile::Group) -> Self {
        Self {
            name: page.name,
            controls: page
                .controls
                .into_iter()
                .map(MidiDeviceProfile_Control::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::Control> for MidiDeviceProfile_Control {
    fn from(control: mizer_connections::midi_device_profile::Control) -> Self {
        Self {
            name: control.name,
            id: control.id,
            channel: control.channel as u32,
            note: control.note as u32,
            control_type: control.control_type.into(),
            has_output: control.has_output,
            ..Default::default()
        }
    }
}

impl From<mizer_connections::midi_device_profile::ControlType> for MidiDeviceProfile_ControlType {
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

impl From<mizer_connections::MidiMessage> for MonitorMidiResponse_oneof_message {
    fn from(msg: mizer_connections::MidiMessage) -> Self {
        use mizer_connections::MidiMessage::*;
        match msg {
            ControlChange(channel, note, value) => Self::cc(MonitorMidiResponse_NoteMsg {
                channel: channel as u8 as u32,
                note: note as u32,
                value: value as u32,
                ..Default::default()
            }),
            NoteOff(channel, note, value) => Self::noteOff(MonitorMidiResponse_NoteMsg {
                channel: channel as u8 as u32,
                note: note as u32,
                value: value as u32,
                ..Default::default()
            }),
            NoteOn(channel, note, value) => Self::noteOn(MonitorMidiResponse_NoteMsg {
                channel: channel as u8 as u32,
                note: note as u32,
                value: value as u32,
                ..Default::default()
            }),
            Sysex((manu1, manu2, manu3), model, data) => Self::sysEx(MonitorMidiResponse_SysEx {
                manufacturer1: manu1 as u32,
                manufacturer2: manu2 as u32,
                manufacturer3: manu3 as u32,
                model: model as u32,
                data,
                ..Default::default()
            }),
            Unknown(data) => Self::unknown(data),
        }
    }
}
