use crate::{get_channel_mut, get_effect_mut, get_step_mut};
use mizer_commander::{Command, Ref};
use mizer_sequencer::{EffectEngine, EffectStep};
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
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = get_channel_mut(&mut effect, self.channel_index)?;
        let step = get_step_mut(channel, self.step_index)?;
        let previous_step = step.clone();
        *step = self.step.clone();

        Ok(((), previous_step))
    }

    fn revert(
        &self,
        effect_engine: &EffectEngine,
        previous_step: Self::State,
    ) -> anyhow::Result<()> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = get_channel_mut(&mut effect, self.channel_index)?;
        let step = get_step_mut(channel, self.step_index)?;
        *step = previous_step;

        Ok(())
    }
}
