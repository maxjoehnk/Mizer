use serde::{Deserialize, Serialize};

use mizer_node::*;

const VALUE_PORT: &str = "Value";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct ConstantNumberNode {
    pub value: f64,
}

impl PipelineNode for ConstantNumberNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(NumberConstantNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ConstantNumber
    }
}

impl ProcessingNode for ConstantNumberNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let value = self.value;

        context.write_port(VALUE_PORT, value);
        context.push_history_value(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.value = config.value;
    }
}
