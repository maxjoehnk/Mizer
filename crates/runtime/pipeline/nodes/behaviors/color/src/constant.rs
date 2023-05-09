use serde::{Deserialize, Serialize};

use mizer_node::*;

const COLOR_OUTPUT: &str = "Color";

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub enum ConstantColorNode {
    Rgb {
        red: f64,
        green: f64,
        blue: f64,
    },
    Hsv {
        hue: f64,
        saturation: f64,
        value: f64,
    },
}

impl Default for ConstantColorNode {
    fn default() -> Self {
        Self::Rgb {
            red: 0.,
            green: 0.,
            blue: 0.,
        }
    }
}

impl PipelineNode for ConstantColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ConstantColorNode).into(),
            preview_type: PreviewType::Color,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(COLOR_OUTPUT, PortType::Color)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorConstant
    }
}

impl ProcessingNode for ConstantColorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let value = match *self {
            Self::Rgb { red, green, blue } => Color::rgb(red, green, blue),
            Self::Hsv {
                hue,
                saturation,
                value,
            } => Color::hsv(hue, saturation, value),
        };

        context.write_port(COLOR_OUTPUT, value);
        context.write_color_preview(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        *self = *config;
    }
}
