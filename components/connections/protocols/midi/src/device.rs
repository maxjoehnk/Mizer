use std::convert::TryFrom;

use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use mizer_message_bus::{MessageBus, Subscriber};
pub use mizer_midi_device_profiles::{Control, ControlType, DeviceProfile, Group, Page};
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
        match (msg, self.control_type) {
            (MidiMessage::ControlChange(channel, port, value), ControlType::ControlChange)
                if port == self.note && channel == self.channel =>
            {
                Some(value.linear_extrapolate(self.range, (0., 1.)))
            }
            (MidiMessage::NoteOn(channel, port, value), ControlType::Note)
                if port == self.note && channel == self.channel =>
            {
                Some(value.linear_extrapolate(self.range, (0., 1.)))
            }
            (MidiMessage::NoteOff(channel, port, _), ControlType::Note)
                if port == self.note && channel == self.channel =>
            {
                Some(0f64)
            }
            _ => None,
        }
    }

    fn send_value(&self, value: f64) -> Option<MidiMessage> {
        if !self.has_output {
            return None;
        }

        match self.control_type {
            ControlType::ControlChange => Some(MidiMessage::ControlChange(
                self.channel,
                self.note,
                value.linear_extrapolate((0f64, 1f64), self.output_range),
            )),
            ControlType::Note => Some(MidiMessage::NoteOn(
                self.channel,
                self.note,
                value.linear_extrapolate((0f64, 1f64), self.output_range),
            )),
        }
    }
}
