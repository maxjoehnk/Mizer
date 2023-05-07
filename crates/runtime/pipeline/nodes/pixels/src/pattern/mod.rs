use serde::{Deserialize, Serialize};
use std::ops::{Index, IndexMut};

use self::rgb_iterate::RgbIteratePattern;
use crate::pattern::swirl::SwirlPattern;
use mizer_node::*;

mod rgb_iterate;
mod swirl;

const COLOR_INPUT: &str = "Color";
const OUTPUT_PORT: &str = "Output";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct PixelPatternGeneratorNode {
    pub pattern: Pattern,
}

#[derive(Debug, Default, Copy, Clone, Deserialize, Serialize, PartialEq, Eq)]
#[serde(rename_all = "kebab-case")]
pub enum Pattern {
    #[default]
    RgbIterate,
    Swirl,
}

impl PipelineNode for PixelPatternGeneratorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(PixelPatternGeneratorNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(COLOR_INPUT, PortType::Color),
            output_port!(OUTPUT_PORT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PixelPattern
    }
}

impl ProcessingNode for PixelPatternGeneratorNode {
    type State = PatternState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some((width, height)) = context.output_port(OUTPUT_PORT).and_then(|port| port.dimensions) else {
            return Ok(());
        };
        let width = width as usize;
        let height = height as usize;
        let color = context
            .read_port::<_, Color>(COLOR_INPUT)
            .unwrap_or(Color::WHITE);

        let pixel_count = width * height;
        let mut pixels = vec![(0., 0., 0.); pixel_count];
        self.check_state(state);
        let grid = PixelGrid {
            pixels: &mut pixels,
            width,
            height,
        };
        state.next(grid, &color);

        let data = pixels
            .iter()
            .flat_map(|(r, g, b)| vec![*r, *g, *b])
            .collect();
        context.write_port::<_, Vec<f64>>(OUTPUT_PORT, data);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.pattern = config.pattern;
    }
}

impl PixelPatternGeneratorNode {
    fn check_state(&self, state: &mut PatternState) {
        match (&self.pattern, state) {
            (Pattern::RgbIterate, PatternState::Iterate(_)) => {}
            (Pattern::Swirl, PatternState::Swirl(_)) => {}
            (_, pattern) => {
                *pattern = self.pattern.into();
            }
        };
    }
}

pub enum PatternState {
    Iterate(RgbIteratePattern),
    Swirl(SwirlPattern),
}

impl PatternImpl for PatternState {
    fn next(&mut self, pixels: PixelGrid, color: &Color) {
        match self {
            Self::Iterate(pattern) => pattern.next(pixels, color),
            Self::Swirl(pattern) => pattern.next(pixels, color),
        }
    }
}

impl Default for PatternState {
    fn default() -> Self {
        Self::Iterate(Default::default())
    }
}

pub(crate) trait PatternImpl {
    fn next(&mut self, pixels: PixelGrid, color: &Color);
}

impl From<Pattern> for PatternState {
    fn from(value: Pattern) -> Self {
        match value {
            Pattern::RgbIterate => PatternState::Iterate(Default::default()),
            Pattern::Swirl => PatternState::Swirl(Default::default()),
        }
    }
}

pub(crate) struct PixelGrid<'a> {
    pixels: &'a mut [(f64, f64, f64)],
    width: usize,
    height: usize,
}

impl<'a> PixelGrid<'a> {
    pub fn new(pixels: &'a mut [(f64, f64, f64)], (width, height): (usize, usize)) -> Self {
        Self {
            pixels,
            width,
            height,
        }
    }

    fn get_index(&self, x: usize, y: usize) -> usize {
        x + (self.width * y)
    }

    pub fn len(&self) -> usize {
        self.pixels.len()
    }

    pub fn width(&self) -> usize {
        self.width
    }

    pub fn height(&self) -> usize {
        self.height
    }

    pub fn iter(&self) -> impl Iterator<Item = &(f64, f64, f64)> {
        self.pixels.iter()
    }
}

impl<'a> Index<usize> for PixelGrid<'a> {
    type Output = (f64, f64, f64);

    fn index(&self, index: usize) -> &Self::Output {
        &self.pixels[index]
    }
}

impl<'a> IndexMut<usize> for PixelGrid<'a> {
    fn index_mut(&mut self, index: usize) -> &mut Self::Output {
        &mut self.pixels[index]
    }
}

impl<'a> Index<(usize, usize)> for PixelGrid<'a> {
    type Output = (f64, f64, f64);

    fn index(&self, (x, y): (usize, usize)) -> &Self::Output {
        let index = self.get_index(x, y);
        &self.pixels[index]
    }
}

impl<'a> IndexMut<(usize, usize)> for PixelGrid<'a> {
    fn index_mut(&mut self, (x, y): (usize, usize)) -> &mut Self::Output {
        let index = self.get_index(x, y);
        &mut self.pixels[index]
    }
}

#[cfg(test)]
mod tests {
    use crate::pattern::PixelGrid;
    use test_case::test_case;

    #[test_case((0, 0), 0, (2, 2))]
    #[test_case((1, 0), 1, (2, 2))]
    #[test_case((0, 1), 2, (2, 2))]
    #[test_case((1, 1), 3, (2, 2))]
    #[test_case((0, 0), 0, (3, 3))]
    #[test_case((1, 0), 1, (3, 3))]
    #[test_case((2, 0), 2, (3, 3))]
    #[test_case((0, 1), 3, (3, 3))]
    #[test_case((1, 1), 4, (3, 3))]
    #[test_case((2, 1), 5, (3, 3))]
    #[test_case((0, 2), 6, (3, 3))]
    #[test_case((1, 2), 7, (3, 3))]
    #[test_case((2, 2), 8, (3, 3))]
    fn get_index_should_return_index_for_coordinates(
        (x, y): (usize, usize),
        expected: usize,
        (width, height): (usize, usize),
    ) {
        let mut pixels = vec![Default::default(); width * height];
        let grid = PixelGrid::new(&mut pixels, (width, height));

        let result = grid.get_index(x, y);

        assert_eq!(expected, result);
    }
}
