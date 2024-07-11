use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

const HUE_INPUT: &str = "Hue";
const SATURATION_INPUT: &str = "Saturation";
const VALUE_INPUT: &str = "Value";
const COLOR_OUTPUT: &str = "Color";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct HsvColorNode;

impl ConfigurableNode for HsvColorNode {}

impl PipelineNode for HsvColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "HSV Color".into(),
            preview_type: PreviewType::Color,
            category: NodeCategory::Color,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(HUE_INPUT, PortType::Single),
            input_port!(SATURATION_INPUT, PortType::Single),
            input_port!(VALUE_INPUT, PortType::Single),
            output_port!(COLOR_OUTPUT, PortType::Color),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorHsv
    }
}

impl ProcessingNode for HsvColorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let hue = context.read_port(HUE_INPUT);
        let saturation = context.read_port(SATURATION_INPUT);
        let value = context.read_port(VALUE_INPUT);

        let hsv = match (hue, saturation, value) {
            (Some(hue), Some(saturation), Some(value)) => Some((hue, saturation, value)),
            (Some(hue), Some(saturation), None) => Some((hue, saturation, 0f64)),
            (Some(hue), None, Some(value)) => Some((hue, 0f64, value)),
            (None, Some(saturation), Some(value)) => Some((0f64, saturation, value)),
            (Some(hue), None, None) => Some((hue, 0f64, 0f64)),
            (None, Some(saturation), None) => Some((0f64, saturation, 0f64)),
            (None, None, Some(value)) => Some((0f64, 0f64, value)),
            (None, None, None) => None,
        };

        if let Some((hue, saturation, value)) = hsv {
            let rgb = hsv_to_rgb(hue * 360f64, saturation, value);
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

    #[test_case(0f64, 0f64, 1f64, 1f64, 1f64, 1f64; "HSV(0, 0, 1)")]
    #[test_case(0f64, 0f64, 0f64, 0f64, 0f64, 0f64; "HSV(0, 0, 0)")]
    #[test_case(0f64, 1f64, 1f64, 1f64, 0f64, 0f64; "HSV(0, 1, 1)")]
    #[test_case(60f64 / 360f64, 1f64, 1f64, 1f64, 1f64, 0f64; "HSV(60, 1, 1)")]
    #[test_case(120f64 / 360f64, 1f64, 1f64, 0f64, 1f64, 0f64; "HSV(120, 1, 1)")]
    #[test_case(180f64 / 360f64, 1f64, 1f64, 0f64, 1f64, 1f64; "HSV(180, 1, 1)")]
    #[test_case(240f64 / 360f64, 1f64, 1f64, 0f64, 0f64, 1f64; "HSV(240, 1, 1)")]
    #[test_case(300f64 / 360f64, 1f64, 1f64, 1f64, 0f64, 1f64; "HSV(300, 1, 1)")]
    #[test_case(360f64 / 360f64, 1f64, 1f64, 1f64, 0f64, 0f64; "HSV(360, 1, 1)")]
    fn process_should_map_colors(
        hue: f64,
        saturation: f64,
        value: f64,
        red: f64,
        green: f64,
        blue: f64,
    ) -> anyhow::Result<()> {
        let node = HsvColorNode;
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame::default());
        context.when_read_port(HUE_INPUT).returns(Some(hue));
        context
            .when_read_port(SATURATION_INPUT)
            .returns(Some(saturation));
        context.when_read_port(VALUE_INPUT).returns(Some(value));

        node.process(&context, &mut state)?;

        context.expect_write_port(COLOR_OUTPUT, Color::rgb(red, green, blue));
        Ok(())
    }
}
