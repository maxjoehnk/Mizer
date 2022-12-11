use mizer_commander::{Command, Ref};
use mizer_sequencer::{Effect, EffectEngine};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddEffectCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddEffectCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = u32;
    type Result = Effect;

    fn label(&self) -> String {
        format!("Add Effect '{}'", self.name)
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let effect = effect_engine.create_effect(self.name.clone());
        let effect_id = effect.id;

        Ok((effect, effect_id))
    }

    fn revert(&self, effect_engine: &EffectEngine, effect_id: Self::State) -> anyhow::Result<()> {
        effect_engine.delete_effect(effect_id);

        Ok(())
    }
}
