use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_nodes::SequencerNode;
use mizer_runtime::commands::DeleteNodesCommand;
use mizer_runtime::Pipeline;
use mizer_sequencer::{Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteSequenceCommand {
    pub sequence_id: u32,
}

impl<'a> Command<'a> for DeleteSequenceCommand {
    type Dependencies = (
        Ref<Sequencer>,
        Ref<Pipeline>,
        SubCommand<DeleteNodesCommand>,
    );
    type State = (Sequence, sub_command!(DeleteNodesCommand));
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Sequence '{}'", self.sequence_id)
    }

    fn apply(
        &self,
        (sequencer, pipeline, delete_nodes_runner): (
            &Sequencer,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let sequence = sequencer
            .delete_sequence(self.sequence_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown sequence {}", self.sequence_id))?;
        let path = pipeline
            .find_node_path::<SequencerNode>(|node| node.sequence_id == self.sequence_id)
            .cloned()
            .ok_or_else(|| anyhow::anyhow!("Missing node for sequence {}", self.sequence_id))?;
        let sub_cmd = DeleteNodesCommand { paths: vec![path] };
        let (_, state) = delete_nodes_runner.apply(sub_cmd)?;

        Ok(((), (sequence, state)))
    }

    fn revert(
        &self,
        (sequencer, _, delete_nodes_runner): (
            &Sequencer,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
        (sequence, delete_node_cmd): Self::State,
    ) -> anyhow::Result<()> {
        sequencer.add_sequence(sequence);
        delete_nodes_runner.revert(delete_node_cmd)?;

        Ok(())
    }
}
