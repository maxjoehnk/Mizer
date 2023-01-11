use std::cmp::Ordering;
use std::ops::Deref;

use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;
use serde::{Deserialize, Serialize};

use crate::contracts::*;
use crate::cue::*;
use crate::state::SequenceState;
use crate::EffectEngine;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Sequence {
    pub id: u32,
    pub name: String,
    pub fixtures: Vec<FixtureId>,
    pub cues: Vec<Cue>,
    /// Go to first cue after last cue
    #[serde(default)]
    pub wrap_around: bool,
    /// Auto stop after last cue
    #[serde(default)]
    pub stop_on_last_cue: bool,
}

#[cfg(test)]
impl Default for Sequence {
    fn default() -> Self {
        Self::new(1)
    }
}

impl Sequence {
    pub fn new(id: u32) -> Self {
        Self {
            id,
            name: format!("Sequence {}", id),
            cues: Vec::new(),
            fixtures: Default::default(),
            wrap_around: false,
            stop_on_last_cue: false,
        }
    }

    pub(crate) fn run(
        &self,
        state: &mut SequenceState,
        clock: &impl Clock,
        fixture_controller: &impl FixtureController,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        profiling::scope!("Sequence::run");
        if !state.active {
            return;
        }
        state.update_timestamps_based_on_rate(clock, frame);
        if let Some(next_cue) = state.get_next_cue(self) {
            if next_cue.should_go(state) {
                state.go(self, clock, effect_engine, frame);
            }
        }
        if state.get_next_cue(self).is_none() && state.is_cue_finished() && self.stop_on_last_cue {
            state.go(self, clock, effect_engine, frame);
        }
        // TODO: the sequence state should ensure active_cue_index is always in the proper range
        let cue = self.current_cue(state);
        cue.update_state(self, state, clock, frame);
        for control in &cue.controls {
            for (fixture_id, value) in control.values(self, cue, state) {
                if let Some(value) = value {
                    fixture_controller.write(fixture_id, control.control.clone(), value);
                    state.set_fixture_value(fixture_id, control.control.clone(), value);
                }
            }
        }
        for effect in &cue.effects {
            if let Some(id) = state.running_effects.get(effect) {
                effect_engine.set_instance_rate(id, state.rate);
                continue;
            }
            if let Some(id) =
                effect_engine.run_effect(effect.effect, effect.fixtures.deref().clone(), state.rate)
            {
                state.running_effects.insert(effect.clone(), id);
            }
        }
    }

    fn current_cue(&self, state: &mut SequenceState) -> &Cue {
        &self.cues[state.active_cue_index]
    }

    /// Returns cue id
    pub fn add_cue(&mut self) -> u32 {
        let id = self.cues.len() as u32 + 1;
        let cue = Cue {
            id,
            name: format!("Cue {}", id),
            controls: Vec::new(),
            effects: Vec::new(),
            trigger: CueTrigger::Go,
            trigger_time: None,
            cue_fade: None,
            cue_delay: None,
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
