use crate::models::effects::*;
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

    pub fn add_effect(&self, name: String) {
        self.runtime.run_command(AddEffectCommand { name }).unwrap();
    }

    pub fn add_effect_channel(&self, request: AddEffectChannelRequest) {
        self.runtime
            .run_command(AddEffectChannelCommand {
                effect_id: request.effect_id,
                control: request.control.unwrap().into(),
            })
            .unwrap();
    }

    pub fn add_effect_step(&self, request: AddEffectStepRequest) {
        self.runtime
            .run_command(AddEffectStepCommand {
                effect_id: request.effect_id,
                channel_index: request.channel_index as usize,
                step: request.step.unwrap().into(),
            })
            .unwrap();
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

    pub fn delete_effect(&self, effect_id: u32) {
        self.runtime
            .run_command(DeleteEffectCommand { effect_id })
            .unwrap();
    }

    pub fn delete_effect_channel(&self, request: DeleteEffectChannelRequest) {
        self.runtime
            .run_command(DeleteEffectChannelCommand {
                effect_id: request.effect_id,
                channel_index: request.channel_index as usize,
            })
            .unwrap();
    }

    pub fn delete_effect_step(&self, request: DeleteEffectStepRequest) {
        self.runtime
            .run_command(DeleteEffectStepCommand {
                effect_id: request.effect_id,
                channel_index: request.channel_index as usize,
                step_index: request.step_index as usize,
            })
            .unwrap();
    }
}
