use mizer_node::*;
use mizer_protocol_midi::*;
use mizer_util::LerpExt;
use serde::{Deserialize, Serialize};
use std::convert::TryInto;
use std::ops::DerefMut;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiOutputNode {
    pub device: String,
    #[serde(flatten)]
    pub config: MidiOutputConfig,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum MidiOutputConfig {
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

impl Default for MidiOutputConfig {
    fn default() -> Self {
        MidiOutputConfig::Note {
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

impl PipelineNode for MidiOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(MidiOutputNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("value", PortType::Single)]
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
            if let Some(value) = context.read_port_changes::<_, f64>("value") {
                context.push_history_value(value);
                let device: &mut MidiDevice = device.deref_mut();
                let msg = match &self.config {
                    MidiOutputConfig::CC {
                        channel,
                        port,
                        range,
                    } => Some(MidiMessage::ControlChange(
                        (*channel).try_into().unwrap(),
                        *port,
                        value.linear_extrapolate((0f64, 1f64), *range),
                    )),
                    MidiOutputConfig::Note {
                        channel,
                        port,
                        range,
                    } => Some(MidiMessage::NoteOn(
                        (*channel).try_into().unwrap(),
                        *port,
                        value.linear_extrapolate((0f64, 1f64), *range),
                    )),
                    MidiOutputConfig::Control { page, control } => {
                        if let Some(control) = device
                            .profile
                            .as_ref()
                            .and_then(|profile| profile.get_control(page, control))
                        {
                            control.send_value(value)
                        } else {
                            None
                        }
                    }
                };

                if let Some(msg) = msg {
                    device.write(msg)?;
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
