use crate::{Cue, Sequence};
use std::time::{Duration, Instant};
use std::collections::HashMap;
use mizer_fixtures::definition::FixtureControl;
use mizer_fixtures::FixtureId;

#[derive(Debug, Default)]
pub(crate) struct SequenceState {
    pub active_cue_index: u32,
    pub active: bool,
    last_go: Option<Instant>,
    pub fixture_values: HashMap<(FixtureId, FixtureControl), f64>,
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

    pub fn get_fixture_value(&self, fixture_id: FixtureId, control: &FixtureControl) -> Option<f64> {
        self.fixture_values.get(&(fixture_id, control.clone())).copied()
    }

    pub fn get_next_cue<'a>(&self, sequence: &'a Sequence) -> Option<&'a Cue> {
        let next_cue_index = (self.active_cue_index + 1) as usize;
        if next_cue_index >= sequence.cues.len() {
            None
        }else {
            Some(&sequence.cues[next_cue_index])
        }
    }
}
