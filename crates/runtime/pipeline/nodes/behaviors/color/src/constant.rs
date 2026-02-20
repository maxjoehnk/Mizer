use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use serde::{Deserialize, Serialize};

use mizer_node::*;

const COLOR_OUTPUT: &str = "Color";

const MODE_SETTING: &str = "Mode";
const RED_SETTING: &str = "Red";
const GREEN_SETTING: &str = "Green";
const BLUE_SETTING: &str = "Blue";
const HUE_SETTING: &str = "Hue";
const SATURATION_SETTING: &str = "Saturation";
const VALUE_SETTING: &str = "Value";

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub enum ConstantColorNode {
    Rgb {
        red: f64,
        green: f64,
        blue: f64,
    },
    Hsv {
        hue: f64,
        saturation: f64,
        value: f64,
    },
}

impl Default for ConstantColorNode {
    fn default() -> Self {
        Self::Rgb {
            red: 0.,
            green: 0.,
            blue: 0.,
        }
    }
}

impl Display for ConstantColorNode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Rgb { .. } => write!(f, "RGB"),
            Self::Hsv { .. } => write!(f, "HSV"),
        }
    }
}

impl ConfigurableNode for ConstantColorNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let mode_setting = setting!(enum MODE_SETTING, *self);
        match *self {
            Self::Rgb { red, green, blue } => {
                vec![
                    mode_setting,
                    setting!(RED_SETTING, red).min(0.).max(1.),
                    setting!(GREEN_SETTING, green).min(0.).max(1.),
                    setting!(BLUE_SETTING, blue).min(0.).max(1.),
                ]
            }
            Self::Hsv {
                hue,
                saturation,
                value,
            } => {
                vec![
                    mode_setting,
                    setting!(HUE_SETTING, hue).min(0.).max(360.).step_size(1.),
                    setting!(SATURATION_SETTING, saturation).min(0.).max(1.),
                    setting!(VALUE_SETTING, value).min(0.).max(1.),
                ]
            }
        }
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, MODE_SETTING, *self);
        match self {
            Self::Rgb { red, green, blue } => {
                update!(float setting, RED_SETTING, *red);
                update!(float setting, GREEN_SETTING, *green);
                update!(float setting, BLUE_SETTING, *blue);
            }
            Self::Hsv {
                hue,
                saturation,
                value,
            } => {
                update!(float setting, HUE_SETTING, *hue);
                update!(float setting, SATURATION_SETTING, *saturation);
                update!(float setting, VALUE_SETTING, *value);
            }
        }

        update_fallback!(setting)
    }
}

impl PipelineNode for ConstantColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Color Constant".into(),
            preview_type: PreviewType::Color,
            category: NodeCategory::Color,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(COLOR_OUTPUT, PortType::Color)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorConstant
    }
}

impl ProcessingNode for ConstantColorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let value = match *self {
            Self::Rgb { red, green, blue } => Color::rgb(red, green, blue),
            Self::Hsv {
                hue,
                saturation,
                value,
            } => Color::hsv(hue, saturation, value),
        };

        context.write_port(COLOR_OUTPUT, value);
        context.write_color_preview(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl Sequence for ConstantColorNode {
    const CARDINALITY: usize = 2;

    fn next(&self) -> Option<Self> {
        if let Self::Rgb { .. } = self {
            Self::last()
        } else {
            None
        }
    }

    fn previous(&self) -> Option<Self> {
        if let Self::Hsv { .. } = self {
            Self::first()
        } else {
            None
        }
    }

    fn first() -> Option<Self> {
        Some(ConstantColorNode::Rgb {
            red: 0.,
            green: 0.,
            blue: 0.,
        })
    }

    fn last() -> Option<Self> {
        Some(ConstantColorNode::Hsv {
            hue: 0.,
            saturation: 0.,
            value: 0.,
        })
    }
}

impl TryFrom<u8> for ConstantColorNode {
    type Error = anyhow::Error;

    fn try_from(value: u8) -> Result<Self, Self::Error> {
        match value {
            0 => Ok(Self::Rgb {
                red: 0.,
                green: 0.,
                blue: 0.,
            }),
            1 => Ok(Self::Hsv {
                hue: 0.,
                saturation: 0.,
                value: 0.,
            }),
            _ => Err(anyhow::anyhow!("Invalid constant color mode")),
        }
    }
}

impl Into<u8> for ConstantColorNode {
    fn into(self) -> u8 {
        match self {
            Self::Rgb { .. } => 0,
            Self::Hsv { .. } => 1,
        }
    }
}
