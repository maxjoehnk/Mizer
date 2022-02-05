use super::{Effect, EffectChannel, EffectStep};
use mizer_fixtures::definition::FixtureFaderControl;

const c: f64 = 0.55191502449351;

pub(crate) const CIRCLE: EffectTemplate<5, 2> = EffectTemplate::new("Circle",
    [
        EffectStepTemplate::new([
            EffectChannel::new(FixtureFaderControl::Pan, 1.0), // (0, 1)
            EffectChannel::new(FixtureFaderControl::Tilt, 0.0),
        ]),
        EffectStepTemplate::new([
            EffectChannel::cubic(FixtureFaderControl::Pan, 0.0, (c, 1.), (1., c)), // (1, 0)
            EffectChannel::cubic(FixtureFaderControl::Tilt, 1.0, (1., c), (c, 1.)),
        ]),
        EffectStepTemplate::new([
            EffectChannel::cubic(FixtureFaderControl::Pan, -1., (-c, -1.), (1., -c)), // (2, -1)
            EffectChannel::cubic(FixtureFaderControl::Tilt, 0., (c, 1.), (1., c)),
        ]),
        EffectStepTemplate::new([
            EffectChannel::cubic(FixtureFaderControl::Pan, 0., (-1., -c), (-c, -1.)), // (3, 0)
            EffectChannel::cubic(FixtureFaderControl::Tilt, -1., (-c, -1.), (-1., -c)),
        ]),
        EffectStepTemplate::new([
            EffectChannel::cubic(FixtureFaderControl::Pan, 1., (1., c), (c, 1.)), // (4, 1)
            EffectChannel::cubic(FixtureFaderControl::Tilt, 0., (-1., -c), (-c, -1.)),
        ]),
    ]
);

pub(crate) struct EffectTemplate<const T: usize, const P: usize> {
    pub name: &'static str,
    pub steps: [EffectStepTemplate<P>; T],
}

impl<const T: usize, const P: usize> EffectTemplate<T, P> {
    pub const fn new(name: &'static str, steps: [EffectStepTemplate<P>; T]) -> Self {
        Self {
            name,
            steps
        }
    }
}

impl<const T: usize, const P: usize> From<(u32, &EffectTemplate<T, P>)> for Effect {
    fn from((id, template): (u32, &EffectTemplate<T, P>)) -> Self {
        Self {
            id,
            name: template.name.to_string(),
            steps: template.steps.iter().map(EffectStep::from).collect(),
        }
    }
}

pub(crate) struct EffectStepTemplate<const T: usize> {
    pub channels: [EffectChannel; T]
}

impl<const T: usize> EffectStepTemplate<T> {
    pub const fn new(channels: [EffectChannel; T]) -> Self {
        Self {
            channels
        }
    }
}

impl<const T: usize> From<&EffectStepTemplate<T>> for EffectStep {
    fn from(step: &EffectStepTemplate<T>) -> Self {
        EffectStep {
            channels: step.channels.to_vec()
        }
    }
}
