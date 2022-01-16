use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_osc::*;
use mizer_util::ConvertBytes;

use crate::argument_type::OscArgumentType;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct OscOutputNode {
    #[serde(default = "default_host")]
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub path: String,
    #[serde(default = "default_argument_type")]
    pub argument_type: OscArgumentType,
}

fn default_host() -> String {
    "255.255.255.255".into()
}

fn default_port() -> u16 {
    6000
}

fn default_argument_type() -> OscArgumentType {
    OscArgumentType::Float
}

impl Default for OscOutputNode {
    fn default() -> Self {
        Self {
            host: default_host(),
            port: default_port(),
            argument_type: default_argument_type(),
            path: "".into(),
        }
    }
}

impl PipelineNode for OscOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OscOutputNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            self.argument_type.get_port_id(),
            PortMetadata {
                port_type: self.argument_type.get_port_type(),
                direction: PortDirection::Input,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscOutput
    }
}

impl ProcessingNode for OscOutputNode {
    type State = OscOutput;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if self.argument_type.is_numeric() {
            if let Some(value) = context.read_port::<_, f64>(self.argument_type.get_port_id()) {
                context.push_history_value(value);
                let arg = match self.argument_type {
                    OscArgumentType::Float => OscType::Float(value as f32),
                    OscArgumentType::Double => OscType::Double(value),
                    OscArgumentType::Int => OscType::Int(value as i32),
                    OscArgumentType::Long => OscType::Long(value as i64),
                    OscArgumentType::Bool => OscType::Bool((value - 1.).abs() < f64::EPSILON),
                    _ => unreachable!(),
                };
                state.send(OscPacket::Message(OscMessage {
                    addr: self.path.clone(),
                    args: vec![arg],
                }))?;
            }
        }
        if self.argument_type.is_color() {
            if let Some(color) = context.read_port::<_, Color>(self.argument_type.get_port_id()) {
                let color = OscColor {
                    red: color.red.to_8bit(),
                    green: color.green.to_8bit(),
                    blue: color.blue.to_8bit(),
                    alpha: color.alpha as u8,
                };
                state.send(OscPacket::Message(OscMessage {
                    addr: self.path.clone(),
                    args: vec![OscType::Color(color)],
                }))?;
            }
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        OscOutput::new(&self.host, self.port).unwrap()
    }
}
