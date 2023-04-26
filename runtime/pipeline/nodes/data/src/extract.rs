use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::StructuredData;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

#[derive(Default, Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExtractNode {
    pub path: String,
}

impl PipelineNode for ExtractNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ExtractNode).into(),
            preview_type: PreviewType::Data,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Data),
            output_port!(OUTPUT_PORT, PortType::Data),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Extract
    }
}

impl ProcessingNode for ExtractNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(data) = context.read_port::<_, StructuredData>(INPUT_PORT) {
            if let Some(value) = data.access(&self.path) {
                context.write_port(OUTPUT_PORT, value.clone());
                context.write_data_preview(value.clone());
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.path = config.path.clone();
    }
}
