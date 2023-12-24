use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct MultiToDataNode;

impl ConfigurableNode for MultiToDataNode {}

impl PipelineNode for MultiToDataNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Multi to Data".into(),
            preview_type: PreviewType::Data,
            category: NodeCategory::Conversions,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VALUE_INPUT, PortType::Multi),
            output_port!(VALUE_OUTPUT, PortType::Data),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MultiToData
    }
}

impl ProcessingNode for MultiToDataNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let values = context.multi_input(VALUE_INPUT).read();

        if let Some(values) = values {
            let values = values.into_iter().map(|value| value.into()).collect();
            let data = StructuredData::Array(values);
            context.write_port(VALUE_OUTPUT, data.clone());
            context.write_data_preview(data);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
