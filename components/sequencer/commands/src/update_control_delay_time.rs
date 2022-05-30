use crate::get_cue;
use mizer_commander::{Command, Ref};
use mizer_sequencer::{Sequencer, SequencerTime, SequencerValue};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateControlDelayTimeCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub delay_time: Option<SequencerValue<SequencerTime>>,
}

impl<'a> Command<'a> for UpdateControlDelayTimeCommand {
    type Dependencies = Ref<Sequencer>;
    type State = Option<SequencerValue<SequencerTime>>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Update Cue Delay Time '{}.{}' to '{:?}'",
            self.sequence_id, self.cue_id, self.delay_time
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            previous = Some(cue.cue_delay.clone());
            cue.cue_delay = self.delay_time;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, delay_time: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            cue.cue_delay = delay_time;

            Ok(())
        })?;

        Ok(())
    }
}
