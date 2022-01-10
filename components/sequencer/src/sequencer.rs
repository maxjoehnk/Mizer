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
    sequence_view: Arc<NonEmptyPinboard<HashMap<u32, SequenceView>>>,
    commands: (
        mpsc::SyncSender<SequencerCommands>,
        Arc<ThreadPinned<mpsc::Receiver<SequencerCommands>>>,
    ),
    clock: StdClock,
}

#[derive(Default, Debug, Clone)]
pub struct SequenceView {
    pub active: bool,
    pub cue_id: Option<u32>,
}

impl Sequencer {
    pub fn new() -> Self {
        let (tx, rx) = mpsc::sync_channel(100);
        Sequencer {
            sequence_counter: AtomicU32::new(1).into(),
            sequences: NonEmptyPinboard::new(Default::default()).into(),
            sequence_states: Default::default(),
            sequence_view: NonEmptyPinboard::new(Default::default()).into(),
            commands: (tx, Arc::new(rx.into())),
            clock: StdClock,
        }
    }

    pub(crate) fn run_sequences(&self, fixture_manager: &FixtureManager) {
        let sequences = self.sequences.read();
        let mut states = self.sequence_states.deref().deref().borrow_mut();
        let mut view = self.sequence_view.read();
        self.handle_commands(&sequences, &mut states);
        self.handle_sequences(&sequences, &mut states, fixture_manager);
        for (id, state) in states.iter() {
            if let Some(sequence) = sequences.get(id) {
                let view = view.entry(*id).or_default();
                view.active = state.active;
                view.cue_id = sequence.cues.get(state.active_cue_index).map(|cue| cue.id);
            }
        }
        self.sequence_view.set(view);
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
                SequencerCommands::Stop(sequencer) => {
                    if let Some(state) = states.get_mut(&sequencer) {
                        state.stop(&sequences[&sequencer], &self.clock);
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
        let sequence = Sequence::new(i);
        let mut sequences = self.sequences.read();
        sequences.insert(i, sequence.clone());
        self.sequences.set(sequences);
        let mut view = self.sequence_view.read();
        view.insert(i, SequenceView::default());
        self.sequence_view.set(view);

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

    pub fn sequence_stop(&self, sequence: u32) {
        self.commands.0.send(SequencerCommands::Stop(sequence));
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
        self.sequence_view.set(Default::default());
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
        self.sequence_view.set(sequences.iter().map(|s| (s.id, SequenceView::default())).collect());
        self.sequences
            .set(sequences.into_iter().map(|s| (s.id, s)).collect());
        log::debug!("Sequences: {:?}", self.sequences.read());
    }

    pub fn get_sequencer_view(&self) -> SequencerView {
        SequencerView(self.sequence_view.clone())
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum SequencerCommands {
    Go(u32),
    Stop(u32),
    DropState(u32),
}

#[derive(Clone)]
pub struct SequencerView(Arc<NonEmptyPinboard<HashMap<u32, SequenceView>>>);

impl SequencerView {
    pub fn read(&self) -> HashMap<u32, SequenceView> {
        self.0.read()
    }
}
