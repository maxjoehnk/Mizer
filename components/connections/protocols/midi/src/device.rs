use std::convert::TryFrom;

use crossbeam_channel::{Receiver, Sender};
use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

pub use mizer_midi_device_profiles::{Control, ControlType, DeviceProfile, Group, Page};
use mizer_util::LerpExt;

use crate::device_provider::MidiDeviceIdentifier;
use mizer_midi_messages::{MidiEvent, MidiMessage};

pub struct MidiDevice {
    pub name: String,
    pub profile: Option<DeviceProfile>,
    input: Option<MidiInputConnection<()>>,
    output: Option<MidiOutputConnection>,
    event_subscriber: Sender<Sender<MidiEvent>>,
}

pub struct MidiEventReceiver(Receiver<MidiEvent>);

impl MidiEventReceiver {
    pub fn iter(&self) -> impl Iterator<Item = MidiEvent> + '_ {
        self.0.try_iter()
    }
}

impl MidiDevice {
    pub(crate) fn new(identifier: MidiDeviceIdentifier) -> anyhow::Result<Self> {
        let (subscriber_tx, subscriber_rx) = crossbeam_channel::unbounded();
        let (event_tx, event_rx) = crossbeam_channel::unbounded();
        let mut device = MidiDevice {
            name: identifier.name.clone(),
            input: None,
            output: None,
            event_subscriber: subscriber_tx,
            profile: identifier.profile,
        };
        if let Some(port) = identifier.input {
            let input = MidiInput::new("mizer")?;
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
                        event_tx.try_send(event).expect("pushing midi event failed");
                    },
                    (),
                )
                .map_err(|_| anyhow::anyhow!("opening input failed"))?;
            device.input = Some(connection);
            std::thread::spawn(move || {
                let mut senders = Vec::<Sender<MidiEvent>>::new();
                loop {
                    crossbeam_channel::select! {
                        recv(event_rx) -> event => {
                            if let Ok(event) = event {
                                for sender in &senders {
                                    if let Err(err) = sender.send(event.clone()) {
                                        log::error!("Error sending event to midi subscriber: {:?}", err);
                                    }
                                }
                            }
                        },
                        recv(subscriber_rx) -> subscriber => {
                            if let Ok(subscriber) = subscriber {
                                senders.push(subscriber);
                            }
                        }
                    }
                }
            });
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

    pub fn events(&self) -> MidiEventReceiver {
        let (tx, rx) = crossbeam_channel::unbounded();
        self.event_subscriber.send(tx).unwrap();
        MidiEventReceiver(rx)
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
