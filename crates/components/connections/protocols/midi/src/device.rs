use std::convert::TryFrom;

use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use mizer_message_bus::{MessageBus, Subscriber};
pub use mizer_midi_device_profiles::{
    Control, ControlStep, DeviceControl, DeviceProfile, Group, MidiDeviceControl, Page,
};
use mizer_midi_messages::{MidiEvent, MidiMessage};
use mizer_util::LerpExt;

use crate::device_provider::MidiDeviceIdentifier;

pub struct MidiDevice {
    pub name: String,
    pub profile: Option<DeviceProfile>,
    input: Option<MidiInputConnection<()>>,
    output: Option<MidiOutputConnection>,
    event_bus: MessageBus<MidiEvent>,
}

impl MidiDevice {
    pub(crate) fn new(identifier: MidiDeviceIdentifier) -> anyhow::Result<Self> {
        let mut device = MidiDevice {
            name: identifier.name.clone(),
            input: None,
            output: None,
            event_bus: Default::default(),
            profile: identifier.profile,
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
                        log::trace!("{:?}", event);
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

    pub fn write(&mut self, msg: MidiMessage) -> anyhow::Result<()> {
        if let Some(ref mut output) = self.output {
            log::trace!("{:?}", msg);
            let data: Vec<u8> = msg.into();
            output.send(&data)?;
        }
        Ok(())
    }
}

pub trait MidiControl {
    fn receive_value(&self, msg: MidiMessage) -> Option<f64>;

    fn send_value(
        &self,
        value: f64,
        on_step: Option<u8>,
        off_step: Option<u8>,
    ) -> Option<MidiMessage>;
}

impl MidiControl for Control {
    fn receive_value(&self, msg: MidiMessage) -> Option<f64> {
        match (msg, &self.input) {
            (
                MidiMessage::ControlChange(channel, port, value),
                Some(DeviceControl::MidiCC(MidiDeviceControl {
                    note,
                    channel: note_channel,
                    range,
                    ..
                })),
            ) if port == *note && channel == *note_channel => {
                Some(value.linear_extrapolate(*range, (0., 1.)))
            }
            (
                MidiMessage::NoteOn(channel, port, value),
                Some(DeviceControl::MidiNote(MidiDeviceControl {
                    note,
                    channel: note_channel,
                    range,
                    ..
                })),
            ) if port == *note && channel == *note_channel => {
                Some(value.linear_extrapolate(*range, (0., 1.)))
            }
            (
                MidiMessage::NoteOff(channel, port, _),
                Some(DeviceControl::MidiNote(MidiDeviceControl {
                    note,
                    channel: note_channel,
                    ..
                })),
            ) if port == *note && channel == *note_channel => Some(0f64),
            _ => None,
        }
    }

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

fn convert_value(value: f64, range: (u8, u8), on_step: Option<u8>, off_step: Option<u8>) -> u8 {
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

    value.linear_extrapolate((0f64, 1f64), range)
}
