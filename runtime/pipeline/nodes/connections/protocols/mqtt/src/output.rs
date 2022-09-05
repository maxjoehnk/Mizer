use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_util::StructuredData;

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct MqttOutputNode {
    pub path: String,
    pub connection: String,
}

impl Default for MqttOutputNode {
    fn default() -> Self {
        Self {
            path: "/".to_string(),
            connection: Default::default(),
        }
    }
}

impl PipelineNode for MqttOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MqttOutputNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "value".into(),
            PortMetadata {
                port_type: PortType::Data,
                direction: PortDirection::Input,
                ..Default::default()
            },
        )]
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
                output.write(self.path.clone(), value)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
