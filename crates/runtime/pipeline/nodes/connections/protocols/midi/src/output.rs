use std::convert::TryInto;
use std::fmt::{Display, Formatter};
use std::ops::DerefMut;

use enum_iterator::Sequence;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_midi::*;
use mizer_util::LerpExt;

use crate::{get_pages_and_controls, NoteMode};

const INPUT_PORT: &str = "Input";
const COLOR_PORT: &str = "Color";

const DEVICE_SETTING: &str = "Device";
const BINDING_SETTING: &str = "Binding";
const MODE_SETTING: &str = "Mode";
const CHANNEL_SETTING: &str = "Channel";
const PORT_SETTING: &str = "Port";
const RANGE_FROM_SETTING: &str = "Range From";
const RANGE_TO_SETTING: &str = "Range To";
const PAGE_SETTING: &str = "Page";
const CONTROL_SETTING: &str = "Control";
const OFF_STEP_SETTING: &str = "Value Off";
const ON_STEP_SETTING: &str = "Value On";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiOutputNode {
    pub device: String,
    #[serde(flatten)]
    pub config: MidiOutputConfig,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum MidiOutputConfig {
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
        #[serde(default)]
        off_step: Option<u8>,
        #[serde(default)]
        on_step: Option<u8>,
    },
}

impl Display for MidiOutputConfig {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Note { .. } => write!(f, "Note"),
            Self::Control { .. } => write!(f, "Control"),
        }
    }
}

impl Default for MidiOutputConfig {
    fn default() -> Self {
        MidiOutputConfig::Note {
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

impl ConfigurableNode for MidiOutputNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let connection_manager = injector.try_inject::<MidiConnectionManager>().unwrap();
        let devices = connection_manager.list_available_devices();
        let devices = devices
            .into_iter()
            .filter(|device| device.has_output())
            .map(|device| SelectVariant::from(device.name))
            .collect();
        let device_setting = setting!(select DEVICE_SETTING, &self.device, devices);
        let binding_setting = setting!(enum BINDING_SETTING, self.config.clone());

        match self.config.clone() {
            MidiOutputConfig::Note {
                mode,
                port,
                range,
                channel,
            } => vec![
                device_setting,
                binding_setting,
                setting!(enum MODE_SETTING, mode),
                setting!(CHANNEL_SETTING, channel as u32)
                    .min(1u32)
                    .max(16u32),
                setting!(PORT_SETTING, port as u32)
                    .min(1u32)
                    .max_hint(255u32),
                setting!(RANGE_FROM_SETTING, range.0 as u32)
                    .min(0u32)
                    .max(255u32),
                setting!(RANGE_TO_SETTING, range.1 as u32)
                    .min(1u32)
                    .max(255u32),
            ],
            MidiOutputConfig::Control {
                page,
                control,
                off_step,
                on_step,
            } => {
                let (pages, controls, mut steps) =
                    get_pages_and_controls(injector, &self.device, &page, &control, false);
                if let Some(steps) = steps.as_mut() {
                    steps.insert(
                        0,
                        SelectVariant::Item {
                            value: Default::default(),
                            label: Default::default(),
                        },
                    );
                }
                let selected_off_step = off_step.map(|value| value.to_string()).unwrap_or_default();
                let selected_on_step = on_step.map(|value| value.to_string()).unwrap_or_default();
                let mut settings = vec![
                    device_setting,
                    binding_setting,
                    setting!(select PAGE_SETTING, &page, pages),
                    setting!(select CONTROL_SETTING, &control, controls),
                ];
                if let Some(steps) = steps {
                    settings
                        .push(setting!(select OFF_STEP_SETTING, selected_off_step, steps.clone()));
                    settings.push(setting!(select ON_STEP_SETTING, selected_on_step, steps));
                }

                settings
            }
        }
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device);
        update!(enum setting, BINDING_SETTING, self.config);
        match &mut self.config {
            MidiOutputConfig::Note {
                port,
                range,
                mode,
                channel,
            } => {
                update!(uint setting, PORT_SETTING, *port);
                update!(uint setting, CHANNEL_SETTING, *channel);
                update!(uint setting, RANGE_FROM_SETTING, range.0);
                update!(uint setting, RANGE_TO_SETTING, range.1);
                update!(enum setting, MODE_SETTING, *mode);
            }
            MidiOutputConfig::Control {
                page,
                control,
                on_step,
                off_step,
            } => {
                update!(select setting, PAGE_SETTING, *page);
                update!(select setting, CONTROL_SETTING, *control);
                update!(select setting, ON_STEP_SETTING, *on_step, |value: String| {
                    if value.is_empty() {
                        Ok(None)
                    } else {
                        Some(value.parse::<u8>()).transpose()
                    }
                });
                update!(select setting, OFF_STEP_SETTING, *off_step, |value: String| {
                    if value.is_empty() {
                        Ok(None)
                    } else {
                        Some(value.parse::<u8>()).transpose()
                    }
                });
            }
        }

        update_fallback!(setting)
    }
}

impl PipelineNode for MidiOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "MIDI Output".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn display_name(&self, _injector: &ReadOnlyInjectionScope) -> String {
        match &self.config {
            MidiOutputConfig::Control { page, control, .. } => {
                format!("MIDI Output ({} - {}/{})", self.device, page, control)
            }
            MidiOutputConfig::Note {
                mode,
                channel,
                port,
                ..
            } => format!("MIDI Output ({} - Ch {channel} {mode} {port})", self.device),
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Single),
            input_port!(COLOR_PORT, PortType::Color),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiOutput
    }
}

impl ProcessingNode for MidiOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let connection_manager = context.try_inject::<MidiConnectionManager>().unwrap();
        if let Some(mut device) = connection_manager.request_device(&self.device)? {
            let device: &mut MidiDevice = device.deref_mut();
            let msg = match &self.config {
                MidiOutputConfig::Note {
                    mode: NoteMode::CC,
                    channel,
                    port,
                    range,
                } => context
                    .read_port_changes::<_, f64>(INPUT_PORT)
                    .map(|value| {
                        context.push_history_value(value);
                        MidiMessage::ControlChange(
                            (*channel).try_into().unwrap(),
                            *port,
                            value.linear_extrapolate((0f64, 1f64), *range),
                        )
                    }),
                MidiOutputConfig::Note {
                    mode: NoteMode::Note,
                    channel,
                    port,
                    range,
                } => context
                    .read_port_changes::<_, f64>(INPUT_PORT)
                    .map(|value| {
                        context.push_history_value(value);
                        MidiMessage::NoteOn(
                            (*channel).try_into().unwrap(),
                            *port,
                            value.linear_extrapolate((0f64, 1f64), *range),
                        )
                    }),
                MidiOutputConfig::Control {
                    page,
                    control,
                    on_step,
                    off_step,
                } => {
                    if let Some((profile, control)) = device.profile.as_ref().and_then(|profile| {
                        profile
                            .get_control(page, control)
                            .map(|control| (profile, control))
                    }) {
                        if let Some(DeviceControl::RGBSysEx(_)) = control.output {
                            context
                                .read_port_changes::<_, Color>(COLOR_PORT)
                                .and_then(|value| profile.write_rgb(control, value.into()))
                        } else {
                            context
                                .read_port_changes::<_, f64>(INPUT_PORT)
                                .and_then(|value| {
                                    context.push_history_value(value);
                                    control.send_value(value, *on_step, *off_step)
                                })
                        }
                    } else {
                        None
                    }
                }
            };
            if let Some(msg) = msg {
                device.write(msg)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl Sequence for MidiOutputConfig {
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
            off_step: Default::default(),
            on_step: Default::default(),
        })
    }
}

impl TryFrom<u8> for MidiOutputConfig {
    type Error = anyhow::Error;

    fn try_from(value: u8) -> Result<Self, Self::Error> {
        match value {
            0 => Ok(Self::first().unwrap()),
            1 => Ok(Self::last().unwrap()),
            _ => Err(anyhow::anyhow!("Invalid MidiOutputConfig enum u8 value")),
        }
    }
}

impl Into<u8> for MidiOutputConfig {
    fn into(self) -> u8 {
        match self {
            Self::Note { .. } => 0,
            Self::Control { .. } => 1,
        }
    }
}
