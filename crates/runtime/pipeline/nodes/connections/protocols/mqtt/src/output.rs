use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_util::StructuredData;

use crate::MqttInjectorExt;

const VALUE_PORT: &str = "Input";

const CONNECTION_SETTING: &str = "Connection";
const PATH_SETTING: &str = "Path";
const RETAIN_SETTING: &str = "Retain";

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

impl ConfigurableNode for MqttOutputNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let connections = injector.get_connections();

        vec![
            setting!(select CONNECTION_SETTING, &self.connection, connections),
            setting!(PATH_SETTING, &self.path),
            setting!(RETAIN_SETTING, self.retain),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, CONNECTION_SETTING, self.connection);
        update!(text setting, PATH_SETTING, self.path);
        update!(bool setting, RETAIN_SETTING, self.retain);

        update_fallback!(setting)
    }
}

impl PipelineNode for MqttOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "MQTT Output".into(),
            preview_type: PreviewType::Data,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(VALUE_PORT, PortType::Data)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MqttOutput
    }
}

impl ProcessingNode for MqttOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = context.read_port_changes::<_, StructuredData>(VALUE_PORT);
        let connection_manager = context.try_inject::<MqttConnectionManager>();
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
}
