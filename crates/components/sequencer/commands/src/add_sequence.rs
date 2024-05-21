use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_node::{NodeDesigner, NodeType};
use mizer_nodes::SequencerNode;
use mizer_runtime::commands::AddNodeCommand;
use mizer_sequencer::{Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddSequenceCommand {}

impl<'a> Command<'a> for AddSequenceCommand {
    type Dependencies = (Ref<Sequencer>, SubCommand<AddNodeCommand>);
    type State = (u32, sub_command!(AddNodeCommand));
    type Result = Sequence;

    fn label(&self) -> String {
        "Add Sequence".to_string()
    }

    fn apply(
        &self,
        (sequencer, runner): (&Sequencer, SubCommandRunner<AddNodeCommand>),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let sequence = sequencer.new_sequence();
        let sequence_id = sequence.id;
        let node = SequencerNode { sequence_id };
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
