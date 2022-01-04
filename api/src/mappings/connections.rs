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
                _device_profile: midi.device_profile.map(MidiConnection_oneof__device_profile::device_profile),
                ..Default::default()
            }),
            Dmx(view) => Self::dmx(DmxConnection {
                outputId: view.output_id,
                ..Default::default()
            }),
        }
    }
}

impl From<mizer_connections::midi_device_profile::DeviceProfile> for MidiDeviceProfile {
    fn from(device_profile: mizer_connections::midi_device_profile::DeviceProfile) -> Self {
        let mut profile = Self {
            id: device_profile.id,
            manufacturer: device_profile.manufacturer,
            model: device_profile.name,
            pages: device_profile.pages.into_iter()
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
            controls: page.controls.into_iter()
                .map(MidiDeviceProfile_Control::from)
                .collect(),
            groups: page.groups.into_iter()
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
            controls: page.controls.into_iter()
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
