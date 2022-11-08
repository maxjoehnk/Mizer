use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct HsvColorNode;

impl PipelineNode for HsvColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "HsvColorNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "Hue".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "Saturation".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "Value".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "Color".into(),
                PortMetadata {
                    port_type: PortType::Color,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorHsv
    }
}

impl ProcessingNode for HsvColorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let hue = context.read_port("Hue");
        let saturation = context.read_port("Saturation");
        let value = context.read_port("Value");

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
            context.write_port("Color", Color::from(rgb));
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}
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
        context.when_read_port("Hue").returns(Some(hue));
        context
            .when_read_port("Saturation")
            .returns(Some(saturation));
        context.when_read_port("Value").returns(Some(value));

        node.process(&context, &mut state)?;

        context.expect_write_port("Color", Color::rgb(red, green, blue));
        Ok(())
    }
}
