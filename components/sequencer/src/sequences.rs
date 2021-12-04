use std::cmp::Ordering;

use serde::{Deserialize, Serialize};

use crate::state::SequenceState;
use mizer_fixtures::manager::FixtureManager;
use mizer_util::LerpExt;
use std::time::Duration;
use mizer_fixtures::definition::FixtureControl;
use mizer_fixtures::FixtureId;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Sequence {
    pub id: u32,
    pub name: String,
    pub cues: Vec<Cue>,
}

impl Sequence {
    pub(crate) fn run(&self, state: &mut SequenceState, fixture_manager: &FixtureManager) {
        if !state.active {
            return;
        }
        // TODO: the sequence state should ensure active_cue_index is always in the proper range
        let cue = &self.cues[state.active_cue_index as usize];
        for channel in &cue.channels {
            for (fixture_id, value) in channel.values(&state) {
                if let Some(value) = value {
                    fixture_manager.write_fixture_control(fixture_id, channel.control.clone(), value);
                }
            }
        }
    }

    /// Returns cue id
    pub fn add_cue(&mut self) -> u32 {
        let id = self.cues.len() as u32 + 1;
        let cue = Cue {
            id,
            name: format!("Cue {}", id),
            channels: Vec::new(),
            trigger: CueTrigger::Go,
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

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Cue {
    pub id: u32,
    pub name: String,
    pub trigger: CueTrigger,
    pub channels: Vec<CueChannel>,
}

impl Cue {
    pub fn merge(&mut self, channels: Vec<CueChannel>) {
        for channel in channels {
            if let Some(target) = self.channels.iter_mut().find(|c| c.control == channel.control && c.fixtures.overlaps(&channel.fixtures)) {
                target.fixtures.retain(|fixture_id| !channel.fixtures.contains(fixture_id));
            }
            self.channels.push(channel);
        }
        self.channels.retain(|c| !c.fixtures.is_empty());
    }
}

impl PartialOrd for Cue {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.id.partial_cmp(&other.id)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub enum CueTrigger {
    Go,
    Follow,
    Beats,
    Timecode,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct CueChannel {
    pub fixtures: Vec<FixtureId>,
    pub control: FixtureControl,
    pub value: SequencerValue<f64>,
    #[serde(default)]
    pub fade: Option<SequencerValue<SequencerTime>>,
    #[serde(default)]
    pub delay: Option<SequencerValue<SequencerTime>>,
}

impl CueChannel {
    fn values(&self, state: &SequenceState) -> Vec<(FixtureId, Option<f64>)> {
        let mut values = vec![None; self.fixtures.len()];

        self.fill_values(state, &mut values);
        self.delay_values(state, &mut values);
        self.fade_values(state, &mut values);

        self.fixtures.iter()
            .copied()
            .zip(values)
            .collect()
    }

    fn fill_values(&self, _: &SequenceState, values: &mut Vec<Option<f64>>) {
        match self.value {
            SequencerValue::Direct(value) => {
                values.fill(Some(value));
            }
            SequencerValue::Range((from, to)) => {
                for i in 0..self.fixtures.len() {
                    let value: f64 = (i as f64).lerp((0., self.fixtures.len() as f64), (from, to));
                    values[i] = Some(value);
                }
            }
        }
    }

    fn delay_values(&self, state: &SequenceState, values: &mut Vec<Option<f64>>) {
        match self.delay {
            None => {},
            Some(SequencerValue::Direct(SequencerTime::Seconds(delay))) => {
                if state.get_timer() < Duration::from_secs_f64(delay) {
                    values.fill(None);
                }
            },
            Some(SequencerValue::Range((SequencerTime::Seconds(from), SequencerTime::Seconds(to)))) => {
                for i in 0..self.fixtures.len() {
                    let delay: f64 = (i as f64).lerp((0., self.fixtures.len() as f64), (from, to));
                    if state.get_timer() < Duration::from_secs_f64(delay) {
                        values[i] = None;
                    }
                }
            },
            _ => todo!()
        }
    }

    fn fade_values(&self, state: &SequenceState, values: &mut Vec<Option<f64>>) {
        match self.fade {
            None => {},
            Some(SequencerValue::Direct(SequencerTime::Seconds(duration))) => {
                let time = state.get_timer().as_secs_f64();
                for i in 0..self.fixtures.len() {
                    if let Some(value) = &mut values[i] {
                        let previous_value = state.get_fixture_value(self.fixtures[i], &self.control).unwrap_or_default();
                        values[i] = Some(time.lerp((0., duration), (previous_value, *value)));
                    }
                }
            }
            Some(SequencerValue::Range((SequencerTime::Seconds(from), SequencerTime::Seconds(to)))) => {
                let time = state.get_timer().as_secs_f64();
                for i in 0..self.fixtures.len() {
                    let duration: f64 = (i as f64).lerp((0., self.fixtures.len() as f64), (from, to));
                    if let Some(value) = &mut values[i] {
                        let previous_value = state.get_fixture_value(self.fixtures[i], &self.control).unwrap_or_default();
                        values[i] = Some(time.lerp((0., duration), (previous_value, *value)));
                    }
                }
            },
            _ => todo!()
        }
    }
}


#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
#[serde(untagged)]
pub enum SequencerValue<T> {
    Direct(T),
    Range((T, T)),
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
#[serde(tag = "unit", content = "value")]
pub enum SequencerTime {
    #[serde(rename = "seconds")]
    Seconds(f64),
    #[serde(rename = "beats")]
    Beats(f64),
}

impl Default for SequencerValue<SequencerTime> {
    fn default() -> Self {
        Self::Direct(SequencerTime::Seconds(0.))
    }
}

trait VecExtension {
    fn overlaps(&self, other: &Self) -> bool;
}

impl<T: PartialEq> VecExtension for Vec<T> {
    fn overlaps(&self, other: &Self) -> bool {
        for item in other.iter() {
            if self.contains(item) {
                return true;
            }
        }
        false
    }
}
