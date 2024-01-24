use crate::contracts::Clock;
use crate::state::{
    CueChannel, CueChannelState, SequenceDuration, SequenceRateMatchedDuration, SequenceState,
    SequenceTimestamp,
};
use crate::value::*;
use crate::Sequence;
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::selection::{BackwardsCompatibleFixtureSelection, FixtureSelection};
use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;
use mizer_util::LerpExt;
use serde::{Deserialize, Serialize};
use std::cmp::Ordering;
use std::collections::HashMap;
use std::time::Duration;

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
    pub fixtures: BackwardsCompatibleFixtureSelection,
    pub effect: u32,
    #[serde(default)]
    pub effect_offset: Option<SequencerTime>,
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
            if let Some(target) = self
                .controls
                .iter_mut()
                .find(|c| c.control == control.control && c.value == control.value)
            {
                for fixture in control.fixtures.get_fixtures().iter().flatten() {
                    target.fixtures.add_fixture(*fixture);
                }
            } else {
                self.controls.push(control);
            }
        }
        self.controls.retain(|c| !c.fixtures.is_empty());
    }

    pub(crate) fn is_done(&self, state: &SequenceState) -> bool {
        state
            .channel_state
            .iter()
            .all(|(_, cue_channel)| cue_channel.state == CueChannelState::Active)
    }

    pub(crate) fn should_go(&self, state: &SequenceState) -> bool {
        if self.trigger == CueTrigger::Time {
            match self.trigger_time {
                Some(SequencerTime::Seconds(seconds)) => {
                    let passed = state.get_timer();
                    let delay = Duration::from_secs_f64(seconds);

                    passed >= delay
                }
                Some(SequencerTime::Beats(beats)) => {
                    let passed = state.get_beats_passed();

                    passed >= beats
                }
                None => true,
            }
        } else if self.trigger == CueTrigger::Follow && state.is_cue_finished() {
            match self.trigger_time {
                Some(SequencerTime::Seconds(seconds)) => {
                    let passed = state.get_timer_since_finished();
                    let delay = Duration::from_secs_f64(seconds);

                    passed >= delay
                }
                Some(SequencerTime::Beats(beats)) => {
                    let passed = state.get_beats_passed_since_finished();

                    passed >= beats
                }
                None => true,
            }
        } else {
            false
        }
    }

    pub(crate) fn update_state(
        &self,
        sequence: &Sequence,
        sequence_state: &mut SequenceState,
        clock: &impl Clock,
        frame: ClockFrame,
    ) {
        profiling::scope!("Cue::update_state");
        if sequence_state.cue_finished_at.is_some() {
            return;
        }
        if self.is_done(sequence_state) {
            sequence_state.cue_finished_at = Some(SequenceTimestamp {
                time: clock.now(),
                beat: frame.frame,
            });
        }
        for channel in &self.controls {
            let delay_durations = self.delay_durations(sequence);
            let fade_durations = self.fade_durations(sequence);
            for fixture in sequence.fixtures.iter() {
                match sequence_state
                    .channel_state
                    .get_mut(&(*fixture, channel.control.clone()))
                {
                    Some(CueChannel {
                        state: cue_state,
                        start_time: _,
                        duration,
                    }) if *cue_state == CueChannelState::Delay => {
                        duration.forward(clock, frame, sequence_state.rate);
                        if duration.has_passed(delay_durations[fixture]) {
                            let now = SequenceTimestamp {
                                time: clock.now(),
                                beat: frame.frame,
                            };
                            sequence_state.channel_state.insert(
                                (*fixture, channel.control.clone()),
                                CueChannel {
                                    state: CueChannelState::Fading,
                                    start_time: now,
                                    duration: SequenceRateMatchedDuration::new(now),
                                },
                            );
                        }
                    }
                    Some(CueChannel {
                        state: cue_state,
                        start_time: _,
                        duration,
                    }) if *cue_state == CueChannelState::Fading => {
                        duration.forward(clock, frame, sequence_state.rate);
                        if duration.has_passed(fade_durations[fixture]) {
                            let now = SequenceTimestamp {
                                time: clock.now(),
                                beat: frame.frame,
                            };
                            sequence_state.channel_state.insert(
                                (*fixture, channel.control.clone()),
                                CueChannel {
                                    state: CueChannelState::Active,
                                    start_time: now,
                                    duration: SequenceRateMatchedDuration::new(now),
                                },
                            );
                        }
                    }
                    _ => {}
                }
            }
        }
    }

    fn delay_durations(&self, sequence: &Sequence) -> HashMap<FixtureId, SequenceDuration> {
        Self::durations(self.cue_delay, sequence)
    }

    fn fade_durations(&self, sequence: &Sequence) -> HashMap<FixtureId, SequenceDuration> {
        Self::durations(self.cue_fade, sequence)
    }

    fn durations(
        durations: Option<SequencerValue<SequencerTime>>,
        sequence: &Sequence,
    ) -> HashMap<FixtureId, SequenceDuration> {
        match durations {
            Some(SequencerValue::Direct(SequencerTime::Seconds(seconds))) => sequence
                .fixtures
                .iter()
                .map(|fixture_id| {
                    (
                        *fixture_id,
                        SequenceDuration::Seconds(Duration::from_secs_f64(seconds)),
                    )
                })
                .collect(),
            Some(SequencerValue::Range((
                SequencerTime::Seconds(from),
                SequencerTime::Seconds(to),
            ))) => {
                let mut map = HashMap::new();
                for (i, id) in sequence.fixtures.iter().enumerate() {
                    let delay: f64 = (i as f64).linear_extrapolate(
                        (0., (sequence.fixtures.len() as f64) - 1.),
                        (from, to),
                    );
                    map.insert(
                        *id,
                        SequenceDuration::Seconds(Duration::from_secs_f64(delay)),
                    );
                }
                map
            }
            Some(SequencerValue::Direct(SequencerTime::Beats(beats))) => sequence
                .fixtures
                .iter()
                .map(|fixture_id| (*fixture_id, SequenceDuration::Beats(beats)))
                .collect(),
            Some(SequencerValue::Range((SequencerTime::Beats(from), SequencerTime::Beats(to)))) => {
                let mut map = HashMap::new();
                for (i, id) in sequence.fixtures.iter().enumerate() {
                    let beats: f64 = (i as f64).linear_extrapolate(
                        (0., (sequence.fixtures.len() as f64) - 1.),
                        (from, to),
                    );
                    map.insert(*id, SequenceDuration::Beats(beats));
                }
                map
            }
            _ => sequence
                .fixtures
                .iter()
                .map(|fixture_id| (*fixture_id, Default::default()))
                .collect(),
        }
    }
}

impl PartialOrd for Cue {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.id.partial_cmp(&other.id)
    }
}

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash)]
pub enum CueTrigger {
    /// Requires manual go action to trigger
    #[default]
    Go,
    /// Automatically triggers when the previous cue finishes
    Follow,
    /// Automatically triggers after given time after the previous cue started
    Time,
    Beats,
    Timecode,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct CueControl {
    pub control: FixtureFaderControl,
    pub value: SequencerValue<f64>,
    pub fixtures: BackwardsCompatibleFixtureSelection,
}

impl CueControl {
    pub(crate) fn new(
        control: FixtureFaderControl,
        value: impl Into<SequencerValue<f64>>,
        fixtures: FixtureSelection,
    ) -> Self {
        Self {
            control,
            value: value.into(),
            fixtures: fixtures.into(),
        }
    }

    pub(crate) fn values(&self, cue: &Cue, state: &SequenceState) -> Vec<(FixtureId, Option<f64>)> {
        profiling::scope!("CueControl::values");
        let mut values = HashMap::new();
        for fixture in self.fixtures.get_fixtures().iter().flatten() {
            values.insert(*fixture, None);
        }

        self.fill_values(state, &mut values);
        self.delay_values(cue, state, &mut values);
        self.fade_values(cue, state, &mut values);

        values.into_iter().collect()
    }

    fn interpolate<F: FnMut(FixtureId, f64)>(&self, range: (f64, f64), mut callback: F) {
        let fixtures = self.fixtures.get_fixtures();
        let fixture_count = fixtures.len();
        for (i, fixtures) in fixtures.into_iter().enumerate() {
            let value: f64 =
                (i as f64).linear_extrapolate((0., (fixture_count as f64) - 1.), range);
            for fixture in fixtures {
                callback(fixture, value);
            }
        }
    }

    pub(crate) fn fill_values(
        &self,
        _: &SequenceState,
        values: &mut HashMap<FixtureId, Option<f64>>,
    ) {
        match self.value {
            SequencerValue::Direct(value) => {
                for (_, v) in values.iter_mut() {
                    *v = Some(value);
                }
            }
            SequencerValue::Range(range) => {
                self.interpolate(range, |id, value| {
                    values.insert(id, Some(value));
                });
            }
        }
    }

    pub(crate) fn delay_values(
        &self,
        cue: &Cue,
        state: &SequenceState,
        values: &mut HashMap<FixtureId, Option<f64>>,
    ) {
        match cue.cue_delay {
            None => {}
            Some(SequencerValue::Direct(SequencerTime::Seconds(delay))) => {
                if state.get_timer() < Duration::from_secs_f64(delay) {
                    for (_, v) in values.iter_mut() {
                        *v = None;
                    }
                }
            }
            Some(SequencerValue::Range((
                SequencerTime::Seconds(from),
                SequencerTime::Seconds(to),
            ))) => {
                self.interpolate((from, to), |id, delay| {
                    if state.get_timer() < Duration::from_secs_f64(delay) {
                        values.insert(id, None);
                    }
                });
            }
            Some(SequencerValue::Direct(SequencerTime::Beats(delay))) => {
                if state.get_beats_passed() < delay {
                    for (_, v) in values.iter_mut() {
                        *v = None;
                    }
                }
            }
            Some(SequencerValue::Range((SequencerTime::Beats(from), SequencerTime::Beats(to)))) => {
                self.interpolate((from, to), |id, delay| {
                    if state.get_beats_passed() < delay {
                        values.insert(id, None);
                    }
                });
            }
            _ => unreachable!("Invalid combo of beats and seconds"),
        }
    }

    pub(crate) fn fade_values(
        &self,
        cue: &Cue,
        sequence_state: &SequenceState,
        values: &mut HashMap<FixtureId, Option<f64>>,
    ) {
        for fixture_id in self.fixtures.get_fixtures().iter().flatten().copied() {
            let Some(cue_state) = sequence_state
                .channel_state
                .get(&(fixture_id, self.control.clone()))
            else {
                continue;
            };
            if cue_state.state != CueChannelState::Fading {
                continue;
            }
            let Some(Some(value)) = values.get(&fixture_id).copied() else {
                continue;
            };
            let previous_value = sequence_state
                .get_fixture_value(fixture_id, &self.control)
                .unwrap_or_default();

            match cue.cue_fade {
                None => {}
                Some(SequencerValue::Direct(SequencerTime::Seconds(duration))) => {
                    let time = cue_state.duration.time.as_secs_f64();

                    values.insert(
                        fixture_id,
                        Some(time.linear_extrapolate((0., duration), (previous_value, value))),
                    );
                }
                Some(SequencerValue::Range((
                    SequencerTime::Seconds(from),
                    SequencerTime::Seconds(to),
                ))) => {
                    self.interpolate((from, to), |id, duration| {
                        if id != fixture_id {
                            return;
                        }
                        let time = cue_state.duration.time.as_secs_f64();

                        values.insert(
                            id,
                            Some(time.linear_extrapolate((0., duration), (previous_value, value))),
                        );
                    });
                }
                Some(SequencerValue::Direct(SequencerTime::Beats(beats))) => {
                    let time = cue_state.duration.beat;

                    values.insert(
                        fixture_id,
                        Some(time.linear_extrapolate((0., beats), (previous_value, value))),
                    );
                }
                Some(SequencerValue::Range((
                    SequencerTime::Beats(from),
                    SequencerTime::Beats(to),
                ))) => {
                    self.interpolate((from, to), |id, beats| {
                        if id != fixture_id {
                            return;
                        }
                        let time = cue_state.duration.beat;

                        values.insert(
                            id,
                            Some(time.linear_extrapolate((0., beats), (previous_value, value))),
                        );
                    });
                }
                _ => unreachable!("Invalid combo of beats and seconds"),
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::{Cue, CueControl, SequencerValue};
    use mizer_fixtures::definition::FixtureFaderControl;
    use mizer_fixtures::FixtureId;

    #[test]
    fn merge_should_combine_different_controls() {
        let old_control = CueControl {
            fixtures: vec![FixtureId::Fixture(1)].into(),
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        };
        let new_control = CueControl {
            fixtures: vec![FixtureId::Fixture(1)].into(),
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
            fixtures: vec![FixtureId::Fixture(1), FixtureId::Fixture(2)].into(),
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        };
        let mut cue = Cue::new(
            1,
            "",
            vec![CueControl {
                fixtures: vec![FixtureId::Fixture(1)].into(),
                value: SequencerValue::Direct(1.),
                control: FixtureFaderControl::Intensity,
            }],
        );
        let controls = vec![CueControl {
            fixtures: vec![FixtureId::Fixture(2)].into(),
            value: SequencerValue::Direct(1.),
            control: FixtureFaderControl::Intensity,
        }];

        cue.merge(controls);

        assert_eq!(vec![expected], cue.controls);
    }

    #[test]
    fn merge_should_merge_overlapping_controls() {
        let expected = vec![
            CueControl {
                fixtures: vec![FixtureId::Fixture(1)].into(),
                value: SequencerValue::Direct(1.),
                control: FixtureFaderControl::Intensity,
            },
            CueControl {
                fixtures: vec![FixtureId::Fixture(1)].into(),
                value: SequencerValue::Direct(1.),
                control: FixtureFaderControl::Shutter,
            },
        ];
        let mut cue = Cue::new(
            1,
            "",
            vec![CueControl {
                fixtures: vec![FixtureId::Fixture(1)].into(),
                value: SequencerValue::Direct(1.),
                control: FixtureFaderControl::Intensity,
            }],
        );

        cue.merge(expected.clone());

        assert_eq!(expected, cue.controls);
    }
}
