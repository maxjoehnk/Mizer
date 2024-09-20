use crate::get_effect_mut;
use mizer_commander::{Command, Ref};
use mizer_sequencer::{EffectChannel, EffectEngine};
use serde::{Deserialize, Serialize};
use mizer_fixtures::channels::FixtureChannel;

#[derive(Debug, Deserialize, Serialize)]
pub struct AddEffectChannelCommand {
    pub effect_id: u32,
    pub control: FixtureChannel,
}

impl<'a> Command<'a> for AddEffectChannelCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Add Effect Channel '{:?}' to Effect '{}'",
            self.control, self.effect_id
        )
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        effect.channels.push(EffectChannel {
            control: self.control.clone(),
            steps: Default::default(),
        });

        Ok(((), ()))
    }

    fn revert(&self, effect_engine: &EffectEngine, _: Self::State) -> anyhow::Result<()> {
        let mut effect = get_effect_mut(effect_engine, self.effect_id)?;
        effect.channels.pop();

        Ok(())
    }
}
