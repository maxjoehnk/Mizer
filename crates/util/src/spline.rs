use std::hash::{Hash, Hasher};

use bezier_rs::{Identifier, ManipulatorGroup, Subpath, SubpathTValue};
use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, Default, Deserialize, Serialize, PartialEq)]
pub struct SplineStep {
    pub x: f64,
    pub y: f64,
    pub c0a: f64,
    pub c0b: f64,
    pub c1a: f64,
    pub c1b: f64,
}

impl Hash for SplineStep {
    fn hash<H: Hasher>(&self, state: &mut H) {
        state.write_u64(self.x.to_bits());
        state.write_u64(self.y.to_bits());
        state.write_u64(self.c0a.to_bits());
        state.write_u64(self.c0b.to_bits());
        state.write_u64(self.c1a.to_bits());
        state.write_u64(self.c1b.to_bits());
    }
}

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq, Hash)]
pub struct Spline {
    pub steps: Vec<SplineStep>,
}

#[derive(Clone, Copy, Hash, PartialEq, Eq)]
struct SplineStepId(uuid::Uuid);
impl Identifier for SplineStepId {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

impl Spline {
    // TODO: keep in range [0..=1]
    pub fn sample(&self, x: f64, max: f64) -> f64 {
        let value = (x / max).clamp(0., 1.);
        let path = Subpath::<SplineStepId>::new(
            self.steps
                .iter()
                .map(|step| {
                    ManipulatorGroup::new(
                        (step.x / max, step.y).into(),
                        Some((step.c0a / max, step.c0b).into()),
                        Some((step.c1a / max, step.c1b).into()),
                    )
                })
                .collect(),
            false,
        );

        if path.len_segments() == 0 {
            return 0.;
        }
        let point = path.evaluate(SubpathTValue::GlobalParametric(value));

        point.y
    }

    pub fn add_simple_step(&mut self, frame: f64, value: f64) {
        let last_step_index =
            self.steps.iter().enumerate().rev().find_map(
                |(i, s)| {
                    if s.x < frame {
                        Some(i)
                    } else {
                        None
                    }
                },
            );
        let first_step_index =
            self.steps.iter().enumerate().find_map(
                |(i, s)| {
                    if s.x > frame {
                        Some(i)
                    } else {
                        None
                    }
                },
            );
        let mut last_step = if let Some(last_step_index) = last_step_index {
            self.steps.truncate(last_step_index + 1);
            self.steps[last_step_index]
        } else if let Some(first_step_index) = first_step_index {
            self.steps.truncate(first_step_index);
            self.steps.last().copied().unwrap_or_default()
        } else {
            self.steps.last().copied().unwrap_or_default()
        };
        let frame_diff = frame - last_step.x;
        if frame_diff > 0.1 {
            let step = SplineStep {
                x: frame,
                y: last_step.y,
                c0a: last_step.x,
                c0b: last_step.y,
                c1a: frame,
                c1b: last_step.y,
            };
            last_step = step;
            self.steps.push(step);
        }
        let step = SplineStep {
            x: frame,
            y: value,
            c0a: last_step.x,
            c0b: last_step.y,
            c1a: frame,
            c1b: value,
        };
        self.steps.push(step);
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
