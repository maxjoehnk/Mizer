use std::str::FromStr;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_connections::{ConnectionStorage, OscConnectionExt, StableConnectionId, OscSubscription, OscType, OscMessage, OscColor};
use mizer_util::{ConvertPercentages, StructuredData};

use crate::{OscArgumentType, OscInjectorExt};

const CONNECTION_SETTING: &str = "Connection";
const ARGUMENT_TYPE_SETTING: &str = "Argument Type";
const PATH_SETTING: &str = "Path";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct OscInputNode {
    pub connection: String,
    pub path: String,
    #[serde(default = "default_argument_type")]
    pub argument_type: OscArgumentType,
}

fn default_argument_type() -> OscArgumentType {
    OscArgumentType::Float
}

impl Default for OscInputNode {
    fn default() -> Self {
        Self {
            connection: Default::default(),
            argument_type: default_argument_type(),
            path: "".into(),
        }
    }
}

impl ConfigurableNode for OscInputNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let connections = injector.get_connections();

        vec![
            setting!(select CONNECTION_SETTING, &self.connection, connections),
            setting!(enum ARGUMENT_TYPE_SETTING, self.argument_type),
            setting!(PATH_SETTING, &self.path),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, CONNECTION_SETTING, self.connection);
        update!(enum setting, ARGUMENT_TYPE_SETTING, self.argument_type);
        update!(text setting, PATH_SETTING, self.path);

        update_fallback!(setting)
    }
}

impl PipelineNode for OscInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "OSC Input".into(),
            preview_type: match self.argument_type {
                OscArgumentType::Color => PreviewType::Color,
                OscArgumentType::String => PreviewType::Data,
                _ => PreviewType::History,
            },
            category: NodeCategory::Connections,
        }
    }

    fn display_name(&self, _injector: &ReadOnlyInjectionScope) -> String {
        format!("OSC Input ({})", self.path)
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(
            self.argument_type.get_port_id(),
            self.argument_type.get_port_type()
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscInput
    }
}

impl ProcessingNode for OscInputNode {
    type State = Option<OscSubscription>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let connection_manager = self.get_connection_manager(context);
        if state.is_none() {
            let id = StableConnectionId::from_str(&self.connection)?;
            *state = connection_manager.subscribe(&id)?;
        }
        if let Some(msg) = state
            .as_ref()
            .and_then(|subscription| subscription.next_event(&self.path))
        {
            self.handle_msg(msg, context);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl OscInputNode {
    fn get_connection_manager<'a>(
        &self,
        context: &'a impl NodeContext,
    ) -> &'a ConnectionStorage {
        context.inject::<ConnectionStorage>()
    }

    fn handle_msg(&self, mut msg: OscMessage, context: &impl NodeContext) {
        tracing::trace!("{:?}", msg);
        if msg.args.is_empty() {
            return;
        }
        if self.argument_type.is_numeric() {
            match &msg.args[0] {
                OscType::Float(float) => self.write_number(context, *float as f64),
                OscType::Double(double) => self.write_number(context, *double),
                OscType::Int(int) => self.write_number(context, *int as f64),
                OscType::Long(value) => self.write_number(context, *value as f64),
                OscType::Bool(value) => self.write_number(context, if *value { 1. } else { 0. }),
                _ => {}
            }
        }
        if self.argument_type.is_color() {
            if let OscType::Color(color) = &msg.args[0] {
                self.write_color(context, color);
            }
        }
        if self.argument_type.is_data() {
            if let OscType::String(text) = msg.args.swap_remove(0) {
                let data = StructuredData::Text(text);
                self.write_data(context, data);
            }
        }
    }

    fn write_number(&self, context: &impl NodeContext, value: f64) {
        context.write_port(self.argument_type.get_port_id(), value);
        context.push_history_value(value);
    }

    fn write_color(&self, context: &impl NodeContext, color: &OscColor) {
        let color = Color {
            red: color.red.to_percentage(),
            green: color.green.to_percentage(),
            blue: color.blue.to_percentage(),
            alpha: color.alpha.to_percentage(),
        };
        context.write_color_preview(color);
        context.write_port(self.argument_type.get_port_id(), color);
    }

    fn write_data(&self, context: &impl NodeContext, data: StructuredData) {
        context.write_data_preview(data.clone());
        context.write_port(self.argument_type.get_port_id(), data);
    }
}
