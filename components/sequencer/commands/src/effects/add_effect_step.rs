use crate::{get_channel_mut, get_effect_mut};
use mizer_commander::{Command, Ref};
use mizer_sequencer::{EffectEngine, EffectStep};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddEffectStepCommand {
    pub effect_id: u32,
    pub channel_index: usize,
    pub step: EffectStep,
}

impl<'a> Command<'a> for AddEffectStepCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Add Effect Step '{:?}' to Effect '{}' channel {}",
            self.step, self.effect_id, self.channel_index
        )
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = get_channel_mut(&mut effect, self.channel_index)?;
        channel.steps.push(self.step.clone());

        Ok(((), ()))
    }

    fn revert(&self, effect_engine: &EffectEngine, _: Self::State) -> anyhow::Result<()> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = get_channel_mut(&mut effect, self.channel_index)?;
        channel.steps.pop();

        Ok(())
    }
}
