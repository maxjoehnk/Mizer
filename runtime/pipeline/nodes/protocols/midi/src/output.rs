use mizer_node::*;
use mizer_protocol_midi::*;
use serde::{Deserialize, Serialize};
use std::ops::DerefMut;
use std::convert::TryInto;
use crate::lerp_extension::LerpExt;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiOutputNode {
    pub device: String,
    #[serde(default = "default_channel")]
    pub channel: u8,
    #[serde(flatten)]
    pub config: MidiOutputConfig,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum MidiOutputConfig {
    CC {
        port: u8,
        #[serde(default = "default_midi_range")]
        range: (u8, u8),
    },
    Note {
        port: u8,
        #[serde(default = "default_midi_range")]
        range: (u8, u8),
    }
}


impl Default for MidiOutputConfig {
    fn default() -> Self {
        MidiOutputConfig::Note {
            port: 1,
            range: default_midi_range()
        }
    }
}

fn default_channel() -> u8 {
    1
}

fn default_midi_range() -> (u8, u8) {
    (0, 255)
}

impl PipelineNode for MidiOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MidiOutputNode".into(),
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            ("value".into(), PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            })
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiOutput
    }
}

impl ProcessingNode for MidiOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let connection_manager = context.inject::<MidiConnectionManager>().unwrap();
        if let Some(mut device) = connection_manager.request_device(&self.device)? {
            if let Some(value) = context.read_port::<_, f64>("value") {
                let device: &mut MidiDevice = device.deref_mut();
                let channel = self.channel.try_into().unwrap();
                let msg = match &self.config {
                    MidiOutputConfig::CC { port, range} => {
                        MidiMessage::ControlChange(channel, *port, value.lerp((0f64, 1f64), *range))
                    },
                    MidiOutputConfig::Note { port, range } => {
                        MidiMessage::NoteOn(channel, *port, value.lerp((0f64, 1f64), *range))
                    },
                };

                device.write(msg)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
