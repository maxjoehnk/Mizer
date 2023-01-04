use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

const CONDITION_INPUT: &str = "Condition";
const VALUE_INPUT: &str = "Value";
const VALUE_OUTPUT: &str = "Value";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct ConditionalNode {
    pub threshold: f64,
}

impl Default for ConditionalNode {
    fn default() -> Self {
        Self { threshold: 0.5 }
    }
}

impl PipelineNode for ConditionalNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ConditionalNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                CONDITION_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                VALUE_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                VALUE_OUTPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Conditional
    }
}

impl ProcessingNode for ConditionalNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(condition) = context.read_port::<_, f64>(CONDITION_INPUT) {
            if condition >= self.threshold {
                if let Some(value) = context.read_port(VALUE_INPUT) {
                    context.write_port(VALUE_OUTPUT, value);
                    context.push_history_value(value);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.threshold = config.threshold;
    }
}
