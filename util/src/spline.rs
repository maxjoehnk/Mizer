use bezier_rs::{ComputeType, ManipulatorGroup, Subpath};
use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, Deserialize, Serialize, PartialEq)]
pub struct SplineStep {
    pub x: f64,
    pub y: f64,
    pub c0a: f64,
    pub c0b: f64,
    pub c1a: f64,
    pub c1b: f64,
}

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq)]
pub struct Spline {
    pub steps: Vec<SplineStep>,
}

impl Spline {
    // TODO: keep in range [0..=1]
    pub fn sample(&self, x: f64, max: f64) -> f64 {
        let value = (x / max).clamp(0., 1.);
        let path = Subpath::new(
            self.steps
                .iter()
                .map(|step| ManipulatorGroup {
                    anchor: (step.x / max, step.y).into(),
                    in_handle: Some((step.c0a / max, step.c0b).into()),
                    out_handle: Some((step.c1a / max, step.c1b).into()),
                })
                .collect(),
            false,
        );

        let point = path.evaluate(ComputeType::Parametric(value));

        point.y
    }

    pub fn is_empty(&self) -> bool {
        self.steps.is_empty()
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    #[test_case(0f64)]
    #[test_case(0.5f64)]
    #[test_case(1f64)]
    fn process_should_translate_values_of_basic_ramp(value: f64) {
        let node = create_spline();

        let result = node.sample(value, 1.);

        assert_eq!(result, value);
    }

    #[test_case(0f64, 1f64, 0f64, 1f64, 1f64, 1f64)]
    #[test_case(0f64, 1f64, 0f64, 1f64, 0f64, 0f64)]
    #[test_case(0f64, 1f64, 0f64, 1f64, 0.5f64, 0f64)]
    #[test_case(0f64, 0.5f64, 0f64, 1f64, 0f64, 0f64)]
    #[test_case(0f64, 0.5f64, 0f64, 1f64, 1f64, 1f64)]
    #[test_case(0f64, 0.5f64, 0f64, 1f64, 0.5f64, 0f64)]
    // #[test_case(0f64, 0.5f64, 0f64, 1f64, 0.75f64, 0.5f64)]
    fn process_should_translate_values_of_two_step_ramp(
        y1: f64,
        x2: f64,
        y2: f64,
        y3: f64,
        value: f64,
        expected: f64,
    ) {
        let node = Spline {
            steps: vec![
                SplineStep {
                    x: 0.,
                    y: y1,
                    c0a: 0.,
                    c0b: 0.,
                    c1a: 0.,
                    c1b: 0.,
                },
                SplineStep {
                    x: x2,
                    y: y2,
                    c0a: 0.,
                    c0b: y1,
                    c1a: 0.,
                    c1b: y1,
                },
                SplineStep {
                    x: 1.,
                    y: y3,
                    c0a: x2,
                    c0b: y2,
                    c1a: 1.,
                    c1b: y3,
                },
            ],
        };

        let result = node.sample(value, 1.);

        assert_eq!(result, expected);
    }

    fn create_spline() -> Spline {
        Spline {
            steps: vec![
                SplineStep {
                    x: 0.,
                    y: 0.,
                    c0a: 0.5,
                    c0b: 0.5,
                    c1a: 0.5,
                    c1b: 0.5,
                },
                SplineStep {
                    x: 1.,
                    y: 1.,
                    c0a: 0.5,
                    c0b: 0.5,
                    c1a: 0.5,
                    c1b: 0.5,
                },
            ],
        }
    }
}
