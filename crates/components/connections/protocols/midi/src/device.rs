use std::convert::TryFrom;

use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use mizer_message_bus::{MessageBus, Subscriber};
pub use mizer_midi_device_profiles::{
    Control, ControlStep, DeviceControl, DeviceProfile, Group, MidiDeviceControl, Page,
};
use mizer_midi_messages::{MidiEvent, MidiMessage};
use mizer_util::LerpExt;

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
}

pub trait MidiControl {
    fn send_value(
        &self,
        value: f64,
        on_step: Option<u8>,
        off_step: Option<u8>,
    ) -> Option<MidiMessage>;
}

impl MidiControl for Control {
    fn send_value(
        &self,
        value: f64,
        on_step: Option<u8>,
        off_step: Option<u8>,
    ) -> Option<MidiMessage> {
        match self.output {
            Some(DeviceControl::MidiNote(MidiDeviceControl {
                channel,
                note,
                range,
                ..
            })) => Some(MidiMessage::NoteOn(
                channel,
                note,
                convert_value(value, range, on_step, off_step),
            )),
            Some(DeviceControl::MidiCC(MidiDeviceControl {
                channel,
                note,
                range,
                ..
            })) => Some(MidiMessage::ControlChange(
                channel,
                note,
                convert_value(value, range, on_step, off_step),
            )),
            _ => None,
        }
    }
}

fn convert_value(value: f64, range: (u16, u16), on_step: Option<u8>, off_step: Option<u8>) -> u8 {
    if let Some(on_step) = on_step {
        if value > 0f64 + f64::EPSILON {
            return on_step;
        }
    }
    if let Some(off_step) = off_step {
        if value > 0f64 - f64::EPSILON && value < 0f64 + f64::EPSILON {
            return off_step;
        }
    }

    value.linear_extrapolate((0f64, 1f64), (range.0.min(u8::MAX as u16) as u8, range.1.min(u8::MAX as u16) as u8))
}
