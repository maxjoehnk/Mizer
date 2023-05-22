use crate::{get_devices, get_pages_and_controls, NoteMode};
use enum_iterator::Sequence;
use mizer_message_bus::Subscriber;
use mizer_node::*;
use mizer_protocol_midi::*;
use mizer_util::LerpExt;
use serde::{Deserialize, Serialize};
use std::fmt::{Display, Formatter};
use std::ops::Deref;

const OUTPUT_PORT: &str = "Output";

const DEVICE_SETTING: &str = "Device";
const BINDING_SETTING: &str = "Binding";
const MODE_SETTING: &str = "Mode";
const CHANNEL_SETTING: &str = "Channel";
const PORT_SETTING: &str = "Port";
const RANGE_FROM_SETTING: &str = "Range From";
const RANGE_TO_SETTING: &str = "Range To";
const PAGE_SETTING: &str = "Page";
const CONTROL_SETTING: &str = "Control";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiInputNode {
    pub device: String,
    #[serde(flatten)]
    pub config: MidiInputConfig,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum MidiInputConfig {
    Note {
        mode: NoteMode,
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

impl Display for MidiInputConfig {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Note { .. } => write!(f, "Note"),
            Self::Control { .. } => write!(f, "Control"),
        }
    }
}

impl Default for MidiInputConfig {
    fn default() -> Self {
        MidiInputConfig::Note {
            mode: NoteMode::Note,
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

impl ConfigurableNode for MidiInputNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let devices = get_devices(injector);
        let device_setting = setting!(select DEVICE_SETTING, &self.device, devices);
        let binding_setting = setting!(enum BINDING_SETTING, self.config.clone());

        match self.config.clone() {
            MidiInputConfig::Note {
                mode,
                port,
                range,
                channel,
            } => vec![
                device_setting,
                binding_setting,
                setting!(enum MODE_SETTING, mode),
                setting!(CHANNEL_SETTING, channel as u32).min(1).max(16),
                setting!(PORT_SETTING, port as u32).min(1).max_hint(255),
                setting!(RANGE_FROM_SETTING, range.0 as u32).min(0).max(255),
                setting!(RANGE_TO_SETTING, range.1 as u32).min(1).max(255),
            ],
            MidiInputConfig::Control { page, control } => {
                let (pages, controls) = get_pages_and_controls(injector, &self.device, &page, true);
                vec![
                    device_setting,
                    binding_setting,
                    setting!(select PAGE_SETTING, &page, pages),
                    setting!(select CONTROL_SETTING, &control, controls),
                ]
            }
        }
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device);
        update!(enum setting, BINDING_SETTING, self.config);
        match &mut self.config {
            MidiInputConfig::Note {
                port,
                range,
                mode,
                channel,
            } => {
                update!(int setting, PORT_SETTING, *port);
                update!(int setting, CHANNEL_SETTING, *channel);
                update!(int setting, RANGE_FROM_SETTING, range.0);
                update!(int setting, RANGE_TO_SETTING, range.1);
                update!(enum setting, MODE_SETTING, *mode);
            }
            MidiInputConfig::Control { page, control } => {
                update!(select setting, PAGE_SETTING, *page);
                update!(select setting, CONTROL_SETTING, *control);
            }
        }

        update_fallback!(setting)
    }
}

impl PipelineNode for MidiInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(MidiInputNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Single)]
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
                            MidiInputConfig::Note {
                                mode: NoteMode::CC,
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
                                mode: NoteMode::Note,
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
                                mode: NoteMode::Note,
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
                    context.write_port::<_, f64>(OUTPUT_PORT, value);
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

impl Sequence for MidiInputConfig {
    const CARDINALITY: usize = 2;

    fn next(&self) -> Option<Self> {
        if let Self::Note { .. } = self {
            Self::last()
        } else {
            None
        }
    }

    fn previous(&self) -> Option<Self> {
        if let Self::Control { .. } = self {
            Self::first()
        } else {
            None
        }
    }

    fn first() -> Option<Self> {
        Some(Self::Note {
            mode: NoteMode::Note,
            port: Default::default(),
            channel: default_channel(),
            range: default_midi_range(),
        })
    }

    fn last() -> Option<Self> {
        Some(Self::Control {
            control: Default::default(),
            page: Default::default(),
        })
    }
}

impl TryFrom<u8> for MidiInputConfig {
    type Error = anyhow::Error;

    fn try_from(value: u8) -> Result<Self, Self::Error> {
        match value {
            0 => Ok(Self::first().unwrap()),
            1 => Ok(Self::last().unwrap()),
            _ => Err(anyhow::anyhow!("Invalid MidiInputConfig enum u8 value")),
        }
    }
}

impl Into<u8> for MidiInputConfig {
    fn into(self) -> u8 {
        match self {
            Self::Note { .. } => 0,
            Self::Control { .. } => 1,
        }
    }
}
