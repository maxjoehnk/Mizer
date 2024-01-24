use splines::{Interpolation, Key};

use mizer_util::Spline;

pub trait TimecodeSpline {
    fn timecode_sample(&self, x: f64) -> f64;
}

impl TimecodeSpline for Spline {
    fn timecode_sample(&self, x: f64) -> f64 {
        let keys = self.steps.iter().map(|step| {
            Key::new(
                step.x,
                SplinePoint::new(step.x, step.y),
                Interpolation::StrokeBezier(
                    SplinePoint::new(step.c0a, step.c0b),
                    SplinePoint::new(step.c1a, step.c1b),
                ),
            )
        });
        let spline = splines::Spline::from_iter(keys);

        spline.sample(x).unwrap_or_default().y
    }
}

#[derive(Debug, Default, Clone, Copy, PartialEq)]
pub struct SplinePoint {
    pub x: f64,
    pub y: f64,
}

impl SplinePoint {
    pub fn new(x: f64, y: f64) -> Self {
        Self { x, y }
    }
}

impl std::ops::Add for SplinePoint {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Self {
            x: self.x + rhs.x,
            y: self.y + rhs.y,
        }
    }
}

impl std::ops::Sub for SplinePoint {
    type Output = Self;

    fn sub(self, rhs: Self) -> Self::Output {
        Self {
            x: self.x - rhs.x,
            y: self.y - rhs.y,
        }
    }
}

impl std::ops::Mul for SplinePoint {
    type Output = Self;

    fn mul(self, rhs: Self) -> Self::Output {
        Self {
            x: self.x * rhs.x,
            y: self.y * rhs.y,
        }
    }
}

impl std::ops::Div for SplinePoint {
    type Output = Self;

    fn div(self, rhs: Self) -> Self::Output {
        Self {
            x: self.x / rhs.x,
            y: self.y / rhs.y,
        }
    }
}

impl std::ops::Add<f64> for SplinePoint {
    type Output = Self;

    fn add(self, rhs: f64) -> Self::Output {
        Self {
            x: self.x + rhs,
            y: self.y + rhs,
        }
    }
}

impl std::ops::Sub<f64> for SplinePoint {
    type Output = Self;

    fn sub(self, rhs: f64) -> Self::Output {
        Self {
            x: self.x - rhs,
            y: self.y - rhs,
        }
    }
}

impl std::ops::Sub<SplinePoint> for f64 {
    type Output = SplinePoint;

    fn sub(self, rhs: SplinePoint) -> Self::Output {
        SplinePoint {
            x: self - rhs.x,
            y: self - rhs.y,
        }
    }
}

impl std::ops::Mul<f64> for SplinePoint {
    type Output = Self;

    fn mul(self, rhs: f64) -> Self::Output {
        Self {
            x: self.x * rhs,
            y: self.y * rhs,
        }
    }
}

impl std::ops::Div<f64> for SplinePoint {
    type Output = Self;

    fn div(self, rhs: f64) -> Self::Output {
        Self {
            x: self.x / rhs,
            y: self.y / rhs,
        }
    }
}

splines::impl_Interpolate!(f64, SplinePoint, std::f64::consts::PI);

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use mizer_util::{Spline, SplineStep};

    use super::*;

    #[test_case(vec![(1., 0.), (1., 1.), (2., 1.), (2., 0.)], 0., 0.)]
    #[test_case(vec![(1., 0.), (1., 1.), (2., 1.), (2., 0.)], 0.9, 0.)]
    #[test_case(vec![(1., 0.), (1., 1.), (2., 1.), (2., 0.)], 1., 1.)]
    #[test_case(vec![(1., 0.), (1., 1.), (2., 1.), (2., 0.)], 1.1, 1.)]
    #[test_case(vec![(1., 0.), (1., 1.), (2., 1.), (2., 0.)], 2., 0.)]
    #[test_case(vec![(1., 0.), (1., 1.), (2., 1.), (2., 0.)], 4., 0.)]
    fn sample_should_sample_linear_spline(mut points: Vec<(f64, f64)>, x: f64, expected: f64) {
        points.insert(0, (0., 0.));
        let mut steps = Vec::with_capacity(points.len());
        for i in 0..points.len() {
            if i == 0 {
                steps.push(SplineStep {
                    x: points[i].0,
                    y: points[i].1,
                    c0a: points[i].0,
                    c0b: points[i].1,
                    c1a: points[i].0,
                    c1b: points[i].1,
                });
            } else {
                steps.push(SplineStep {
                    x: points[i].0,
                    y: points[i].1,
                    c0a: points[i - 1].0,
                    c0b: points[i - 1].1,
                    c1a: points[i].0,
                    c1b: points[i].1,
                });
            }
        }
        let spline = Spline { steps };

        let result = spline.timecode_sample(x);

        assert_eq!(result, expected);
    }
}
