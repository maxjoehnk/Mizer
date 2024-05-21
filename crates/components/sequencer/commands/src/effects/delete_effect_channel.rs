use crate::get_effect_mut;
use mizer_commander::{Command, Ref};
use mizer_sequencer::{EffectChannel, EffectEngine};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteEffectChannelCommand {
    pub effect_id: u32,
    pub channel_index: usize,
}

impl<'a> Command<'a> for DeleteEffectChannelCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = EffectChannel;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Delete Channel '{}' from Effect '{}'",
            self.channel_index, self.effect_id
        )
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        let channel = effect.channels.remove(self.channel_index);

        Ok(((), channel))
    }

    fn revert(&self, effect_engine: &EffectEngine, channel: Self::State) -> anyhow::Result<()> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        effect.channels.insert(self.channel_index, channel);

        Ok(())
    }
}
