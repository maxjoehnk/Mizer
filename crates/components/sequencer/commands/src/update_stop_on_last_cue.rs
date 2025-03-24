use mizer_commander::{Command, Ref};
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct UpdateSequenceStopOnLastCueCommand {
    pub sequence_id: u32,
    pub stop_on_last_cue: bool,
}

impl<'a> Command<'a> for UpdateSequenceStopOnLastCueCommand {
    type Dependencies = Ref<Sequencer>;
    type State = bool;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Set Sequence {} Stop on last Cue = {}",
            self.sequence_id, self.stop_on_last_cue
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            previous = Some(sequence.wrap_around);
            sequence.stop_on_last_cue = self.stop_on_last_cue;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, stop_on_last_cue: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            sequence.stop_on_last_cue = stop_on_last_cue;

            Ok(())
        })?;

        Ok(())
    }
}
