mod engine;
mod effect;
mod default_effects;
mod processor;
mod instance;
mod spline;

#[cfg(test)]
mod effect_grapher;

pub use self::engine::*;
pub use self::effect::*;
pub use self::spline::*;
pub(crate) use self::processor::*;

#[cfg(test)]
mod tests {
    use crate::effects::default_effects::CIRCLE;
    use crate::effects::effect_grapher::{graph_effect, graph_position_effect};
    use crate::{Effect, EffectStep, EffectChannel};
    use mizer_fixtures::definition::FixtureFaderControl;

    #[test]
    fn circle_controls() -> anyhow::Result<()> {
        let effect = (1, &CIRCLE).into();

        graph_effect(effect, vec![1])
    }

    #[test]
    fn circle() -> anyhow::Result<()> {
        let effect = (1, &CIRCLE).into();

        graph_position_effect(effect)
    }

    #[test]
    fn linear_range() -> anyhow::Result<()> {
        let effect = Effect {
            name: "linear_range".into(),
            id: 1,
            steps: vec![
                EffectStep {
                    channels: vec![
                        EffectChannel::new(FixtureFaderControl::Intensity, 0.)
                    ]
                },
                EffectStep {
                    channels: vec![
                        EffectChannel::range(FixtureFaderControl::Intensity, (0., 1.))
                    ]
                }
            ]
        };

        graph_effect(effect, vec![1, 2, 3, 4])
    }
}
