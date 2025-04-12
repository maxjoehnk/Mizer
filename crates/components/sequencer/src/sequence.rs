use std::cmp::Ordering;
use std::ops::Deref;
use std::time::Duration;
use serde::{Deserialize, Serialize};

use crate::contracts::*;
use crate::cue::*;
use crate::state::SequenceState;
use crate::{EffectEngine, SequencerTime, SequencerValue};
use mizer_fixtures::manager::{FadeTimings, FixtureValueSource};
use mizer_fixtures::programmer::Presets;
use mizer_fixtures::{FixtureId, FixturePriority};
use mizer_module::ClockFrame;
use mizer_node_ports::{NodePortId, NodePortState};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Sequence {
    pub id: u32,
    pub name: String,
    pub fixtures: Vec<FixtureId>,
    pub cues: Vec<Cue>,
    #[serde(default)]
    pub ports: Vec<NodePortId>,
    /// Go to first cue after last cue
    #[serde(default)]
    pub wrap_around: bool,
    /// Auto stop after last cue
    #[serde(default)]
    pub stop_on_last_cue: bool,
    #[serde(default)]
    pub priority: FixturePriority,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct SequenceId(pub u32);

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
            ports: Vec::new(),
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
        ports_state: &NodePortState,
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
                        value,
                        self.priority,
                        cue.cue_fade.into(),
                        FixtureValueSource::new(SequenceId(self.id), &self.name),
                    );
                    state.set_fixture_value(fixture_id, control.control.clone(), value);
                }
            }
        }
        for port in &cue.ports {
            if let Some(value) = port.value() {
                ports_state.write_value(port.port_id, value);
            }
        }
        for preset in &cue.presets {
            for (fixture_id, control, value) in preset.values(cue, state, presets) {
                fixture_controller.write(
                    fixture_id,
                    control.clone(),
                    value,
                    self.priority,
                    cue.cue_fade.into(),
                    FixtureValueSource::new(SequenceId(self.id), &self.name),
                );
                state.set_fixture_value(fixture_id, control, value);
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
        let cue = Cue::new(id, format!("Cue {}", id), Default::default());

        self.cues.push(cue);

        id
    }

    /// Returns cue id
    pub fn insert_cue(&mut self, position: usize) -> u32 {
        let id = position as u32 + 1;
        let cue = Cue::new(id, format!("Cue {}", id), Default::default());

        for i in position..self.cues.len() {
            let c = &mut self.cues[i];
            if c.name == format!("Cue {}", c.id) {
                c.name = format!("Cue {}", c.id + 1);
            }
            c.id += 1;
        }

        self.cues.insert(position, cue);

        id
    }

    pub fn delete_cue(&mut self, cue_id: u32) -> anyhow::Result<Cue> {
        let index = self
            .cues
            .iter()
            .position(|cue| cue.id == cue_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown Cue {}", cue_id))?;

        let cue = self.cues.remove(index);

        Ok(cue)
    }

    pub fn add_port(&mut self, port_id: NodePortId) {
        self.ports.push(port_id);
    }

    pub fn remove_port(&mut self, port_id: NodePortId) -> anyhow::Result<()> {
        let index = self
            .ports
            .iter()
            .position(|port| *port == port_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown Port {}", port_id))?;

        self.ports.remove(index);
        self.cues.iter_mut().for_each(|cue| {
            cue.ports.retain(|port| port.port_id != port_id);
        });

        Ok(())
    }
}

impl PartialOrd for Sequence {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.id.partial_cmp(&other.id)
    }
}

impl Into<FadeTimings> for SequencerValue<SequencerTime> {
    fn into(self) -> FadeTimings {
        let fade_time = match self {
            SequencerValue::Direct(SequencerTime::Seconds(seconds)) => Some(Duration::from_secs_f64(seconds)),
            _ => None,
        };
        FadeTimings {
            fade_out: fade_time,
        }
    }
}
