use mizer_commander::{Query, Ref};
use mizer_sequencer::{Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct GetSequenceQuery {
    pub id: u32,
}

impl<'a> Query<'a> for GetSequenceQuery {
    type Dependencies = Ref<Sequencer>;
    type Result = Option<Sequence>;

    fn query(&self, sequencer: &Sequencer) -> anyhow::Result<Self::Result> {
        Ok(sequencer.sequence(self.id))
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
