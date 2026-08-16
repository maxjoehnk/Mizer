use mizer_node::*;
use serde::{Deserialize, Serialize};

const INPUT_PORT: &str = "Input";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct LevelNode {}

impl ConfigurableNode for LevelNode {}

impl PipelineNode for LevelNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Level".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Level
    }
}

impl ProcessingNode for LevelNode {
    type State = f64;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.single_input(INPUT_PORT).read() {
            context.push_history_value(value);
            *state = value;
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl LevelNode {
    pub fn value(&self, state: &<Self as ProcessingNode>::State) -> f64 {
        *state
    }
}
