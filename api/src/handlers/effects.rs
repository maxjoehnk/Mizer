use crate::models::{Effect, Effects};
use mizer_sequencer::effects::EffectEngine;

#[derive(Clone)]
pub struct EffectsHandler {
    engine: EffectEngine,
}

impl EffectsHandler {
    pub fn new(effect_engine: EffectEngine) -> Self {
        Self {
            engine: effect_engine,
        }
    }

    pub fn get_effects(&self) -> Effects {
        let effects = self.engine.effects();

        let effects = effects.into_iter().map(Effect::from).collect();

        Effects {
            effects,
            ..Default::default()
        }
    }
}
