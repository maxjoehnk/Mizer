use mizer_commander::{Command, Ref};
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct SequenceGoBackwardCommand {
    pub sequence_id: u32,
}

impl<'a> Command<'a> for SequenceGoBackwardCommand {
    type Dependencies = Ref<Sequencer>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Go- Sequence {}", self.sequence_id)
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        sequencer.sequence_go_backward(self.sequence_id);

        Ok(((), ()))
    }

    fn revert(&self, _sequencer: &Sequencer, _: Self::State) -> anyhow::Result<()> {
        Ok(())
    }
}
