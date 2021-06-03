use mizer_node::*;
use mizer_protocol_midi::*;
use serde::{Deserialize, Serialize};
use std::ops::Deref;
use crate::lerp_extension::LerpExt;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiInputNode {
    pub device: String,
    #[serde(default = "default_channel")]
    pub channel: u8,
    #[serde(flatten)]
    pub config: MidiInputConfig,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum MidiInputConfig {
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

impl Default for MidiInputConfig {
    fn default() -> Self {
        MidiInputConfig::Note {
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

impl PipelineNode for MidiInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MidiInputNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (PortId("value".into()), PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Output,
                ..Default::default()
            })
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiInput
    }
}

impl ProcessingNode for MidiInputNode {
    type State = Option<MidiEventReceiver>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let connection_manager = context.inject::<MidiConnectionManager>().unwrap();
        if let Some(device) = connection_manager.request_device(&self.device)? {
            let device: &MidiDevice = device.deref();
            if state.is_none() {
                *state = Some(device.events());
            }
            if let Some(recv) = state {
                let mut result_value = None;

                for event in recv.iter() {
                    match (event.msg, &self.config) {
                        (
                            MidiMessage::ControlChange(channel, port, value),
                            MidiInputConfig::CC { port: config_port, range: (min, max) }
                        ) if port == *config_port => {
                            if channel != self.channel {
                                continue;
                            }
                            result_value = Some(value.lerp((*min, *max), (0f64, 1f64))); //value as f64).lerp((min, max), (0f64, 1f64)));
                        },
                        (
                            MidiMessage::NoteOn(channel, port, value),
                            MidiInputConfig::Note { port: config_port, range: (min, max) }
                        ) if port == *config_port => {
                            if channel != self.channel {
                                continue;
                            }
                            result_value = Some(value.lerp((*min, *max), (0f64, 1f64)));
                        },
                        (
                            MidiMessage::NoteOff(channel, port, _),
                            MidiInputConfig::Note { port: config_port, .. }
                        ) if port == *config_port => {
                            if channel != self.channel {
                                continue;
                            }
                            result_value = Some(0f64);
                        },
                        _ => {}
                    }
                }
                if let Some(value) = result_value {
                    context.write_port::<_, f64>("value", value);
                    context.push_history_value(value);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
