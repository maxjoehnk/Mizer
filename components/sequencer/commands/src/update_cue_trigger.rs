use crate::get_cue;
use mizer_commander::{Command, Ref};
use mizer_sequencer::{CueTrigger, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateCueTriggerCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub trigger: CueTrigger,
}

impl<'a> Command<'a> for UpdateCueTriggerCommand {
    type Dependencies = Ref<Sequencer>;
    type State = CueTrigger;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Update Cue Trigger '{}.{}' to '{:?}'",
            self.sequence_id, self.cue_id, self.trigger
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            previous = Some(cue.trigger.clone());
            cue.trigger = self.trigger;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, trigger: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            cue.trigger = trigger;

            Ok(())
        })?;

        Ok(())
    }
}
