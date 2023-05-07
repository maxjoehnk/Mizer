use super::PatternImpl;
use crate::pattern::PixelGrid;
use mizer_node::Color;

pub struct RgbIteratePattern {
    index: usize,
    color: (f64, f64, f64),
}

impl Default for RgbIteratePattern {
    fn default() -> Self {
        Self {
            index: 0,
            color: (1., 0., 0.),
        }
    }
}

impl PatternImpl for RgbIteratePattern {
    fn next(&mut self, mut pixels: PixelGrid, _color: &Color) {
        let pixel_count = pixels.len();
        if self.index == pixel_count {
            self.index = 0;
            next_color(&mut self.color);
        }
        pixels[self.index] = self.color;
        self.index += 1;
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
