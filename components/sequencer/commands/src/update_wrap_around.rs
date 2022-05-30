use mizer_commander::{Command, Ref};
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateSequenceWrapAroundCommand {
    pub sequence_id: u32,
    pub wrap_around: bool,
}

impl<'a> Command<'a> for UpdateSequenceWrapAroundCommand {
    type Dependencies = Ref<Sequencer>;
    type State = bool;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Set Wrap Around of Sequence '{}' to {}",
            self.sequence_id, self.wrap_around
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            previous = Some(sequence.wrap_around);
            sequence.wrap_around = self.wrap_around;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, wrap_around: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            sequence.wrap_around = wrap_around;

            Ok(())
        })?;

        Ok(())
    }
}
