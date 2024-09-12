use mizer_fixtures::channels::FixtureChannel;
use super::{Effect, EffectChannel, EffectStep};

const C: f64 = 0.55191502449351;

pub(crate) const CIRCLE: EffectTemplate<2, 5> = EffectTemplate::new(
    "Circle",
    [
        EffectChannelTemplate::new(
            FixtureChannel::Pan,
            [
                EffectStep::new(1.0),
                EffectStep::cubic(0.0, (C, 1.), (1., C)),
                EffectStep::cubic(-1., (-C, -1.), (1., -C)),
                EffectStep::cubic(0., (-1., -C), (-C, -1.)),
                EffectStep::cubic(1., (1., C), (C, 1.)),
            ],
        ),
        EffectChannelTemplate::new(
            FixtureChannel::Tilt,
            [
                EffectStep::new(0.0),
                EffectStep::cubic(1.0, (1., C), (C, 1.)),
                EffectStep::cubic(0., (C, 1.), (1., C)),
                EffectStep::cubic(-1., (-C, -1.), (-1., -C)),
                EffectStep::cubic(0., (-1., -C), (-C, -1.)),
            ],
        ),
    ],
);

pub(crate) struct EffectTemplate<const T: usize, const P: usize> {
    pub name: &'static str,
    pub channels: [EffectChannelTemplate<P>; T],
}

impl<const T: usize, const P: usize> EffectTemplate<T, P> {
    pub const fn new(name: &'static str, channels: [EffectChannelTemplate<P>; T]) -> Self {
        Self { name, channels }
    }
}

impl<const T: usize, const P: usize> From<(u32, &EffectTemplate<T, P>)> for Effect {
    fn from((id, template): (u32, &EffectTemplate<T, P>)) -> Self {
        Self {
            id,
            name: template.name.to_string(),
            channels: template.channels.iter().map(EffectChannel::from).collect(),
        }
    }
}

pub(crate) struct EffectChannelTemplate<const T: usize> {
    pub control: FixtureChannel,
    pub steps: [EffectStep; T],
}

impl<const T: usize> EffectChannelTemplate<T> {
    pub const fn new(control: FixtureChannel, steps: [EffectStep; T]) -> Self {
        Self { control, steps }
    }
}

impl<const T: usize> From<&EffectChannelTemplate<T>> for EffectChannel {
    fn from(template: &EffectChannelTemplate<T>) -> Self {
        EffectChannel {
            control: template.control.clone(),
            steps: template.steps.to_vec(),
        }
    }
}
