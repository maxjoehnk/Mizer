use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Debug, Copy, Clone, Deserialize, Serialize, PartialEq, Eq)]
#[serde(rename_all = "kebab-case")]
pub enum Pattern {
    RgbIterate,
    RgbSnake,
}

impl Default for Pattern {
    fn default() -> Self {
        Pattern::RgbIterate
    }
}

pub enum PatternState {
    Iterate {
        index: usize,
        color: (f64, f64, f64),
    },
}

impl Default for PatternState {
    fn default() -> Self {
        PatternState::Iterate {
            index: 0,
            color: (1., 0., 0.),
        }
    }
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct PixelPatternGeneratorNode {
    pub pattern: Pattern,
}

#[derive(Default)]
pub struct PixelPatternGeneratorState {
    pixels: Vec<(f64, f64, f64)>,
    pattern: PatternState,
}

impl PipelineNode for PixelPatternGeneratorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "PixelPatternGeneratorNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "output".into(),
            PortMetadata {
                port_type: PortType::Multi,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PixelPattern
    }
}

impl ProcessingNode for PixelPatternGeneratorNode {
    type State = PixelPatternGeneratorState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some((width, height)) = context.output_port("output").and_then(|port| port.dimensions) else {
            return Ok(());
        };

        let pixel_count = width * height;
        if pixel_count != state.pixels.len() as u64 {
            state.pixels.resize(pixel_count as usize, (0., 0., 0.));
        }
        if let (Pattern::RgbIterate, PatternState::Iterate { index, color }) =
            (&self.pattern, &mut state.pattern)
        {
            if (*index) as u64 == pixel_count {
                *index = 0;
                next_color(color);
            }
            state.pixels[*index] = *color;
            *index += 1;
        }

        let data = state
            .pixels
            .iter()
            .flat_map(|(r, g, b)| vec![*r, *g, *b])
            .collect();
        context.write_port::<_, Vec<f64>>("output", data);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.pattern = config.pattern;
    }
}

fn next_color(color: &mut (f64, f64, f64)) {
    let data = (color.0, color.1, color.2);
    *color = match data {
        data if matches(data, (0., 0., 0.)) => (1., 0., 0.),
        data if matches(data, (1., 0., 0.)) => (0., 1., 0.),
        data if matches(data, (0., 1., 0.)) => (0., 0., 1.),
        data if matches(data, (0., 0., 1.)) => (1., 1., 0.),
        data if matches(data, (1., 1., 0.)) => (0., 1., 1.),
        data if matches(data, (0., 1., 1.)) => (1., 1., 1.),
        data if matches(data, (1., 1., 1.)) => (0., 0., 0.),
        _ => unreachable!(),
    };
}

fn matches(color: (f64, f64, f64), expected: (f64, f64, f64)) -> bool {
    compare_float(color.0, expected.0)
        && compare_float(color.1, expected.1)
        && compare_float(color.2, expected.2)
}

fn compare_float(left: f64, right: f64) -> bool {
    (left - right).abs() < f64::EPSILON
}
