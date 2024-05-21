use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use mizer_sequencer::{Sequence, Sequencer};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListSequencesQuery;

impl<'a> Query<'a> for ListSequencesQuery {
    type Dependencies = Ref<Sequencer>;
    type Result = Vec<Sequence>;

    fn query(&self, sequencer: &Sequencer) -> anyhow::Result<Self::Result> {
        Ok(sequencer.sequences())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
