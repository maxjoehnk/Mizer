use std::convert::TryFrom;

use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use mizer_message_bus::{MessageBus, Subscriber};
pub use mizer_midi_device_profiles::{
    Control, ControlStep, DeviceControl, DeviceProfile, Group, MidiDeviceControl, Page,
};
use mizer_midi_messages::{MidiEvent, MidiMessage};

use crate::device_provider::MidiDeviceIdentifier;
use crate::device_state::DeviceState;

pub struct MidiDevice {
    pub name: String,
    pub profile: Option<DeviceProfile>,
    input: Option<MidiInputConnection<()>>,
    output: Option<MidiOutputConnection>,
    event_bus: MessageBus<MidiEvent>,
    state: DeviceState,
}

impl MidiDevice {
    pub(crate) fn new(identifier: MidiDeviceIdentifier) -> anyhow::Result<Self> {
        let (state, mut writer) = DeviceState::new();
        let mut device = MidiDevice {
            name: identifier.name.clone(),
            input: None,
            output: None,
            event_bus: Default::default(),
            profile: identifier.profile,
            state,
        };
        if let Some(port) = identifier.input {
            let input = MidiInput::new("mizer")?;
            let bus = device.event_bus.clone();
            let connection = input
                .connect(
                    &port,
                    "mizer",
                    move |time, data, _| {
                        let event = MidiEvent {
                            timestamp: time,
                            msg: MidiMessage::try_from(data).expect("could not parse midi message"),
                        };
                        tracing::trace!("{:?}", event);
                        writer.write(event.clone());
                        bus.send(event);
                    },
                    (),
                )
                .map_err(|_| anyhow::anyhow!("opening input failed"))?;
            device.input = Some(connection);
        }
        if let Some(port) = identifier.output {
            let output = MidiOutput::new("mizer")?;
            let connection = output
                .connect(&port, "mizer")
                .map_err(|_| anyhow::anyhow!("opening output failed"))?;
            device.output = Some(connection);
        }

        Ok(device)
    }

    pub fn events(&self) -> Subscriber<MidiEvent> {
        self.event_bus.subscribe()
    }

    pub fn state(&self) -> &DeviceState {
        &self.state
    }

    pub fn write(&mut self, msg: MidiMessage) -> anyhow::Result<()> {
        if let Some(ref mut output) = self.output {
            tracing::trace!("{:?}", msg);
            let data: Vec<u8> = msg.into();
            output.send(&data)?;
        }
        Ok(())
    }

    pub fn clear_outputs(&mut self) -> anyhow::Result<()> {
        let messages = if let Some(device_profile) = self.profile.as_ref() {
            tracing::debug!("Clearing outputs for device {}", self.name);
            device_profile.clear_messages()
        }else {
            tracing::debug!("Unable to clear outputs for device {}: no device profile found", self.name);
            Default::default()
        };
        for message in messages {
            self.write(message)?;
        }

        Ok(())
    }
}
