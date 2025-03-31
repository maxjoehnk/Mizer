use crate::get_cue;
use mizer_commander::{Command, Ref};
use mizer_sequencer::{Sequencer, SequencerTime};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct UpdateCueTriggerTimeCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub trigger_time: Option<SequencerTime>,
}

impl<'a> Command<'a> for UpdateCueTriggerTimeCommand {
    type Dependencies = Ref<Sequencer>;
    type State = Option<SequencerTime>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Set Cue {}.{} Trigger Time = {:?}",
            self.sequence_id, self.cue_id, self.trigger_time
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            previous = Some(cue.trigger_time);
            cue.trigger_time = self.trigger_time;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, trigger_time: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            cue.trigger_time = trigger_time;

            Ok(())
        })?;

        Ok(())
    }
}
