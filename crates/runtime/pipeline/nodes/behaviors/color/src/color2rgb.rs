use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

const COLOR_INPUT: &str = "Color";

const RED_OUTPUT: &str = "Red";
const GREEN_OUTPUT: &str = "Green";
const BLUE_OUTPUT: &str = "Blue";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct ColorToRgbNode;

impl ConfigurableNode for ColorToRgbNode {}

impl PipelineNode for ColorToRgbNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Color to RGB".into(),
            preview_type: PreviewType::Color,
            category: NodeCategory::Color,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(COLOR_INPUT, PortType::Color),
            output_port!(RED_OUTPUT, PortType::Single),
            output_port!(GREEN_OUTPUT, PortType::Single),
            output_port!(BLUE_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorToRgb
    }
}

impl ProcessingNode for ColorToRgbNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(color) = context.read_port::<_, Color>(COLOR_INPUT) {
            context.write_port(RED_OUTPUT, color.red);
            context.write_port(GREEN_OUTPUT, color.green);
            context.write_port(BLUE_OUTPUT, color.blue);

            context.write_color_preview(color);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
