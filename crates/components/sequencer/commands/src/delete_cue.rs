use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_nodes::SequencerNode;
use mizer_runtime::commands::DeleteNodesCommand;
use mizer_runtime::Pipeline;
use mizer_sequencer::{Cue, Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteCueCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
}

impl<'a> Command<'a> for DeleteCueCommand {
    type Dependencies = Ref<Sequencer>;
    type State = Cue;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Cue {}.{}", self.sequence_id, self.cue_id)
    }

    fn apply(
        &self,
        sequencer: &Sequencer
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = sequence.delete_cue(self.cue_id)?;
            previous = Some(cue);

            Ok(())
        })?;

        let previous = previous.ok_or_else(|| anyhow::anyhow!("Unknown cue {}", self.cue_id))?;

        Ok(((), previous))
    }

    fn revert(
        &self,
        sequencer: &Sequencer,
        cue: Cue,
    ) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            sequence.cues.insert(self.cue_id as usize - 1, cue);
            Ok(())
        })?;

        Ok(())
    }
}
