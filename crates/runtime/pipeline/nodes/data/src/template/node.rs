use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::StructuredData;

use super::engine::TemplateEngine;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

const TEMPLATE_SETTING: &str = "Template";

#[derive(Default, Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct TemplateNode {
    pub template: String,
}

impl ConfigurableNode for TemplateNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(TEMPLATE_SETTING, &self.template).multiline()]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, TEMPLATE_SETTING, self.template);

        update_fallback!(setting)
    }
}

impl PipelineNode for TemplateNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Template".into(),
            preview_type: PreviewType::Data,
            category: NodeCategory::Data,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Data, multiple),
            output_port!(OUTPUT_PORT, PortType::Data),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Template
    }
}

impl ProcessingNode for TemplateNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let data = context.read_ports::<_, StructuredData>(INPUT_PORT);

        let data = data.into_iter().flatten().collect();

        let data = TemplateEngine.template(&self.template, data)?;

        context.write_data_preview(data.clone());
        context.write_port(OUTPUT_PORT, data);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
