use std::collections::HashMap;

use itertools::Itertools;
use serde::{Deserialize, Serialize};

use mizer_fixtures::definition::FixtureFaderControl;
use super::spline::*;

use crate::SequencerValue;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Effect {
    pub id: u32,
    pub name: String,
    pub steps: Vec<EffectStep>,
}

impl Effect {
    pub(crate) fn build_splines(&self) -> HashMap<FixtureFaderControl, Spline> {
        let mut steps =
            HashMap::<FixtureFaderControl, Vec<(EffectControlPoint, SequencerValue<f64>)>>::new();
        for step in self.steps.iter() {
            for channel in step.channels.iter() {
                steps
                    .entry(channel.control.clone())
                    .and_modify(|values| values.push((channel.control_point, channel.value)))
                    .or_insert_with(|| vec![(channel.control_point, channel.value)]);
            }
        }

        steps
            .into_iter()
            .map(|(key, values)| {
                let spline = values
                    .into_iter()
                    .enumerate()
                    .tuple_windows()
                    .map(|(a, b)| {
                        let a_value: SequencerValue<f64> = a.1.1;
                        let start = [(a.0 as f64).into(), a_value];
                        let b_value: SequencerValue<f64> = b.1.1;
                        let end = [(b.0 as f64).into(), b_value];

                        SplinePart::new(start, end, b.1.0)
                    })
                    .collect();

                (key, spline)
            })
            .collect()
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct EffectStep {
    pub channels: Vec<EffectChannel>,
}

impl EffectStep {
    pub const fn new(channels: Vec<EffectChannel>) -> Self {
        Self { channels }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct EffectChannel {
    pub control: FixtureFaderControl,
    pub value: SequencerValue<f64>,
    #[serde(default)]
    pub control_point: EffectControlPoint,
}

impl EffectChannel {
    pub const fn new(control: FixtureFaderControl, value: f64) -> Self {
        Self {
            control,
            value: SequencerValue::Direct(value),
            control_point: EffectControlPoint::Simple,
        }
    }

    pub const fn range(control: FixtureFaderControl, value: (f64, f64)) -> Self {
        Self {
            control,
            value: SequencerValue::Range(value),
            control_point: EffectControlPoint::Simple,
        }
    }

    pub const fn quadratic(control: FixtureFaderControl, value: f64, point: (f64, f64)) -> Self {
        Self {
            control,
            value: SequencerValue::Direct(value),
            control_point: EffectControlPoint::Quadratic([point.0, point.1]),
        }
    }

    pub const fn cubic(
        control: FixtureFaderControl,
        value: f64,
        a: (f64, f64),
        b: (f64, f64),
    ) -> Self {
        Self {
            control,
            value: SequencerValue::Direct(value),
            control_point: EffectControlPoint::Cubic([a.0, a.1], [b.0, b.1]),
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub enum EffectControlPoint {
    Simple,
    Quadratic([f64; 2]),
    Cubic([f64; 2], [f64; 2]),
}

impl Default for EffectControlPoint {
    fn default() -> Self {
        Self::Simple
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use mizer_fixtures::definition::FixtureFaderControl;
    use crate::{Effect, EffectChannel, SequencerValue};
    use crate::effects::default_effects::EffectStepTemplate;

    #[test_case(0., 1., 0., 0.)]
    #[test_case(0., 1., 1., 1.)]
    #[test_case(0., 1., 0.5, 0.5)]
    fn linear_effect_should_transition_from_start_to_finish(start: f64, end: f64, frame: f64, expected: f64) {
        let effect = Effect {
            id: Default::default(),
            name: Default::default(),
            steps: vec![
                (&EffectStepTemplate::new([
                    EffectChannel::new(FixtureFaderControl::Intensity, 0.)
                ])).into(),
                (&EffectStepTemplate::new([
                    EffectChannel::new(FixtureFaderControl::Intensity, 1.)
                ])).into(),
            ]
        };

        let splines = effect.build_splines();
        let spline = &splines[&FixtureFaderControl::Intensity];
        let result = spline.sample(frame);

        assert_eq!(Some(SequencerValue::Direct(expected)), result);
    }

    #[test_case(0., (0., 1.), 0., (0., 0.))]
    #[test_case(0., (0., 1.), 1., (0., 1.))]
    #[test_case(0., (0., 1.), 0.5, (0., 0.5))]
    fn linear_effect_should_transition_from_start_to_finish_with_ranges(start: f64, end: (f64, f64), frame: f64, expected: (f64, f64)) {
        let effect = Effect {
            id: Default::default(),
            name: Default::default(),
            steps: vec![
                (&EffectStepTemplate::new([
                    EffectChannel::new(FixtureFaderControl::Intensity, 0.)
                ])).into(),
                (&EffectStepTemplate::new([
                    EffectChannel::range(FixtureFaderControl::Intensity, end)
                ])).into(),
            ]
        };

        let splines = effect.build_splines();
        let spline = &splines[&FixtureFaderControl::Intensity];
        let result = spline.sample(frame);

        assert_eq!(Some(SequencerValue::Range(expected)), result);
    }
}
