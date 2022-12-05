use crate::models::{Effect, Effects, UpdateEffectStepRequest};
use crate::RuntimeApi;
use mizer_command_executor::*;
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

    pub fn add_effect(&self, name: String) {
        self.runtime.run_command(AddEffectCommand { name }).unwrap();
    }

    pub fn update_effect_step(&self, request: UpdateEffectStepRequest) {
        self.runtime
            .run_command(UpdateEffectStepCommand {
                effect_id: request.effect_id,
                channel_index: request.channel_index as usize,
                step_index: request.step_index as usize,
                step: request.step.unwrap().into(),
            })
            .unwrap();
    }
}
