use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::StructuredData;

const VALUE_PORT: &str = "value";

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

impl PipelineNode for ValueNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ValueNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            VALUE_PORT.into(),
            PortMetadata {
                port_type: PortType::Data,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
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
                return Ok(());
            }
        }

        let value: StructuredData = serde_json::from_str(&self.value)?;
        *state = Some((self.value.clone(), value.clone()));
        context.write_port(VALUE_PORT, value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        None
    }
}
