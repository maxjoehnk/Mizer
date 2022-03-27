use crate::contracts::Clock;
use crate::state::{CueChannelState, SequenceState};
use crate::value::*;
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::FixtureId;
use mizer_util::LerpExt;
use serde::{Deserialize, Serialize};
use std::cmp::Ordering;
use std::collections::HashMap;
use std::time::{Duration, Instant};
use crate::Sequence;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Cue {
    pub id: u32,
    pub name: String,
    pub trigger: CueTrigger,
    /// Time for Follow and Time trigger modes
    /// CueTrigger::Follow => pause between cues
    /// CueTrigger::Time => time after previous cue was triggered until this cue is triggered
    pub trigger_time: Option<SequencerTime>,
    #[serde(default)]
    pub controls: Vec<CueControl>,
    #[serde(default)]
    pub effects: Vec<CueEffect>,
    #[serde(default)]
    pub cue_fade: Option<SequencerValue<SequencerTime>>,
    #[serde(default)]
    pub cue_delay: Option<SequencerValue<SequencerTime>>,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Hash)]
pub struct CueEffect {
    pub fixtures: Vec<FixtureId>,
    pub effect: u32,
}

impl Cue {
    pub(crate) fn new(id: u32, name: impl Into<String>, controls: Vec<CueControl>) -> Self {
        Self {
            id,
            name: name.into(),
            controls,
            effects: Vec::new(),
            trigger: Default::default(),
            trigger_time: Default::default(),
            cue_fade: None,
            cue_delay: None,
        }
    }

    pub fn merge(&mut self, controls: Vec<CueControl>) {
        for control in controls {
            if let Some(target) = self
                .controls
                .iter_mut()
                .find(|c| c.control == control.control && c.fixtures.overlaps(&control.fixtures))
            {
                target
                    .fixtures
                    .retain(|fixture_id| !control.fixtures.contains(fixture_id));
            }
            if let Some(target) = self.controls.iter_mut().find(|c| c.control == control.control && c.value == control.value) {
                for fixture in control.fixtures.iter() {
                    target.fixtures.push(*fixture);
                }
            }else {
                self.controls.push(control);
            }
        }
        self.controls.retain(|c| !c.fixtures.is_empty());
    }

    pub(crate) fn is_done(&self, state: &SequenceState, clock: &impl Clock) -> bool {
        let cue_active = state.get_timer(clock);
        self.duration() < cue_active
    }

    pub(crate) fn should_go(&self, state: &SequenceState, clock: &impl Clock) -> bool {
        let prev_cue_active = state.get_timer(clock);
        let prev_cue_finished = state
            .cue_finished_at
            .map(|finished| Instant::now().duration_since(finished));
        if self.trigger == CueTrigger::Time {
            if let Some(SequencerTime::Seconds(seconds)) = self.trigger_time {
                let delay = Duration::from_secs_f64(seconds);
                return delay > prev_cue_active;
            }
        }
        if self.trigger == CueTrigger::Follow && state.is_cue_finished() {
            return if let Some(SequencerTime::Seconds(seconds)) = self.trigger_time {
                if let Some(prev_cue_finished) = prev_cue_finished {
                    let delay = Duration::from_secs_f64(seconds);
                    delay > prev_cue_finished
                } else {
                    false
                }
            } else {
                true
            };
        }
        false
    }

    pub(crate) fn update_state(&self, sequence: &Sequence, state: &mut SequenceState, clock: &impl Clock) {
        if state.cue_finished_at.is_some() {
            return;
        }
        if self.is_done(state, clock) {
            state.cue_finished_at = Some(clock.now());
        }
        for channel in &self.controls {
            let delay_durations = self.delay_durations(sequence);
            for fixture in &sequence.fixtures {
                match state
                    .channel_state
                    .get(&(*fixture, channel.control.clone()))
                {
                    Some(CueChannelState::Delay) => {
                        if state.get_timer(clock) >= delay_durations[fixture] {
                            state.channel_state.insert(
                                (*fixture, channel.control.clone()),
                                CueChannelState::Fading,
                            );
                        }
                    }
                    _ => {}
                }
            }
        }
    }

    pub(crate) fn duration(&self) -> Duration {
        let fade_duration = self.fade_duration();
        let delay_duration = self.delay_duration();

        fade_duration + delay_duration
    }

    fn delay_duration(&self) -> Duration {
        if let Some(ref delay) = self.cue_delay {
            match delay.highest() {
                SequencerTime::Beats(_) => Duration::default(),
                SequencerTime::Seconds(seconds) => Duration::from_secs_f64(seconds),
            }
        } else {
            Duration::default()
        }
    }

    fn delay_durations(&self, sequence: &Sequence) -> HashMap<FixtureId, Duration> {
        match self.cue_delay {
            Some(SequencerValue::Direct(SequencerTime::Seconds(seconds))) => sequence
                .fixtures
                .iter()
                .map(|fixture_id| (*fixture_id, Duration::from_secs_f64(seconds)))
                .collect(),
            Some(SequencerValue::Range((
                                           SequencerTime::Seconds(from),
                                           SequencerTime::Seconds(to),
                                       ))) => {
                let mut map = HashMap::new();
                for (i, id) in sequence.fixtures.iter().enumerate() {
                    let delay: f64 = (i as f64)
                        .linear_extrapolate((0., (sequence.fixtures.len() as f64) - 1.), (from, to));
                    map.insert(*id, Duration::from_secs_f64(delay));
                }
                map
            }
            _ => sequence
                .fixtures
                .iter()
                .map(|fixture_id| (*fixture_id, Duration::default()))
                .collect(),
        }
    }

    fn fade_duration(&self) -> Duration {
        if let Some(ref fade) = self.cue_fade {
            match fade.highest() {
                SequencerTime::Beats(_) => Duration::default(),
                SequencerTime::Seconds(seconds) => Duration::from_secs_f64(seconds),
            }
        } else {
            Duration::default()
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
    /// Automatically triggers after given time after the previous cue started
    Time,
    Beats,
    Timecode,
}

impl Default for CueTrigger {
    fn default() -> Self {
        CueTrigger::Go
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct CueControl {
    pub control: FixtureFaderControl,
    pub value: SequencerValue<f64>,
    pub fixtures: Vec<FixtureId>,
}

impl CueControl {
    pub(crate) fn new(
        control: FixtureFaderControl,
        value: impl Into<SequencerValue<f64>>,
        fixtures: Vec<FixtureId>,
    ) -> Self {
        Self {
            control,
            value: value.into(),
            fixtures,
        }
    }

    pub(crate) fn values(
        &self,
        sequence: &Sequence,
        cue: &Cue,
        state: &SequenceState,
        clock: &impl Clock,
    ) -> Vec<(FixtureId, Option<f64>)> {
        let mut values = vec![None; self.fixtures.len()];

        self.fill_values(state, &mut values);
        self.delay_values(cue, state, &mut values, clock);
        self.fade_values(sequence, cue, state, &mut values, clock);

        self.fixtures.iter().copied().zip(values).collect()
    }

    pub(crate) fn fill_values(&self, _: &SequenceState, values: &mut Vec<Option<f64>>) {
        match self.value {
            SequencerValue::Direct(value) => {
                values.fill(Some(value));
            }
            SequencerValue::Range((from, to)) => {
                for i in 0..self.fixtures.len() {
                    let value: f64 = (i as f64)
                        .linear_extrapolate((0., (self.fixtures.len() as f64) - 1.0), (from, to));
                    values[i] = Some(value);
                }
            }
        }
    }

    pub(crate) fn delay_values(
        &self,
        cue: &Cue,
        state: &SequenceState,
        values: &mut Vec<Option<f64>>,
        clock: &impl Clock,
    ) {
        match cue.cue_delay {
            None => {}
            Some(SequencerValue::Direct(SequencerTime::Seconds(delay))) => {
                if state.get_timer(clock) < Duration::from_secs_f64(delay) {
                    values.fill(None);
                }
            }
            Some(SequencerValue::Range((
                                           SequencerTime::Seconds(from),
                                           SequencerTime::Seconds(to),
                                       ))) => {
                for i in 0..self.fixtures.len() {
                    let delay: f64 = (i as f64)
                        .linear_extrapolate((0., (self.fixtures.len() as f64) - 1.), (from, to));
                    if state.get_timer(clock) < Duration::from_secs_f64(delay) {
                        values[i] = None;
                    }
                }
            }
            _ => todo!(),
        }
    }

    pub(crate) fn fade_values(
        &self,
        sequence: &Sequence,
        cue: &Cue,
        state: &SequenceState,
        values: &mut Vec<Option<f64>>,
        clock: &impl Clock,
    ) {
        // TODO[maxjoehnk]: this should probably be solved in a better way
        let time = state.get_timer(clock);
        let delay_durations = cue.delay_durations(sequence);
        match cue.cue_fade {
            None => {}
            Some(SequencerValue::Direct(SequencerTime::Seconds(duration))) => {
                for i in 0..self.fixtures.len() {
                    if let Some(value) = &mut values[i] {
                        let previous_value = state
                            .get_fixture_value(self.fixtures[i], &self.control)
                            .unwrap_or_default();
                        let delay = delay_durations[&self.fixtures[i]];
                        if let Some(time) = time.checked_sub(delay).map(|time| time.as_secs_f64()) {
                            values[i] = Some(
                                time.min(duration)
                                    .linear_extrapolate((0., duration), (previous_value, *value)),
                            );
                        }
                    }
                }
            }
            Some(SequencerValue::Range((
                                           SequencerTime::Seconds(from),
                                           SequencerTime::Seconds(to),
                                       ))) => {
                for i in 0..self.fixtures.len() {
                    let duration: f64 = (i as f64)
                        .linear_extrapolate((0., (self.fixtures.len() as f64) - 1.), (from, to));
                    if let Some(value) = &mut values[i] {
                        let previous_value = state
                            .get_fixture_value(self.fixtures[i], &self.control)
                            .unwrap_or_default();
                        let delay = delay_durations[&self.fixtures[i]];
                        if let Some(time) = time.checked_sub(delay).map(|time| time.as_secs_f64()) {
                            values[i] = Some(
                                time.min(duration)
                                    .linear_extrapolate((0., duration), (previous_value, *value)),
                            );
                        }
                    }
                }
            }
            _ => todo!(),
        }
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

#[cfg(test)]
mod tests {
    use mockall::predicate::ne;
    use mizer_fixtures::definition::FixtureFaderControl;
    use mizer_fixtures::FixtureId;
    use crate::{Cue, CueControl, SequencerValue};

    #[test]
    fn merge_should_combine_different_controls() {
        let old_control = CueControl {
            fixtures: vec![FixtureId::Fixture(1)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        };
        let new_control = CueControl {
            fixtures: vec![FixtureId::Fixture(1)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Shutter,
        };
        let mut cue = Cue::new(1, "", vec![old_control.clone()]);
        let controls = vec![new_control.clone()];

        cue.merge(controls);

        assert_eq!(vec![old_control, new_control], cue.controls);
    }

    #[test]
    fn merge_should_combine_different_fixtures() {
        let expected = CueControl {
            fixtures: vec![FixtureId::Fixture(1), FixtureId::Fixture(2)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        };
        let mut cue = Cue::new(1, "", vec![CueControl {
            fixtures: vec![FixtureId::Fixture(1)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        }]);
        let controls = vec![CueControl {
            fixtures: vec![FixtureId::Fixture(2)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        }];

        cue.merge(controls);

        assert_eq!(vec![expected], cue.controls);
    }

    #[test]
    fn merge_should_merge_overlapping_controls() {
        let expected = vec![CueControl {
            fixtures: vec![FixtureId::Fixture(1)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        }, CueControl {
            fixtures: vec![FixtureId::Fixture(1)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Shutter,
        }];
        let mut cue = Cue::new(1, "", vec![CueControl {
            fixtures: vec![FixtureId::Fixture(1)],
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        }]);

        cue.merge(expected.clone());

        assert_eq!(expected, cue.controls);
    }
}
