use mizer_node::NodeType;
use mizer_nodes::Node;
use mizer_sequencer::Sequencer;

use crate::models::{CueTriggerRequest, Sequence, Sequences};
use crate::RuntimeApi;

#[derive(Clone)]
pub struct SequencerHandler<R: RuntimeApi> {
    sequencer: Sequencer,
    runtime: R,
}

impl<R: RuntimeApi> SequencerHandler<R> {
    pub fn new(sequencer: Sequencer, runtime: R) -> Self {
        Self { sequencer, runtime }
    }

    pub fn get_sequences(&self) -> Sequences {
        let sequences = self.sequencer.sequences();
        let sequences = sequences.into_iter().map(Sequence::from).collect();

        Sequences {
            sequences,
            ..Default::default()
        }
    }

    pub fn get_sequence(&self, sequence_id: u32) -> Option<Sequence> {
        self.sequencer.sequence(sequence_id)
            .map(Sequence::from)
    }

    pub fn add_sequence(&self) -> Sequence {
        let sequence = self.sequencer.add_sequence();
        self.runtime.add_node_for_sequence(sequence.id).unwrap();

        sequence.into()
    }

    pub fn sequence_go(&self, sequence: u32) {
        self.sequencer.sequence_go(sequence);
    }

    pub fn delete_sequence(&self, sequence: u32) -> anyhow::Result<()> {
        self.delete_sequence_node(sequence)?;
        self.sequencer.delete_sequence(sequence);

        Ok(())
    }

    fn delete_sequence_node(&self, id: u32) -> anyhow::Result<()> {
        if let Some(path) = self.runtime.nodes()
            .into_iter()
            .filter(|node| node.node_type() == NodeType::Sequencer)
            .find(|node| if let Node::Sequencer(sequencer_node) = node.downcast() {
                sequencer_node.sequence_id == id
            } else { false })
            .map(|node| node.path) {
            self.runtime.delete_node(path)?;
        }
        Ok(())
    }

    pub fn update_cue_trigger(&self, request: CueTriggerRequest) {
        self.sequencer.update_sequence(request.sequence, |sequence| {
            if let Some(cue) = sequence.cues.iter_mut().find(|cue| cue.id == request.cue) {
                cue.trigger = request.trigger.into();
            }
        });
    }
}
