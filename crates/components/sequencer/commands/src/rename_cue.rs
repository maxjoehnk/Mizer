use crate::get_cue;
use mizer_commander::{Command, Ref};
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct RenameCueCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub name: String,
}

impl<'a> Command<'a> for RenameCueCommand {
    type Dependencies = Ref<Sequencer>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Rename Cue '{}.{}' to '{}'",
            self.sequence_id, self.cue_id, self.name
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            previous = Some(cue.name.clone());
            cue.name = self.name.clone();

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, name: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            cue.name = name;

            Ok(())
        })?;

        Ok(())
    }
}
