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
        if let Some(next_cue) = state.get_next_cue(&self) {
            if next_cue.trigger == CueTrigger::Follow && cue.is_done(&state) {
                state.go(&self);
            }
        }
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

    fn is_done(&self, state: &SequenceState) -> bool {
        let cue_active = state.get_timer();
        if let Some(longest_cue_duration) = self.channels.iter()
            .map(|channel| channel.duration())
            .max() {
            longest_cue_duration < cue_active
        }else {
            true
        }
    }
}

impl PartialOrd for Cue {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.id.partial_cmp(&other.id)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub enum CueTrigger {
    /// Requires manual go action to trigger
    Go,
    /// Automatically triggers when the previous cue finishes
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
    fn duration(&self) -> Duration {
        let fade_duration = if let Some(ref fade) = self.fade {
            match fade.highest() {
                SequencerTime::Beats(_) => Duration::default(),
                SequencerTime::Seconds(seconds) => Duration::from_secs_f64(seconds),
            }
        }else { Duration::default() };
        let delay_duration = if let Some(ref delay) = self.delay {
            match delay.highest() {
                SequencerTime::Beats(_) => Duration::default(),
                SequencerTime::Seconds(seconds) => Duration::from_secs_f64(seconds),
            }
        }else { Duration::default() };

        fade_duration + delay_duration
    }

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


#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
#[serde(untagged)]
pub enum SequencerValue<T> {
    Direct(T),
    Range((T, T)),
}

impl<T: PartialOrd + Copy> SequencerValue<T> {
    fn highest(&self) -> T {
        match self {
            Self::Direct(value) => *value,
            Self::Range((lhs, rhs)) => {
                if lhs > rhs {
                    *lhs
                }else {
                    *rhs
                }
            }
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, PartialOrd)]
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
