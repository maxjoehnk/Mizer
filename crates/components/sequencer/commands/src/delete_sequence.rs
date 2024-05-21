use mizer_commander::{sub_command, Command, Ref, RefMut};
use mizer_layouts::LayoutStorage;
use mizer_nodes::{Node, NodeDowncast};
use mizer_runtime::commands::DeleteNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::ExecutionPlanner;
use mizer_sequencer::{Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteSequenceCommand {
    pub sequence_id: u32,
}

impl<'a> Command<'a> for DeleteSequenceCommand {
    type Dependencies = (
        Ref<Sequencer>,
        RefMut<PipelineAccess>,
        RefMut<ExecutionPlanner>,
        Ref<LayoutStorage>,
    );
    type State = (Sequence, sub_command!(DeleteNodeCommand));
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Sequence '{}'", self.sequence_id)
    }

    fn apply(
        &self,
        (sequencer, pipeline, planner, layout_storage): (
            &Sequencer,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
            &LayoutStorage,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let sequence = sequencer
            .delete_sequence(self.sequence_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown sequence {}", self.sequence_id))?;
        let path = pipeline
            .nodes_view
            .iter()
            .find(|node| {
                if let Node::Sequencer(node) = node.downcast() {
                    node.sequence_id == self.sequence_id
                } else {
                    false
                }
            })
            .map(|node| node.key().clone())
            .ok_or_else(|| anyhow::anyhow!("Missing node for sequence {}", self.sequence_id))?;
        let sub_cmd = DeleteNodeCommand { path };
        let (_, path) = sub_cmd.apply((pipeline, planner, layout_storage))?;

        Ok(((), (sequence, (sub_cmd, path))))
    }

    fn revert(
        &self,
        (sequencer, pipeline, planner, layout_storage): (
            &Sequencer,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
            &LayoutStorage,
        ),
        (sequence, (delete_node_cmd, delete_node_state)): Self::State,
    ) -> anyhow::Result<()> {
        sequencer.add_sequence(sequence);
        delete_node_cmd.revert((pipeline, planner, layout_storage), delete_node_state)?;

        Ok(())
    }
}
