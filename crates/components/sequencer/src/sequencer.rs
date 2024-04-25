use dashmap::DashMap;
use std::cell::{RefCell, RefMut};
use std::collections::HashMap;
use std::ops::Deref;
use std::sync::atomic::{AtomicU32, Ordering};
use std::sync::mpsc;
use std::sync::Arc;

use indexmap::IndexSet;
use pinboard::NonEmptyPinboard;

use mizer_fixtures::manager::FixtureManager;
use mizer_module::ClockFrame;
use mizer_util::ThreadPinned;

use crate::contracts::StdClock;
use crate::state::SequenceState;
use crate::{EffectEngine, Sequence};

#[derive(Clone)]
pub struct Sequencer {
    sequence_counter: Arc<AtomicU32>,
    sequences: Arc<DashMap<u32, Sequence>>,
    sequence_states: Arc<ThreadPinned<RefCell<HashMap<u32, SequenceState>>>>,
    sequence_order: Arc<ThreadPinned<RefCell<IndexSet<u32>>>>,
    sequence_view: Arc<NonEmptyPinboard<HashMap<u32, SequenceView>>>,
    commands: (
        mpsc::SyncSender<SequencerCommands>,
        Arc<ThreadPinned<mpsc::Receiver<SequencerCommands>>>,
    ),
    clock: StdClock,
}

#[derive(Debug, Clone)]
pub struct SequenceView {
    pub active: bool,
    pub cue_id: Option<u32>,
    pub rate: f64,
}

impl Default for SequenceView {
    fn default() -> Self {
        Self {
            active: false,
            cue_id: None,
            rate: 1f64,
        }
    }
}

impl Default for Sequencer {
    fn default() -> Self {
        let (tx, rx) = mpsc::sync_channel(100);
        Sequencer {
            sequence_counter: AtomicU32::new(1).into(),
            sequences: Default::default(),
            sequence_states: Default::default(),
            sequence_order: Default::default(),
            sequence_view: NonEmptyPinboard::new(Default::default()).into(),
            commands: (tx, Arc::new(rx.into())),
            clock: StdClock,
        }
    }
}

impl Sequencer {
    pub fn new() -> Self {
        Self::default()
    }

    pub(crate) fn run_sequences(
        &self,
        fixture_manager: &FixtureManager,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        let mut states = self.sequence_states.deref().deref().borrow_mut();
        self.handle_commands(&self.sequences, &mut states, effect_engine, frame);
        self.handle_sequences(
            &self.sequences,
            &mut states,
            fixture_manager,
            effect_engine,
            frame,
        );
        self.update_views(&self.sequences, &states);
        let active_sequences = states.values().filter(|state| state.active).count();
        mizer_util::plot!("Running Sequences", active_sequences as f64);
        tracing::trace!("{:?}", states);
    }

    fn handle_commands(
        &self,
        sequences: &DashMap<u32, Sequence>,
        states: &mut HashMap<u32, SequenceState>,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        profiling::scope!("Sequencer::handle_commands");
        let mut sequence_orders = self.sequence_order.borrow_mut();
        for command in self.commands.1.try_iter() {
            match command {
                SequencerCommands::Go(sequence_id) => {
                    let state = states.entry(sequence_id).or_default();
                    if let Some(sequence) = sequences.get(&sequence_id) {
                        let was_active = state.active;
                        state.go(sequence.value(), &self.clock, effect_engine, frame);
                        let is_active = state.active;
                        if !is_active {
                            sequence_orders.shift_remove(&sequence_id);
                        }
                        if is_active && !was_active {
                            sequence_orders.insert(sequence_id);
                        }
                    }
                }
                SequencerCommands::GoTo(sequence_id, cue_id) => {
                    let state = states.entry(sequence_id).or_default();
                    if let Some(sequence) = sequences.get(&sequence_id) {
                        let was_active = state.active;
                        state.go_to(sequence.value(), cue_id, &self.clock, effect_engine, frame);
                        let is_active = state.active;
                        if !is_active {
                            sequence_orders.shift_remove(&sequence_id);
                        } else if is_active && !was_active {
                            sequence_orders.insert(sequence_id);
                        }
                    }
                }
                SequencerCommands::Stop(sequence_id) => {
                    let state = states.entry(sequence_id).or_default();
                    if let Some(sequence) = sequences.get(&sequence_id) {
                        state.stop(sequence.value(), effect_engine, &self.clock, frame);
                    }
                    sequence_orders.shift_remove(&sequence_id);
                }
                SequencerCommands::SetRate(sequence_id, rate) => {
                    if let Some(state) = states.get_mut(&sequence_id) {
                        state.rate = rate;
                    }
                }
                SequencerCommands::DropState(sequence_id) => {
                    let state = states.entry(sequence_id).or_default();
                    if let Some(sequence) = sequences.get(&sequence_id) {
                        state.stop(sequence.value(), effect_engine, &self.clock, frame);
                    }
                    states.remove(&sequence_id);
                    sequence_orders.shift_remove(&sequence_id);
                }
            }
        }
    }

    fn handle_sequences(
        &self,
        sequences: &DashMap<u32, Sequence>,
        states: &mut HashMap<u32, SequenceState>,
        fixture_manager: &FixtureManager,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        profiling::scope!("Sequencer::handle_sequences");
        let orders = self.sequence_order.borrow();
        for id in orders.iter() {
            let state = states.entry(*id).or_default();
            if let Some(sequence) = sequences.get(id) {
                sequence.run(state, &self.clock, fixture_manager, effect_engine, &fixture_manager.presets, frame);
            }
        }
    }

    fn update_views(
        &self,
        sequences: &DashMap<u32, Sequence>,
        states: &RefMut<HashMap<u32, SequenceState>>,
    ) {
        profiling::scope!("Sequencer::update_views");
        let mut view = self.sequence_view.read();
        for (id, state) in states.iter() {
            if let Some(sequence) = sequences.get(id) {
                let view = view.entry(*id).or_default();
                view.active = state.active;
                view.cue_id = sequence.cues.get(state.active_cue_index).map(|cue| cue.id);
                view.rate = state.rate;
            }
        }
        self.sequence_view.set(view);
    }

    pub fn new_sequence(&self) -> Sequence {
        let sequence_id = self.sequence_counter.fetch_add(1, Ordering::AcqRel);
        let sequence = Sequence::new(sequence_id);
        self.add_sequence(sequence.clone());

        sequence
    }

    pub fn add_sequence(&self, sequence: Sequence) {
        let sequence_id = sequence.id;
        self.sequences.insert(sequence_id, sequence);
        let mut view = self.sequence_view.read();
        view.insert(sequence_id, SequenceView::default());
        self.sequence_view.set(view);
    }

    pub fn delete_sequence(&self, sequence: u32) -> Option<Sequence> {
        let result = self.sequences.remove(&sequence).map(|(_, s)| s);
        self.commands
            .0
            .send(SequencerCommands::DropState(sequence))
            .unwrap();

        result
    }

    pub fn sequence_go(&self, sequence: u32) {
        self.commands
            .0
            .send(SequencerCommands::Go(sequence))
            .unwrap();
    }

    pub fn sequence_go_to(&self, sequence: u32, cue: u32) {
        self.commands
            .0
            .send(SequencerCommands::GoTo(sequence, cue))
            .unwrap();
    }

    pub fn sequence_stop(&self, sequence: u32) {
        self.commands
            .0
            .send(SequencerCommands::Stop(sequence))
            .unwrap();
    }

    pub fn sequence_playback_rate(&self, sequence: u32, rate: f64) -> anyhow::Result<()> {
        self.commands
            .0
            .send(SequencerCommands::SetRate(sequence, rate))?;

        Ok(())
    }

    pub fn update_sequence<SU>(&self, sequence: u32, update: SU) -> anyhow::Result<()>
    where
        SU: FnOnce(&mut Sequence) -> anyhow::Result<()>,
    {
        let mut sequence = self
            .sequences
            .get_mut(&sequence)
            .ok_or_else(|| anyhow::anyhow!("Unknown sequence {}", sequence))?;
        update(sequence.value_mut())?;

        Ok(())
    }

    pub fn clear(&self) {
        self.sequences.clear();
        let states = self.sequence_states.deref().deref();
        states.borrow_mut().clear();
        self.sequence_view.set(Default::default());
        self.sequence_counter.store(1, Ordering::Relaxed);
        let orders = self.sequence_order.deref().deref();
        orders.borrow_mut().clear();
    }

    pub fn sequences(&self) -> Vec<Sequence> {
        profiling::scope!("Sequencer::sequences");
        self.sequences.iter().map(|r| r.value().clone()).collect()
    }

    pub fn sequence(&self, sequence_id: u32) -> Option<Sequence> {
        self.sequences.get(&sequence_id).map(|r| r.value().clone())
    }

    /// Override all existing sequences
    ///
    /// sets id counter to highest id in the given list of sequences
    /// should only be used for project loading
    pub fn load_sequences(&self, sequences: Vec<Sequence>) {
        let id = sequences.iter().map(|s| s.id + 1).max().unwrap_or(1);
        self.sequence_counter.store(id, Ordering::Relaxed);
        self.sequence_view.set(
            sequences
                .iter()
                .map(|s| (s.id, SequenceView::default()))
                .collect(),
        );

        self.sequences.clear();
        for sequence in sequences.into_iter() {
            self.sequences.insert(sequence.id, sequence);
        }
        tracing::debug!("Sequences: {:?}", self.sequences);
    }

    pub fn get_sequencer_view(&self) -> SequencerView {
        SequencerView(self.sequence_view.clone())
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum SequencerCommands {
    Go(u32),
    GoTo(u32, u32),
    Stop(u32),
    DropState(u32),
    SetRate(u32, f64),
}

#[derive(Clone)]
pub struct SequencerView(Arc<NonEmptyPinboard<HashMap<u32, SequenceView>>>);

impl SequencerView {
    pub fn read(&self) -> HashMap<u32, SequenceView> {
        self.0.read()
    }
}
