use std::cmp::Ordering;
use std::ops::Deref;

use serde::{Deserialize, Serialize};

use mizer_fixtures::programmer::Presets;
use mizer_fixtures::{FixtureId, FixturePriority};
use mizer_module::ClockFrame;

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
    #[serde(default)]
    pub priority: FixturePriority,
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
            priority: FixturePriority::default(),
        }
    }

    pub(crate) fn run(
        &self,
        state: &mut SequenceState,
        clock: &impl Clock,
        fixture_controller: &impl FixtureController,
        effect_engine: &EffectEngine,
        presets: &Presets,
        frame: ClockFrame,
    ) {
        profiling::scope!("Sequence::run", &self.name);
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
        if state.active_cue_index >= self.cues.len() {
            state.go(self, clock, effect_engine, frame);
        }
        let Some(cue) = self.current_cue(state) else {
            return;
        };
        cue.update_state(self, state, clock, frame);
        for control in &cue.controls {
            for (fixture_id, value) in control.values(cue, state) {
                if let Some(value) = value {
                    fixture_controller.write(
                        fixture_id,
                        control.control.clone(),
                        value.into(),
                        self.priority,
                    );
                    state.set_fixture_value(fixture_id, control.control.clone(), value);
                }
            }
        }
        for preset in &cue.presets {
            for (fixture_id, control, value) in preset.values(cue, state, presets) {
                fixture_controller.write(fixture_id, control.clone(), value, self.priority);
                state.set_fixture_value(fixture_id, control, value.get_percent());
            }
        }
        for effect in &cue.effects {
            if let Some(id) = state.running_effects.get(effect) {
                effect_engine.set_instance_rate(id, state.rate);
                effect_engine.set_instance_offset(id, effect.effect_offset);
                continue;
            }
            if let Some(id) = effect_engine.run_effect(
                effect.effect,
                effect.fixtures.deref().clone(),
                state.rate,
                effect.effect_offset,
                self.priority,
            ) {
                state.running_effects.insert(effect.clone(), id);
            }
        }
    }

    fn current_cue(&self, state: &mut SequenceState) -> Option<&Cue> {
        self.cues.get(state.active_cue_index)
    }

    /// Returns cue id
    pub fn add_cue(&mut self) -> u32 {
        let id = self.cues.len() as u32 + 1;
        let cue = Cue {
            id,
            name: format!("Cue {}", id),
            controls: Vec::new(),
            effects: Vec::new(),
            presets: Vec::new(),
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
