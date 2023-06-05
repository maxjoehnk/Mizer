use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct DataToNumberNode;

impl ConfigurableNode for DataToNumberNode {}

impl PipelineNode for DataToNumberNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Data to Number".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Conversions,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VALUE_INPUT, PortType::Data),
            output_port!(VALUE_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DataToNumber
    }
}

impl ProcessingNode for DataToNumberNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let data = context.read_port::<_, StructuredData>(VALUE_INPUT);
        let value = match data {
            Some(StructuredData::Float(value)) => Some(value),
            Some(StructuredData::Int(value)) => Some(value as f64),
            _ => None,
        };

        if let Some(value) = value {
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
