use serde::{Deserialize, Serialize};

use crate::OscArgumentType;
use mizer_node::*;
use mizer_protocol_osc::*;
use mizer_util::ConvertPercentages;

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

impl PipelineNode for OscInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(OscInputNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
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
            *state = connection_manager.subscribe(&self.connection)?;
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

    fn update(&mut self, config: &Self) {
        self.path = config.path.clone();
        self.connection = config.connection.clone();
        self.argument_type = config.argument_type;
    }
}

impl OscInputNode {
    fn get_connection_manager<'a>(
        &self,
        context: &'a impl NodeContext,
    ) -> &'a OscConnectionManager {
        let connection_manager = context.inject::<OscConnectionManager>();

        connection_manager.expect("Missing osc module")
    }

    fn handle_msg(&self, msg: OscMessage, context: &impl NodeContext) {
        log::trace!("{:?}", msg);
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
    }

    fn write_number(&self, context: &impl NodeContext, value: f64) {
        context.write_port(self.argument_type.get_port_id(), value);
        context.push_history_value(value);
    }

    fn write_color(&self, context: &impl NodeContext, color: &OscColor) {
        context.write_port(
            self.argument_type.get_port_id(),
            Color {
                red: color.red.to_percentage(),
                green: color.green.to_percentage(),
                blue: color.blue.to_percentage(),
                alpha: color.alpha.to_percentage(),
            },
        );
    }
}
