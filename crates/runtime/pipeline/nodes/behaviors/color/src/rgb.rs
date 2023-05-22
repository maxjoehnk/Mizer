use serde::{Deserialize, Serialize};

use mizer_node::*;

const RED_INPUT: &str = "Red";
const GREEN_INPUT: &str = "Green";
const BLUE_INPUT: &str = "Blue";
const COLOR_OUTPUT: &str = "Color";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct RgbColorNode;

impl ConfigurableNode for RgbColorNode {}

impl PipelineNode for RgbColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(RgbColorNode).into(),
            preview_type: PreviewType::Color,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(RED_INPUT, PortType::Single),
            input_port!(GREEN_INPUT, PortType::Single),
            input_port!(BLUE_INPUT, PortType::Single),
            output_port!(COLOR_OUTPUT, PortType::Color),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorRgb
    }
}

impl ProcessingNode for RgbColorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let red = context.read_port(RED_INPUT);
        let green = context.read_port(GREEN_INPUT);
        let blue = context.read_port(BLUE_INPUT);

        let rgb = match (red, green, blue) {
            (Some(red), Some(green), Some(blue)) => Some((red, green, blue)),
            (Some(red), Some(green), None) => Some((red, green, 0f64)),
            (Some(red), None, Some(blue)) => Some((red, 0f64, blue)),
            (None, Some(green), Some(blue)) => Some((0f64, green, blue)),
            (Some(red), None, None) => Some((red, 0f64, 0f64)),
            (None, Some(green), None) => Some((0f64, green, 0f64)),
            (None, None, Some(blue)) => Some((0f64, 0f64, blue)),
            (None, None, None) => None,
        };

        if let Some(rgb) = rgb {
            let color = Color::from(rgb);
            context.write_color_preview(color);
            context.write_port(COLOR_OUTPUT, color);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use mizer_node::mocks::*;

    use super::*;

    #[test_case(1f64, 1f64, 1f64)]
    #[test_case(0f64, 0f64, 0f64)]
    #[test_case(1f64, 0f64, 0f64)]
    #[test_case(0f64, 1f64, 0f64)]
    #[test_case(0f64, 0f64, 1f64)]
    fn process_should_map_colors(red: f64, green: f64, blue: f64) -> anyhow::Result<()> {
        let node = RgbColorNode;
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame::default());
        context.when_read_port(RED_INPUT).returns(Some(red));
        context.when_read_port(GREEN_INPUT).returns(Some(green));
        context.when_read_port(BLUE_INPUT).returns(Some(blue));

        node.process(&context, &mut state)?;

        context.expect_write_port(COLOR_OUTPUT, Color::rgb(red, green, blue));
        Ok(())
    }
}
