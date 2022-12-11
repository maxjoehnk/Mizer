use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_sequencer::{Sequencer, SequencerValue};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateCueValueCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub control_index: u32,
    pub value: SequencerValue<f64>,
}

impl<'a> Command<'a> for UpdateCueValueCommand {
    type Dependencies = Ref<Sequencer>;
    type State = SequencerValue<f64>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Change Cue Value of '{}.{}' to '{:?}'",
            self.sequence_id, self.cue_id, self.value
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let control = get_control(sequence, self.cue_id, self.control_index)?;
            previous = Some(control.value);
            control.value = self.value;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, value: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let control = get_control(sequence, self.cue_id, self.control_index)?;
            control.value = value;

            Ok(())
        })?;

        Ok(())
    }
}
