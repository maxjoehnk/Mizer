use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::StructuredData;

const VALUE_PORT: &str = "Output";

const VALUE_SETTING: &str = "Value";

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct ValueNode {
    pub value: String,
}

impl Default for ValueNode {
    fn default() -> Self {
        Self {
            value: "{}".to_string(),
        }
    }
}

impl ConfigurableNode for ValueNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(VALUE_SETTING, &self.value).multiline()]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, VALUE_SETTING, self.value);

        update_fallback!(setting)
    }
}

impl PipelineNode for ValueNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ValueNode).into(),
            preview_type: PreviewType::Data,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_PORT, PortType::Data)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Value
    }
}

impl ProcessingNode for ValueNode {
    type State = Option<(String, StructuredData)>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some((raw, value)) = state.as_ref() {
            if raw == &self.value {
                context.write_port(VALUE_PORT, value.clone());
                context.write_data_preview(value.clone());
                return Ok(());
            }
        }

        let value: StructuredData = serde_json::from_str(&self.value)?;
        *state = Some((self.value.clone(), value.clone()));
        context.write_data_preview(value.clone());
        context.write_port(VALUE_PORT, value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        None
    }
}
