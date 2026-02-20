use serde::{Deserialize, Serialize};
use std::sync::Arc;

use mizer_node::*;
use mizer_util::*;

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct DataToTextNode;

impl ConfigurableNode for DataToTextNode {}

impl PipelineNode for DataToTextNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Data to Text".into(),
            preview_type: PreviewType::Data,
            category: NodeCategory::Conversions,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VALUE_INPUT, PortType::Data),
            output_port!(VALUE_OUTPUT, PortType::Text),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DataToText
    }
}

impl ProcessingNode for DataToTextNode {
    type State = Option<Arc<String>>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let data = context.data_input(VALUE_INPUT).read_changes();
        if let Some(StructuredData::Text(value)) = data.as_ref() {
            *state = Some(Arc::new(value.clone()));
            context.write_data_preview(data.unwrap());
        }

        if let Some(value) = state.clone() {
            context.write_port(VALUE_OUTPUT, value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
