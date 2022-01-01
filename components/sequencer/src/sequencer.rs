use std::cell::RefCell;
use std::collections::HashMap;
use std::ops::Deref;
use std::sync::atomic::{AtomicU32, Ordering};
use std::sync::mpsc;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_util::ThreadPinned;

use crate::contracts::StdClock;
use crate::state::SequenceState;
use crate::Sequence;
use mizer_fixtures::manager::FixtureManager;

#[derive(Clone)]
pub struct Sequencer {
    sequence_counter: Arc<AtomicU32>,
    sequences: Arc<NonEmptyPinboard<HashMap<u32, Sequence>>>,
    sequence_states: Arc<ThreadPinned<RefCell<HashMap<u32, SequenceState>>>>,
    commands: (
        mpsc::SyncSender<SequencerCommands>,
        Arc<ThreadPinned<mpsc::Receiver<SequencerCommands>>>,
    ),
    clock: StdClock,
}

impl Sequencer {
    pub fn new() -> Self {
        let (tx, rx) = mpsc::sync_channel(100);
        Sequencer {
            sequence_counter: AtomicU32::new(1).into(),
            sequences: NonEmptyPinboard::new(Default::default()).into(),
            sequence_states: Default::default(),
            commands: (tx, Arc::new(rx.into())),
            clock: StdClock,
        }
    }

    pub(crate) fn run_sequences(&self, fixture_manager: &FixtureManager) {
        let sequences = self.sequences.read();
        let mut states = self.sequence_states.deref().deref().borrow_mut();
        self.handle_commands(&sequences, &mut states);
        self.handle_sequences(&sequences, &mut states, fixture_manager);
        log::trace!("{:?}", states);
    }

    fn handle_commands(
        &self,
        sequences: &HashMap<u32, Sequence>,
        states: &mut HashMap<u32, SequenceState>,
    ) {
        for command in self.commands.1.try_iter() {
            match command {
                SequencerCommands::Go(sequencer) => {
                    if let Some(state) = states.get_mut(&sequencer) {
                        state.go(&sequences[&sequencer], &self.clock);
                    }
                }
                SequencerCommands::DropState(sequence) => {
                    states.remove(&sequence);
                }
            }
        }
    }

    fn handle_sequences(
        &self,
        sequences: &HashMap<u32, Sequence>,
        states: &mut HashMap<u32, SequenceState>,
        fixture_manager: &FixtureManager,
    ) {
        for (i, sequence) in sequences {
            let state = states.entry(*i).or_default();
            sequence.run(state, &self.clock, fixture_manager);
        }
    }

    pub fn add_sequence(&self) -> Sequence {
        let i = self.sequence_counter.fetch_add(1, Ordering::AcqRel);
        let sequence = Sequence {
            id: i,
            name: format!("Sequence {}", i),
            cues: Vec::new(),
        };

        let mut sequences = self.sequences.read();
        sequences.insert(i, sequence.clone());
        self.sequences.set(sequences);

        sequence
    }

    pub fn delete_sequence(&self, sequence: u32) {
        let mut sequences = self.sequences.read();
        sequences.remove(&sequence);
        self.sequences.set(sequences);
        self.commands.0.send(SequencerCommands::DropState(sequence));
    }

    pub fn sequence_go(&self, sequence: u32) {
        self.commands.0.send(SequencerCommands::Go(sequence));
    }

    pub fn update_sequence<SU: FnOnce(&mut Sequence)>(&self, sequence: u32, update: SU) {
        let mut sequences = self.sequences.read();
        if let Some(sequence) = sequences.get_mut(&sequence) {
            update(sequence);
        }
        self.sequences.set(sequences);
    }

    pub fn clear(&self) {
        self.sequences.set(Default::default());
        let states = self.sequence_states.deref().deref();
        states.borrow_mut().clear();
        self.sequence_counter.store(1, Ordering::Relaxed);
    }

    pub fn sequences(&self) -> Vec<Sequence> {
        self.sequences.read().values().cloned().collect()
    }

    pub fn sequence(&self, sequence_id: u32) -> Option<Sequence> {
        self.sequences.read().get(&sequence_id).cloned()
    }

    /// Override all existing sequences
    ///
    /// sets id counter to highest id in the given list of sequences
    /// should only be used for project loading
    pub fn load_sequences(&self, sequences: Vec<Sequence>) {
        let id = sequences.iter().map(|s| s.id + 1).max().unwrap_or(1);
        self.sequence_counter.store(id, Ordering::Relaxed);
        self.sequences
            .set(sequences.into_iter().map(|s| (s.id, s)).collect());
        log::debug!("Sequences: {:?}", self.sequences.read());
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum SequencerCommands {
    Go(u32),
    DropState(u32),
}
