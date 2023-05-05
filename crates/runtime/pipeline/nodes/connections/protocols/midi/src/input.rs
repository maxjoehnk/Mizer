use mizer_message_bus::Subscriber;
use mizer_node::*;
use mizer_protocol_midi::*;
use mizer_util::LerpExt;
use serde::{Deserialize, Serialize};
use std::ops::Deref;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiInputNode {
    pub device: String,
    #[serde(flatten)]
    pub config: MidiInputConfig,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum MidiInputConfig {
    CC {
        #[serde(default = "default_channel")]
        channel: u8,
        port: u8,
        #[serde(default = "default_midi_range")]
        range: (u8, u8),
    },
    Note {
        #[serde(default = "default_channel")]
        channel: u8,
        port: u8,
        #[serde(default = "default_midi_range")]
        range: (u8, u8),
    },
    Control {
        page: String,
        control: String,
    },
}

impl Default for MidiInputConfig {
    fn default() -> Self {
        MidiInputConfig::Note {
            channel: default_channel(),
            port: 1,
            range: default_midi_range(),
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
            name: stringify!(MidiInputNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!("value", PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiInput
    }
}

impl ProcessingNode for MidiInputNode {
    type State = Option<Subscriber<MidiEvent>>;

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
                            MidiInputConfig::CC {
                                channel: config_channel,
                                port: config_port,
                                range: (min, max),
                            },
                        ) if port == *config_port => {
                            if channel != *config_channel {
                                continue;
                            }
                            result_value =
                                Some(value.linear_extrapolate((*min, *max), (0f64, 1f64)));
                        }
                        (
                            MidiMessage::NoteOn(channel, port, value),
                            MidiInputConfig::Note {
                                channel: config_channel,
                                port: config_port,
                                range: (min, max),
                            },
                        ) if port == *config_port => {
                            if channel != *config_channel {
                                continue;
                            }
                            result_value =
                                Some(value.linear_extrapolate((*min, *max), (0f64, 1f64)));
                        }
                        (
                            MidiMessage::NoteOff(channel, port, _),
                            MidiInputConfig::Note {
                                channel: config_channel,
                                port: config_port,
                                ..
                            },
                        ) if port == *config_port => {
                            if channel != *config_channel {
                                continue;
                            }
                            result_value = Some(0f64);
                        }
                        (msg, MidiInputConfig::Control { page, control }) => {
                            if let Some(control) = device
                                .profile
                                .as_ref()
                                .and_then(|profile| profile.get_control(page, control))
                            {
                                if let Some(value) = control.receive_value(msg) {
                                    result_value = Some(value);
                                }
                            }
                        }
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

    fn update(&mut self, config: &Self) {
        self.device = config.device.clone();
        self.config = config.config.clone();
    }
}
