use std::convert::TryFrom;
use std::sync::mpsc;

use midir::{MidiInput, MidiInputConnection, MidiOutput, MidiOutputConnection};

use crate::device_provider::MidiDeviceIdentifier;
use crate::event::MidiEvent;
use crate::message::MidiMessage;

pub struct MidiDevice {
    input: Option<MidiInputConnection<()>>,
    output: Option<MidiOutputConnection>,
    input_buffer: mpsc::Receiver<MidiEvent>,
}

impl MidiDevice {
    pub(crate) fn new(identifier: MidiDeviceIdentifier) -> anyhow::Result<Self> {
        let (tx, rx) = mpsc::channel();
        let mut device = MidiDevice {
            input: None,
            output: None,
            input_buffer: rx,
        };
        if let Some(port) = identifier.input {
            let input = MidiInput::new("mizer")?;
            let connection = input
                .connect(
                    &port,
                    "mizer",
                    move |time, data, _| {
                        tx.send(MidiEvent {
                            timestamp: time,
                            msg: MidiMessage::try_from(data).expect("could not parse midi message"),
                        })
                        .expect("pushing midi event failed");
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

    pub fn events(&self) -> impl Iterator<Item = MidiEvent> + '_ {
        self.input_buffer.iter()
    }

    pub fn write(&mut self, msg: MidiMessage) -> anyhow::Result<()> {
        if let Some(ref mut output) = self.output {
            println!("{:?}", msg);
            let data: Vec<u8> = msg.into();
            output.send(&data)?;
        }
        Ok(())
    }
}
