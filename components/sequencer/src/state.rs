use crate::Sequence;
use std::time::{Duration, Instant};
use std::collections::HashMap;

#[derive(Debug, Default)]
pub(crate) struct SequenceState {
    pub active_cue_index: u32,
    pub active: bool,
    last_go: Option<Instant>,
    pub fixture_values: HashMap<(u32, String), f64>,
}

impl SequenceState {
    pub fn go(&mut self, sequence: &Sequence) {
        self.last_go = Some(Instant::now());
        if !self.active {
            self.active = true;
            self.active_cue_index = 0;
        }else {
            self.next_cue(sequence);
        }
    }

    fn next_cue(&mut self, sequence: &Sequence) {
        self.active_cue_index += 1;
        if self.active_cue_index as usize >= sequence.cues.len() {
            self.active_cue_index = 0;
            self.active = false;
        }
    }

    pub fn get_timer(&self) -> Duration {
        Instant::now().duration_since(self.last_go.unwrap_or_else(|| Instant::now()))
    }

    pub fn get_fixture_value(&self, fixture: u32, channel: &str) -> Option<f64> {
        self.fixture_values.get(&(fixture, channel.to_string())).copied()
    }
}
