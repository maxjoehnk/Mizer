use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct RgbColorNode;

impl PipelineNode for RgbColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "RgbColorNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "Red".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "Green".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "Blue".into(),
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
        NodeType::ColorRgb
    }
}

impl ProcessingNode for RgbColorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let red = context.read_port("Red");
        let green = context.read_port("Green");
        let blue = context.read_port("Blue");

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
        context.when_read_port("Red").returns(Some(red));
        context.when_read_port("Green").returns(Some(green));
        context.when_read_port("Blue").returns(Some(blue));

        node.process(&context, &mut state)?;

        context.expect_write_port("Color", Color::rgb(red, green, blue));
        Ok(())
    }
}
