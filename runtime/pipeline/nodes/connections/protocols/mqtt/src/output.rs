use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_util::StructuredData;

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct MqttOutputNode {
    pub path: String,
    pub connection: String,
    #[serde(default)]
    pub retain: bool,
}

impl Default for MqttOutputNode {
    fn default() -> Self {
        Self {
            path: "/".to_string(),
            connection: Default::default(),
            retain: false,
        }
    }
}

impl PipelineNode for MqttOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(MqttOutputNode).into(),
            preview_type: PreviewType::Data,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("value", PortType::Data)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MqttOutput
    }
}

impl ProcessingNode for MqttOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = context.read_port_changes::<_, StructuredData>("value");
        let connection_manager = context.inject::<MqttConnectionManager>();
        if connection_manager.is_none() {
            anyhow::bail!("Missing mqtt module");
        }
        let connection_manager = connection_manager.unwrap();

        if let Some(value) = value {
            if let Some(output) = connection_manager.get_output(&self.connection) {
                output.write(self.path.clone(), value.clone(), self.retain)?;
            }
            context.write_data_preview(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.connection = config.connection.clone();
        self.path = config.path.clone();
        self.retain = config.retain;
    }
}
