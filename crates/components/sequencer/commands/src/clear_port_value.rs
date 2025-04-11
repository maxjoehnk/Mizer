use crate::get_cue;
use mizer_commander::{Command, Ref};
use mizer_node_ports::NodePortId;
use mizer_sequencer::{CuePort, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ClearPortValueInSequenceCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub port_id: NodePortId,
}

impl<'a> Command<'a> for ClearPortValueInSequenceCommand {
    type Dependencies = Ref<Sequencer>;
    type State = CuePort;
    type Result = ();

    fn label(&self) -> String {
        format!("Remove {} from Sequence {}.{}", self.port_id, self.sequence_id, self.cue_id)
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |s| {
            let cue = get_cue(s, self.cue_id)?;

            previous = if let Some(index) = cue.ports.iter().position(|p| p.port_id == self.port_id)
            {
                Some(cue.ports.remove(index))
            } else {
                anyhow::bail!("Port {} not found in cue {}", self.port_id, self.cue_id);
            };

            Ok(())
        })?;

        Ok(((), previous.unwrap()))
    }

    fn revert(&self, sequencer: &Sequencer, previous: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |s| {
            let cue = get_cue(s, self.cue_id)?;

            cue.ports.push(previous);

            Ok(())
        })?;

        Ok(())
    }
}
