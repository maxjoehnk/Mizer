use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

const COLOR_INPUT: &str = "Color";

const HUE_OUTPUT: &str = "Hue";
const SATURATION_OUTPUT: &str = "Saturation";
const VALUE_OUTPUT: &str = "Value";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct ColorToHsvNode;

impl ConfigurableNode for ColorToHsvNode {}

impl PipelineNode for ColorToHsvNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Color to HSV".into(),
            preview_type: PreviewType::Color,
            category: NodeCategory::Color,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(COLOR_INPUT, PortType::Color),
            output_port!(HUE_OUTPUT, PortType::Single),
            output_port!(SATURATION_OUTPUT, PortType::Single),
            output_port!(VALUE_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorToHsv
    }
}

impl ProcessingNode for ColorToHsvNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(color) = context.read_port::<_, Color>(COLOR_INPUT) {
            let (hue, saturation, value) = rgb_to_hsv(color.red, color.green, color.blue);

            context.write_port(HUE_OUTPUT, hue / 360f64);
            context.write_port(SATURATION_OUTPUT, saturation);
            context.write_port(VALUE_OUTPUT, value);

            context.write_color_preview(color);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
