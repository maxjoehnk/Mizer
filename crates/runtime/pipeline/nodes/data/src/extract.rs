use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::StructuredData;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

const PATH_SETTING: &str = "Path";

#[derive(Default, Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExtractNode {
    pub path: String,
}

impl ConfigurableNode for ExtractNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(PATH_SETTING, &self.path)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, PATH_SETTING, self.path);

        update_fallback!(setting)
    }
}

impl PipelineNode for ExtractNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Extract".into(),
            preview_type: PreviewType::Data,
            category: NodeCategory::Data,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
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
}
