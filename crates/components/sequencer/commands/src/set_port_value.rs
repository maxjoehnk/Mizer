use crate::get_cue;
use mizer_commander::{Command, Ref};
use mizer_node_ports::NodePortId;
use mizer_sequencer::{CuePort, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct SetPortValueInSequenceCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub port_id: NodePortId,
    pub value: f64,
}

impl<'a> Command<'a> for SetPortValueInSequenceCommand {
    type Dependencies = Ref<Sequencer>;
    type State = Option<f64>;
    type Result = ();

    fn label(&self) -> String {
        format!("Add {} to Sequence {}", self.port_id, self.sequence_id)
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |s| {
            let cue = get_cue(s, self.cue_id)?;

            previous = if let Some(index) = cue.ports.iter().position(|p| p.port_id == self.port_id)
            {
                let mut value = self.value;
                std::mem::swap(&mut cue.ports[index].value, &mut value);

                Some(value)
            } else {
                cue.ports.push(CuePort {
                    port_id: self.port_id,
                    value: self.value,
                });

                None
            };

            Ok(())
        })?;

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, previous: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |s| {
            let cue = get_cue(s, self.cue_id)?;

            if let Some(index) = cue.ports.iter().position(|p| p.port_id == self.port_id) {
                if let Some(previous_value) = previous {
                    cue.ports[index].value = previous_value;
                } else {
                    cue.ports.remove(index);
                }
            }

            Ok(())
        })?;

        Ok(())
    }
}
