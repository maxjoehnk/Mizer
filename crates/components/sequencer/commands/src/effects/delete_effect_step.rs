use serde::{Deserialize, Serialize};

use crate::{get_channel_mut, get_effect_mut};
use mizer_commander::{Command, Ref};
use mizer_sequencer::{EffectEngine, EffectStep};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteEffectStepCommand {
    pub effect_id: u32,
    pub channel_index: usize,
    pub step_index: usize,
}

impl<'a> Command<'a> for DeleteEffectStepCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = EffectStep;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Delete Step '{}' from Channel '{}' from Effect '{}'",
            self.step_index, self.channel_index, self.effect_id
        )
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = get_channel_mut(&mut effect, self.channel_index)?;
        let step = channel.steps.remove(self.step_index);

        Ok(((), step))
    }

    fn revert(&self, effect_engine: &EffectEngine, step: Self::State) -> anyhow::Result<()> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = get_channel_mut(&mut effect, self.channel_index)?;
        channel.steps.insert(self.step_index, step);

        Ok(())
    }
}
