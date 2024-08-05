use mizer_commander::{Query, Ref};
use mizer_sequencer::{Effect, EffectEngine};
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct ListEffectsQuery;

impl<'a> Query<'a> for ListEffectsQuery {
    type Dependencies = Ref<EffectEngine>;
    type Result = Vec<Effect>;

    fn query(&self, effect_engine: &EffectEngine) -> anyhow::Result<Self::Result> {
        Ok(effect_engine.effects())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
