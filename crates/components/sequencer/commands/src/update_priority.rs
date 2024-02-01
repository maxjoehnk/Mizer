use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::FixturePriority;
use mizer_sequencer::Sequencer;

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateSequencePriorityCommand {
    pub sequence_id: u32,
    pub priority: FixturePriority,
}

impl<'a> Command<'a> for UpdateSequencePriorityCommand {
    type Dependencies = Ref<Sequencer>;
    type State = FixturePriority;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Set Priority of Sequence '{}' to {:?}",
            self.sequence_id, self.priority
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            previous = Some(sequence.priority);
            sequence.priority = self.priority;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, priority: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            sequence.priority = priority;

            Ok(())
        })?;

        Ok(())
    }
}
