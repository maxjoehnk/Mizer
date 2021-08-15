use mizer_sequencer::Sequencer;

use crate::models::{Sequence, Sequences};

#[derive(Clone)]
pub struct SequencerHandler {
    sequencer: Sequencer,
}

impl SequencerHandler {
    pub fn new(sequencer: Sequencer) -> Self {
        Self { sequencer }
    }

    pub fn get_sequences(&self) -> Sequences {
        let sequences = self.sequencer.sequences();
        let sequences = sequences.into_iter().map(Sequence::from).collect();

        Sequences {
            sequences,
            ..Default::default()
        }
    }

    pub fn add_sequence(&self) -> Sequence {
        self.sequencer.add_sequence().into()
    }

    pub fn sequence_go(&self, sequence: u32) {
        self.sequencer.sequence_go(sequence);
    }
}
