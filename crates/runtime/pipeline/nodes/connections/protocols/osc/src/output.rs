use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_osc::*;
use mizer_util::{ConvertBytes, StructuredData};

use crate::argument_type::OscArgumentType;
use crate::OscInjectorExt;

const CONNECTION_SETTING: &str = "Connection";
const ARGUMENT_TYPE_SETTING: &str = "Argument Type";
const PATH_SETTING: &str = "Path";
const ONLY_EMIT_CHANGES_SETTING: &str = "Only emit changes";

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

impl ConfigurableNode for OscOutputNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let connections = injector.get_connections();

        vec![
            setting!(select CONNECTION_SETTING, &self.connection, connections),
            setting!(enum ARGUMENT_TYPE_SETTING, self.argument_type),
            setting!(PATH_SETTING, &self.path),
            setting!(ONLY_EMIT_CHANGES_SETTING, self.only_emit_changes),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, CONNECTION_SETTING, self.connection);
        update!(enum setting, ARGUMENT_TYPE_SETTING, self.argument_type);
        update!(text setting, PATH_SETTING, self.path);
        update!(bool setting, ONLY_EMIT_CHANGES_SETTING, self.only_emit_changes);

        update_fallback!(setting)
    }
}

impl PipelineNode for OscOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "OSC Output".into(),
            preview_type: match self.argument_type {
                OscArgumentType::Color => PreviewType::Color,
                OscArgumentType::String => PreviewType::Data,
                _ => PreviewType::History,
            },
            category: NodeCategory::Connections,
        }
    }

    fn display_name(&self, _injector: &Injector) -> String {
        format!("OSC Output ({})", self.path)
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
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
        let connection_manager = context.try_inject::<OscConnectionManager>();
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
            // FIXME: only_emit_changes is implemented inversely here, as we want to emit the value only if it has changed
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
                context.write_color_preview(color);
                let color = OscColor {
                    red: color.red.to_8bit(),
                    green: color.green.to_8bit(),
                    blue: color.blue.to_8bit(),
                    alpha: color.alpha.to_8bit(),
                };
                output.write(OscMessage {
                    addr: self.path.clone(),
                    args: vec![OscType::Color(color)],
                })?;
            }
        }
        if self.argument_type.is_data() {
            let value = if self.only_emit_changes {
                context.read_port::<_, port_types::DATA>(self.argument_type.get_port_id())
            } else {
                context.read_port_changes::<_, port_types::DATA>(self.argument_type.get_port_id())
            };
            if let Some(data) = value {
                context.write_data_preview(data.clone());
                output.write(OscMessage {
                    addr: self.path.clone(),
                    args: map_data_to_osc(data),
                })?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn map_data_to_osc(data: StructuredData) -> Vec<OscType> {
    match data {
        StructuredData::Text(text) => vec![OscType::String(text)],
        StructuredData::Boolean(boolean) => vec![OscType::Bool(boolean)],
        StructuredData::Float(number) => vec![OscType::Double(number)],
        StructuredData::Int(number) => vec![OscType::Long(number)],
        StructuredData::Array(items) => items.into_iter().map(map_data_to_osc).flatten().collect(),
        StructuredData::Object(items) => items
            .into_iter()
            .map(|(key, value)| {
                let mut result = map_data_to_osc(value);
                result.insert(0, OscType::String(key));
                result
            })
            .flatten()
            .collect(),
    }
}
