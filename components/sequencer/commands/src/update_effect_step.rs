use mizer_commander::{Command, Ref};
use mizer_sequencer::{Effect, EffectEngine, EffectStep};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateEffectStepCommand {
    pub effect_id: u32,
    pub channel_index: usize,
    pub step_index: usize,
    pub step: EffectStep,
}

impl<'a> Command<'a> for UpdateEffectStepCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = EffectStep;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Update Effect Step '{}'.'{}'.'{}'",
            self.effect_id, self.channel_index, self.step_index
        )
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let effect = effect_engine.effect_mut(self.effect_id);
        if effect.is_none() {
            anyhow::bail!("Unknown effect {}", self.effect_id);
        }
        let mut effect = effect.unwrap();
        let step = effect.channels[self.channel_index].steps[self.step_index].clone();
        effect.channels[self.channel_index].steps[self.step_index] = self.step.clone();

        Ok(((), step))
    }

    fn revert(&self, effect_engine: &EffectEngine, step: Self::State) -> anyhow::Result<()> {
        let effect = effect_engine.effect_mut(self.effect_id);
        if effect.is_none() {
            anyhow::bail!("Unknown effect {}", self.effect_id);
        }
        let mut effect = effect.unwrap();
        effect.channels[self.channel_index].steps[self.step_index] = step;

        Ok(())
    }
}
