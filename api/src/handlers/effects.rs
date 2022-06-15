use crate::models::{Effect, Effects};
use crate::RuntimeApi;
use mizer_command_executor::DeleteEffectCommand;
use mizer_sequencer::effects::EffectEngine;

#[derive(Clone)]
pub struct EffectsHandler<R> {
    engine: EffectEngine,
    runtime: R,
}

impl<R: RuntimeApi> EffectsHandler<R> {
    pub fn new(effect_engine: EffectEngine, runtime: R) -> Self {
        Self {
            engine: effect_engine,
            runtime,
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

    pub fn delete_effect(&self, effect_id: u32) {
        self.runtime
            .run_command(DeleteEffectCommand { effect_id })
            .unwrap();
    }
}
