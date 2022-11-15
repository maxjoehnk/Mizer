use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_node::{NodeDesigner, NodeType};
use mizer_nodes::SequencerNode;
use mizer_runtime::commands::AddNodeCommand;
use mizer_sequencer::{Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DuplicateSequenceCommand {
    pub sequence_id: u32,
}

impl<'a> Command<'a> for DuplicateSequenceCommand {
    type Dependencies = (Ref<Sequencer>, SubCommand<AddNodeCommand>);
    type State = (u32, sub_command!(AddNodeCommand));
    type Result = Sequence;

    fn label(&self) -> String {
        format!("Add Sequence")
    }

    fn apply(
        &self,
        (sequencer, runner): (&Sequencer, SubCommandRunner<AddNodeCommand>),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let existing_sequence = sequencer
            .sequence(self.sequence_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown sequence {}", self.sequence_id))?;
        let sequence = sequencer.new_sequence();
        sequencer.update_sequence(sequence.id, |s| {
            s.cues = existing_sequence.cues;
            s.fixtures = existing_sequence.fixtures;
            s.wrap_around = existing_sequence.wrap_around;

            Ok(())
        })?;
        let sequence_id = sequence.id;
        let node = SequencerNode {
            sequence_id,
            ..Default::default()
        };
        let sub_cmd = AddNodeCommand {
            node_type: NodeType::Sequencer,
            designer: NodeDesigner {
                hidden: true,
                ..Default::default()
            },
            node: Some(node.into()),
            parent: None,
        };
        let (_, state) = runner.apply(sub_cmd)?;

        Ok((sequence, (sequence_id, state)))
    }

    fn revert(
        &self,
        (sequencer, runner): (&Sequencer, SubCommandRunner<AddNodeCommand>),
        (sequence_id, add_node_state): Self::State,
    ) -> anyhow::Result<()> {
        runner.revert(add_node_state)?;
        sequencer.delete_sequence(sequence_id);

        Ok(())
    }
}
