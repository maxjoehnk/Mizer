use super::PatternImpl;
use crate::pattern::PixelGrid;
use mizer_node::Color;
use std::ops::{ControlFlow, Range, RangeBounds, RangeInclusive};

#[derive(Default)]
pub struct SwirlPattern {
    index: usize,
}

impl PatternImpl for SwirlPattern {
    fn next(&mut self, mut pixels: PixelGrid, color: &Color) {
        self.index += 1;

        if self.index > pixels.len() {
            self.index = 1;
        }

        self.run(&mut pixels, color);
    }
}

impl SwirlPattern {
    fn run(&self, pixels: &mut PixelGrid, color: &Color) -> ControlFlow<()> {
        let width = pixels.width();
        let height = pixels.height();

        let mut i = 0;
        let mut layer = 0;
        while i < self.index {
            let x1 = layer;
            let y1 = layer;
            let x2 = width.saturating_sub(layer).saturating_sub(1);
            let y2 = height.saturating_sub(layer).saturating_sub(1);

            self.apply_pixel_column(pixels, &mut i, y1..=y2, x1, color, false)?;
            self.apply_pixel_row(pixels, &mut i, x1..=x2, y2, color, false)?;
            self.apply_pixel_column(pixels, &mut i, y1..=y2, x2, color, true)?;
            self.apply_pixel_row(pixels, &mut i, x1..=x2, y1, color, true)?;

            layer += 1;

            if i == 0 {
                break;
            }
        }

        ControlFlow::Continue(())
    }

    #[must_use]
    fn apply_pixel_row(
        &self,
        pixels: &mut PixelGrid,
        i: &mut usize,
        range: RangeInclusive<usize>,
        y: usize,
        color: &Color,
        reverse: bool,
    ) -> ControlFlow<()> {
        self.apply_pixels(pixels, i, range, |x| (x, y), color, reverse)
    }

    #[must_use]
    fn apply_pixel_column(
        &self,
        pixels: &mut PixelGrid,
        i: &mut usize,
        range: RangeInclusive<usize>,
        x: usize,
        color: &Color,
        reverse: bool,
    ) -> ControlFlow<()> {
        self.apply_pixels(pixels, i, range, |y| (x, y), color, reverse)
    }

    fn apply_pixels(
        &self,
        pixels: &mut PixelGrid,
        i: &mut usize,
        range: RangeInclusive<usize>,
        position: impl Fn(usize) -> (usize, usize),
        color: &Color,
        reverse: bool,
    ) -> ControlFlow<()> {
        let range_iter: Box<dyn Iterator<Item = usize>> = if reverse {
            Box::new(range.rev())
        } else {
            Box::new(range)
        };
        for j in range_iter {
            pixels[position(j)] = (*color).into();
            *i += 1;
            if *i >= self.index {
                return ControlFlow::Break(());
            }
        }
        *i = i.saturating_sub(1);

        ControlFlow::Continue(())
    }
}

#[cfg(test)]
mod tests {
    use crate::pattern::swirl::SwirlPattern;
    use crate::pattern::PixelGrid;
    use crate::PatternImpl;
    use mizer_node::Color;

    macro_rules! pixels {
        ($([$($color:expr),+ $(,)?]),+ $(,)?) => {
            vec![$($(<(f64, f64, f64)>::from($color)),+),+]
        };
        ($($color:expr),+ $(,)?) => {
            vec![$(<(f64, f64, f64)>::from($color)),+]
        };
        ($color:expr; $count:expr) => {
            vec![$color.into(); $count]
        };
    }

    #[test]
    fn swirl_pattern_should_iterate_through_quad() {
        let mut pattern = SwirlPattern::default();
        let mut pixels = vec![pixels![Color::BLACK; 4]; 4];

        for pixels in pixels.iter_mut() {
            pattern.next(PixelGrid::new(pixels, (2, 2)), &Color::WHITE);
        }

        dbg!(&pixels);

        assert_eq!(
            pixels![Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
            pixels[0]
        );
        assert_eq!(
            pixels![Color::WHITE, Color::BLACK, Color::WHITE, Color::BLACK],
            pixels[1]
        );
        assert_eq!(
            pixels![Color::WHITE, Color::BLACK, Color::WHITE, Color::WHITE],
            pixels[2]
        );
        assert_eq!(
            pixels![Color::WHITE, Color::WHITE, Color::WHITE, Color::WHITE],
            pixels[3]
        );
    }

    #[test]
    fn swirl_pattern_should_iterate_through_3x3() {
        let mut pattern = SwirlPattern::default();
        let mut pixels = vec![pixels![Color::BLACK; 9]; 9];

        for pixels in pixels.iter_mut() {
            pattern.next(PixelGrid::new(pixels, (3, 3)), &Color::WHITE);
        }

        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK]
            ],
            pixels[0]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK]
            ],
            pixels[1]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK]
            ],
            pixels[2]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::WHITE, Color::BLACK]
            ],
            pixels[3]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::WHITE, Color::WHITE]
            ],
            pixels[4]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::WHITE],
                [Color::WHITE, Color::WHITE, Color::WHITE]
            ],
            pixels[5]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::WHITE],
                [Color::WHITE, Color::BLACK, Color::WHITE],
                [Color::WHITE, Color::WHITE, Color::WHITE]
            ],
            pixels[6]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::WHITE, Color::WHITE],
                [Color::WHITE, Color::BLACK, Color::WHITE],
                [Color::WHITE, Color::WHITE, Color::WHITE]
            ],
            pixels[7]
        );
        // assert_eq!(
        //     pixels![
        //         [Color::WHITE, Color::WHITE, Color::WHITE],
        //         [Color::WHITE, Color::WHITE, Color::WHITE],
        //         [Color::WHITE, Color::WHITE, Color::WHITE]
        //     ],
        //     pixels[8]
        // );
    }

    #[test]
    fn swirl_pattern_should_iterate_through_4x4() {
        let mut pattern = SwirlPattern::default();
        let mut pixels = vec![pixels![Color::BLACK; 4 * 4]; 4 * 4];

        for pixels in pixels.iter_mut() {
            pattern.next(PixelGrid::new(pixels, (4, 4)), &Color::WHITE);
        }

        dbg!(&pixels);

        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK, Color::BLACK],
            ],
            pixels[0]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK, Color::BLACK]
            ],
            pixels[1]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::BLACK, Color::BLACK, Color::BLACK, Color::BLACK]
            ],
            pixels[2]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK]
            ],
            pixels[3]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::WHITE, Color::BLACK, Color::BLACK]
            ],
            pixels[4]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::WHITE, Color::WHITE, Color::BLACK]
            ],
            pixels[5]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::WHITE, Color::WHITE, Color::WHITE]
            ],
            pixels[6]
        );
        assert_eq!(
            pixels![
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::BLACK],
                [Color::WHITE, Color::BLACK, Color::BLACK, Color::WHITE],
                [Color::WHITE, Color::WHITE, Color::WHITE, Color::WHITE]
            ],
            pixels[7]
        );
    }
}
