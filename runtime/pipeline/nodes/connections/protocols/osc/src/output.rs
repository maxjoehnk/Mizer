use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_osc::*;
use mizer_util::ConvertBytes;

use crate::argument_type::OscArgumentType;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct OscOutputNode {
    pub connection: String,
    pub path: String,
    #[serde(default = "default_argument_type")]
    pub argument_type: OscArgumentType,
    #[serde(default)]
    pub only_emit_changes: bool,
}

fn default_argument_type() -> OscArgumentType {
    OscArgumentType::Float
}

impl Default for OscOutputNode {
    fn default() -> Self {
        Self {
            connection: Default::default(),
            argument_type: default_argument_type(),
            path: "".into(),
            only_emit_changes: false,
        }
    }
}

impl PipelineNode for OscOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(OscOutputNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(
            self.argument_type.get_port_id(),
            self.argument_type.get_port_type()
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscOutput
    }
}

impl ProcessingNode for OscOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let connection_manager = context.inject::<OscConnectionManager>();
        if connection_manager.is_none() {
            anyhow::bail!("Missing osc module");
        }
        let connection_manager = connection_manager.unwrap();
        let output = connection_manager.get_output(&self.connection);
        if output.is_none() {
            return Ok(());
        }
        let output = output.unwrap();

        if self.argument_type.is_numeric() {
            let value = if self.only_emit_changes {
                context.read_port::<_, f64>(self.argument_type.get_port_id())
            } else {
                context.read_port_changes::<_, f64>(self.argument_type.get_port_id())
            };
            if let Some(value) = value {
                context.push_history_value(value);
                let arg = match self.argument_type {
                    OscArgumentType::Float => OscType::Float(value as f32),
                    OscArgumentType::Double => OscType::Double(value),
                    OscArgumentType::Int => OscType::Int(value as i32),
                    OscArgumentType::Long => OscType::Long(value as i64),
                    OscArgumentType::Bool => OscType::Bool((value - 1.).abs() < f64::EPSILON),
                    _ => unreachable!(),
                };
                output.write(OscMessage {
                    addr: self.path.clone(),
                    args: vec![arg],
                })?;
            }
        }
        if self.argument_type.is_color() {
            let value = if self.only_emit_changes {
                context.read_port::<_, Color>(self.argument_type.get_port_id())
            } else {
                context.read_port_changes::<_, Color>(self.argument_type.get_port_id())
            };
            if let Some(color) = value {
                let color = OscColor {
                    red: color.red.to_8bit(),
                    green: color.green.to_8bit(),
                    blue: color.blue.to_8bit(),
                    alpha: color.alpha as u8,
                };
                output.write(OscMessage {
                    addr: self.path.clone(),
                    args: vec![OscType::Color(color)],
                })?;
            }
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.path = config.path.clone();
        self.connection = config.connection.clone();
        self.argument_type = config.argument_type;
    }
}
