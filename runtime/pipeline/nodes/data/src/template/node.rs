use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::StructuredData;

use super::engine::TemplateEngine;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

#[derive(Default, Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct TemplateNode {
    pub template: String,
}

impl PipelineNode for TemplateNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(TemplateNode).into(),
            preview_type: PreviewType::Data,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                INPUT_PORT.into(),
                PortMetadata {
                    port_type: PortType::Data,
                    direction: PortDirection::Input,
                    multiple: Some(true),
                    ..Default::default()
                },
            ),
            (
                OUTPUT_PORT.into(),
                PortMetadata {
                    port_type: PortType::Data,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
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

    fn update(&mut self, config: &Self) {
        self.template = config.template.clone();
    }
}
