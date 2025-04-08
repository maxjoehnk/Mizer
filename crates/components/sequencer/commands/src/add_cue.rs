use mizer_commander::{Command, Ref};
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddCueCommand {
    pub sequence_id: u32,
}

impl<'a> Command<'a> for AddCueCommand {
    type Dependencies = Ref<Sequencer>;
    type State = u32;
    type Result = ();

    fn label(&self) -> String {
        "Add Cue".to_string()
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut cue_id = None;
        sequencer.update_sequence(self.sequence_id, |s| {
            cue_id = Some(s.add_cue());

            Ok(())
        })?;
        let cue_id = cue_id.unwrap();

        Ok(((), cue_id))
    }

    fn revert(&self, sequencer: &Sequencer, cue_id: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |s| s.delete_cue(cue_id))?;

        Ok(())
    }
}
