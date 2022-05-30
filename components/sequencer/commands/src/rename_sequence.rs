use mizer_commander::{Command, Ref};
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct RenameSequenceCommand {
    pub sequence_id: u32,
    pub name: String,
}

impl<'a> Command<'a> for RenameSequenceCommand {
    type Dependencies = Ref<Sequencer>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!("Rename Sequence '{}' to '{}'", self.sequence_id, self.name)
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            previous = Some(sequence.name.clone());
            sequence.name = self.name.clone();

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, name: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            sequence.name = name;

            Ok(())
        })?;

        Ok(())
    }
}
