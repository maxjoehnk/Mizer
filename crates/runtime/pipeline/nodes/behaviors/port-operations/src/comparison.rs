use serde::{Deserialize, Serialize};

use mizer_node::*;

const LHS_INPUT: &str = "LHS";
const RHS_INPUT: &str = "RHS";

const RESULT_OUTPUT: &str = "Result";

#[derive(Debug, Default, Clone, Copy, PartialEq, Deserialize, Serialize)]
pub struct ComparisonNode {}

impl ConfigurableNode for ComparisonNode {}

impl PipelineNode for ComparisonNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Comparison".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(LHS_INPUT, PortType::Data),
            input_port!(RHS_INPUT, PortType::Data),
            output_port!(RESULT_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Comparison
    }
}

impl ProcessingNode for ComparisonNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let lhs = context.read_port::<_, port_types::DATA>(LHS_INPUT);
        let rhs = context.read_port::<_, port_types::DATA>(RHS_INPUT);

        if let (Some(lhs), Some(rhs)) = (lhs, rhs) {
            let result = lhs == rhs;
            let result: port_types::SINGLE = result.into();
            context.write_port(RESULT_OUTPUT, result);
            context.push_history_value(result);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
