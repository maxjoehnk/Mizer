use mizer_node::edge::Edge;
use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

const LHS_INPUT: &str = "LHS";
const RHS_INPUT: &str = "RHS";
const VALUE_OUTPUT: &str = "Value";

#[derive(Default, Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct MathNode {
    pub mode: MathMode,
}

#[derive(Default, Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq)]
pub enum MathMode {
    #[default]
    Addition,
    Subtraction,
    Multiplication,
    Division,
}

impl PipelineNode for MathNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MathNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                LHS_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                RHS_INPUT.into(),
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
        NodeType::Math
    }
}

impl ProcessingNode for MathNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(lhs) = context.read_port::<_, f64>(LHS_INPUT) {
            if let Some(rhs) = context.read_port::<_, f64>(RHS_INPUT) {
                let value = match self.mode {
                    MathMode::Addition => lhs + rhs,
                    MathMode::Subtraction => lhs - rhs,
                    MathMode::Multiplication => lhs * rhs,
                    MathMode::Division => lhs / rhs,
                };
                context.write_port(VALUE_OUTPUT, value);
                context.push_history_value(value);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
