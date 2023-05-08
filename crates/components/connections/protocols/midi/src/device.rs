use std::convert::TryFrom;

use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use mizer_message_bus::{MessageBus, Subscriber};
pub use mizer_midi_device_profiles::{
    Control, DeviceControl, DeviceProfile, Group, MidiDeviceControl, Page,
};
use mizer_util::LerpExt;

use crate::device_provider::MidiDeviceIdentifier;
use mizer_midi_messages::{MidiEvent, MidiMessage};

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

    fn send_value(&self, value: f64) -> Option<MidiMessage>;
}

impl MidiControl for Control {
    fn receive_value(&self, msg: MidiMessage) -> Option<f64> {
        match (msg, self.input) {
            (
                MidiMessage::ControlChange(channel, port, value),
                Some(DeviceControl::MidiCC(MidiDeviceControl {
                    note,
                    channel: note_channel,
                    range,
                    ..
                })),
            ) if note == port && channel == note_channel => {
                Some(value.linear_extrapolate(range, (0., 1.)))
            }
            (
                MidiMessage::NoteOn(channel, port, value),
                Some(DeviceControl::MidiNote(MidiDeviceControl {
                    note,
                    channel: note_channel,
                    range,
                    ..
                })),
            ) if port == note && channel == note_channel => {
                Some(value.linear_extrapolate(range, (0., 1.)))
            }
            (
                MidiMessage::NoteOff(channel, port, _),
                Some(DeviceControl::MidiNote(MidiDeviceControl {
                    note,
                    channel: note_channel,
                    ..
                })),
            ) if port == note && channel == note_channel => Some(0f64),
            _ => None,
        }
    }

    fn send_value(&self, value: f64) -> Option<MidiMessage> {
        match self.output {
            Some(DeviceControl::MidiNote(MidiDeviceControl {
                channel,
                note,
                range,
            })) => Some(MidiMessage::NoteOn(
                channel,
                note,
                value.linear_extrapolate((0f64, 1f64), range),
            )),
            Some(DeviceControl::MidiCC(MidiDeviceControl {
                channel,
                note,
                range,
            })) => Some(MidiMessage::ControlChange(
                channel,
                note,
                value.linear_extrapolate((0f64, 1f64), range),
            )),
            _ => None,
        }
    }
}
