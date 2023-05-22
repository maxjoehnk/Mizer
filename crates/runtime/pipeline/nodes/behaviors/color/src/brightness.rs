use serde::{Deserialize, Serialize};

use mizer_node::*;

const BRIGHTNESS_INPUT: &str = "Brightness";
const COLOR_INPUT: &str = "Input";
const COLOR_OUTPUT: &str = "Output";

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct ColorBrightnessNode;

impl ConfigurableNode for ColorBrightnessNode {}

impl PipelineNode for ColorBrightnessNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ColorBrightnessNode).into(),
            preview_type: PreviewType::Color,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(BRIGHTNESS_INPUT, PortType::Single),
            input_port!(COLOR_INPUT, PortType::Color),
            output_port!(COLOR_OUTPUT, PortType::Color),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorBrightness
    }
}

impl ProcessingNode for ColorBrightnessNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = Self::calculate(context) {
            context.write_port(COLOR_OUTPUT, value);
            context.write_color_preview(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl ColorBrightnessNode {
    fn calculate(context: &impl NodeContext) -> Option<Color> {
        let color = context.read_port::<_, Color>(COLOR_INPUT)?;
        let brightness = context.read_port::<_, f64>(BRIGHTNESS_INPUT).unwrap_or(1.0);

        Some(color * brightness)
    }
}
