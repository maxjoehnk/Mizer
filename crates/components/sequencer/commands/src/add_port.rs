use mizer_commander::{Command, Ref};
use mizer_node_ports::NodePortId;
use mizer_sequencer::Sequencer;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddPortToSequenceCommand {
    pub sequence_id: u32,
    pub port_id: NodePortId,
}

impl<'a> Command<'a> for AddPortToSequenceCommand {
    type Dependencies = Ref<Sequencer>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Add {} to Sequence {}", self.port_id, self.sequence_id)
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        sequencer.update_sequence(self.sequence_id, |s| {
            s.add_port(self.port_id);

            Ok(())
        })?;

        Ok(((), ()))
    }

    fn revert(&self, sequencer: &Sequencer, _: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |s| s.remove_port(self.port_id))?;

        Ok(())
    }
}
