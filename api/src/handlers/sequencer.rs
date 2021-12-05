use mizer_sequencer::Sequencer;

use crate::models::{Sequence, Sequences};
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
}
