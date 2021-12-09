use std::cmp::Ordering;

use serde::{Deserialize, Serialize};

use crate::state::SequenceState;
use crate::contracts::*;
use crate::cue::*;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Sequence {
    pub id: u32,
    pub name: String,
    pub cues: Vec<Cue>,
}

impl Sequence {
    pub(crate) fn run(&self, state: &mut SequenceState, clock: &impl Clock, fixture_controller: &impl FixtureController) {
        if !state.active {
            return;
        }
        // TODO: the sequence state should ensure active_cue_index is always in the proper range
        let cue = self.current_cue(state, clock);
        if let Some(next_cue) = state.get_next_cue(&self) {
            if next_cue.should_go(&state, clock) {
                state.go(&self, clock);
            }
        }
        cue.update_state(state, clock);
        for channel in &cue.channels {
            for (fixture_id, value) in channel.values(&state, clock) {
                if let Some(value) = value {
                    fixture_controller.write(fixture_id, channel.control.clone(), value);
                }
            }
        }
    }

    fn current_cue(&self, state: &mut SequenceState, clock: &impl Clock) -> &Cue {
        let cue = &self.cues[state.active_cue_index];
        if state.is_cue_finished() {
            if let LoopMode::JumpTo(cue_id) = cue.loop_mode {
                state.jump_to(&self, cue_id, clock);
                return &self.cues[state.active_cue_index];
            }
        }

        cue
    }

    /// Returns cue id
    pub fn add_cue(&mut self) -> u32 {
        let id = self.cues.len() as u32 + 1;
        let cue = Cue {
            id,
            name: format!("Cue {}", id),
            channels: Vec::new(),
            trigger: CueTrigger::Go,
            loop_mode: LoopMode::None,
            time: None,
        };
        self.cues.push(cue);

        id
    }
}

impl PartialOrd for Sequence {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.id.partial_cmp(&other.id)
    }
}
