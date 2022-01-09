use crate::contracts::Clock;
use crate::{Cue, CueChannel, Sequence};
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::FixtureId;
use std::collections::HashMap;
use std::time::{Duration, Instant};

#[derive(Debug, Default)]
pub(crate) struct SequenceState {
    pub active_cue_index: usize,
    pub active: bool,
    last_go: Option<Instant>,
    /// Timestamp when the currently active cue has finished
    pub cue_finished_at: Option<Instant>,
    pub fixture_values: HashMap<(FixtureId, FixtureFaderControl), f64>,
    pub channel_state: HashMap<(FixtureId, FixtureFaderControl), CueChannelState>,
}

#[derive(Copy, Clone, Debug)]
pub enum CueChannelState {
    Delay,
    Fading,
    Active,
}

impl SequenceState {
    pub(crate) fn is_cue_finished(&self) -> bool {
        self.cue_finished_at.is_some()
    }

    pub fn jump_to(&mut self, sequence: &Sequence, cue_id: u32, clock: &impl Clock) {
        if let Some(cue_index) = sequence.cues.iter().position(|cue| cue.id == cue_id) {
            self.cue_finished_at = None;
            self.active_cue_index = cue_index;
            self.last_go = Some(clock.now());
            self.update_channel_states(sequence);
        }
    }

    pub fn go(&mut self, sequence: &Sequence, clock: &impl Clock) {
        self.last_go = Some(clock.now());
        self.cue_finished_at = None;
        if !self.active {
            self.active = true;
            self.active_cue_index = 0;
        } else {
            self.next_cue(sequence);
        }
        self.update_channel_states(sequence);
    }

    fn next_cue(&mut self, sequence: &Sequence) {
        self.active_cue_index += 1;
        if self.active_cue_index >= sequence.cues.len() {
            if sequence.wrap_around {
                self.active_cue_index = 0;
                return;
            }
            self.active_cue_index = 0;
            self.active = false;
        }
    }

    fn update_channel_states(&mut self, sequence: &Sequence) {
        self.channel_state.clear();
        for channel in &sequence.cues[self.active_cue_index].channels {
            let state = channel.initial_channel_state();
            for fixture in &channel.fixtures {
                self.channel_state
                    .insert((*fixture, channel.control.clone()), state);
            }
        }
    }

    pub fn get_timer(&self, clock: &impl Clock) -> Duration {
        clock
            .now()
            .duration_since(self.last_go.unwrap_or_else(|| clock.now()))
    }

    pub fn get_fixture_value(
        &self,
        fixture_id: FixtureId,
        control: &FixtureFaderControl,
    ) -> Option<f64> {
        self.fixture_values
            .get(&(fixture_id, control.clone()))
            .copied()
    }

    pub fn get_next_cue<'a>(&self, sequence: &'a Sequence) -> Option<&'a Cue> {
        let next_cue_index = self.active_cue_index + 1;
        if next_cue_index >= sequence.cues.len() {
            if sequence.wrap_around {
                Some(&sequence.cues[0])
            }else {
                None
            }
        } else {
            Some(&sequence.cues[next_cue_index])
        }
    }
}

impl CueChannel {
    fn initial_channel_state(&self) -> CueChannelState {
        if self.delay.is_some() {
            CueChannelState::Delay
        } else if self.fade.is_some() {
            CueChannelState::Fading
        } else {
            CueChannelState::Active
        }
    }
}
