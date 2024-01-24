pub use self::effect::*;
pub use self::engine::*;
pub use self::module::*;
pub(crate) use self::processor::*;
pub use self::spline::*;

mod default_effects;
mod effect;
mod engine;
mod instance;
mod module;
mod processor;
mod spline;

#[cfg(test)]
mod effect_grapher;

#[cfg(test)]
mod tests {
    use mizer_fixtures::definition::FixtureFaderControl;

    use crate::effects::default_effects::{EffectChannelTemplate, CIRCLE};
    use crate::effects::effect_grapher::{graph_effect, graph_position_effect};
    use crate::{Effect, EffectStep};

    #[test]
    fn circle() -> anyhow::Result<()> {
        let effect: Effect = (1, &CIRCLE).into();

        graph_position_effect(effect.clone())?;
        graph_effect(effect, vec![1])?;

        Ok(())
    }

    #[test]
    fn linear_range() -> anyhow::Result<()> {
        let effect = Effect {
            name: "linear_range".into(),
            id: 1,
            channels: vec![(&EffectChannelTemplate::new(
                FixtureFaderControl::Intensity,
                [EffectStep::new(0.), EffectStep::range((0., 1.))],
            ))
                .into()],
        };

        graph_effect(effect, vec![1, 2, 3, 4])
    }
}
