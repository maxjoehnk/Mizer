use std::convert::TryFrom;

use crossbeam_channel::{Receiver, Sender};
use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use crate::device_provider::MidiDeviceIdentifier;
use crate::event::MidiEvent;
use crate::message::MidiMessage;

pub struct MidiDevice {
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
            input: None,
            output: None,
            event_subscriber: subscriber_tx,
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
                                    sender.send(event.clone()).unwrap();
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
