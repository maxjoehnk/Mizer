use mizer_command_executor::*;

use crate::proto::effects::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct EffectsHandler<R> {
    runtime: R,
}

impl<R: RuntimeApi> EffectsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_effects(&self) -> Effects {
        let effects = self.runtime.query(ListEffectsQuery).unwrap();

        let effects = effects.into_iter().map(Effect::from).collect();

        Effects { effects }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_effect(&self, name: String) {
        self.runtime.run_command(AddEffectCommand { name }).unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_effect_channel(&self, request: AddEffectChannelRequest) {
        self.runtime
            .run_command(AddEffectChannelCommand {
                effect_id: request.effect_id,
                control: EffectControl::try_from(request.control).unwrap().into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_effect_step(&self, request: AddEffectStepRequest) {
        self.runtime
            .run_command(AddEffectStepCommand {
                effect_id: request.effect_id,
                channel_index: request.channel_index as usize,
                step: request.step.unwrap().into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
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

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_effect(&self, effect_id: u32) {
        self.runtime
            .run_command(DeleteEffectCommand { effect_id })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_effect_channel(&self, request: DeleteEffectChannelRequest) {
        self.runtime
            .run_command(DeleteEffectChannelCommand {
                effect_id: request.effect_id,
                channel_index: request.channel_index as usize,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
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
