use std::collections::HashMap;
use std::time::{Duration, Instant};

use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;

use crate::contracts::Clock;
use crate::{Cue, CueEffect, EffectEngine, EffectInstanceId, Sequence};

#[derive(Debug)]
pub(crate) struct SequenceState {
    pub active_cue_index: usize,
    pub active: bool,
    /// Playback rate
    /// 0 is equal to pause
    /// 1 is normal playback
    /// 2 doubles the speed
    pub rate: f64,
    last_go: Option<SequenceTimestamp>,
    /// Timestamp when the currently active cue has finished
    pub cue_finished_at: Option<SequenceTimestamp>,
    pub fixture_values: HashMap<(FixtureId, FixtureFaderControl), f64>,
    pub channel_state: HashMap<(FixtureId, FixtureFaderControl), CueChannel>,
    pub running_effects: HashMap<CueEffect, EffectInstanceId>,
    duration_since_last_go: Option<SequenceRateMatchedDuration>,
    duration_since_finished_at: Option<SequenceRateMatchedDuration>,
}

#[derive(Debug, Copy, Clone)]
pub(crate) struct SequenceRateMatchedDuration {
    start: SequenceTimestamp,
    last_tick: Instant,
    pub time: Duration,
    pub beat: f64,
}

impl SequenceRateMatchedDuration {
    pub fn new(start: SequenceTimestamp) -> Self {
        Self {
            start,
            last_tick: start.time,
            time: Default::default(),
            beat: Default::default(),
        }
    }

    pub fn forward(&mut self, clock: &impl Clock, frame: ClockFrame, rate: f64) {
        self.beat += frame.delta * rate;
        let tick = clock.now();
        let duration = tick.duration_since(self.last_tick);
        let rate_adjusted = duration.mul_f64(rate);
        self.time += rate_adjusted;
        self.last_tick = tick;
    }

    pub fn has_passed(&self, duration: SequenceDuration) -> bool {
        match duration {
            SequenceDuration::Beats(beats) => beats <= self.beat,
            SequenceDuration::Seconds(duration) => duration <= self.time,
        }
    }
}

impl SequenceState {
    pub(crate) fn update_timestamps_based_on_rate(
        &mut self,
        clock: &impl Clock,
        frame: ClockFrame,
    ) {
        if let Some(last_go) = self.last_go {
            let mut duration = self
                .duration_since_last_go
                .unwrap_or_else(|| SequenceRateMatchedDuration::new(last_go));
            if duration.start != last_go {
                duration = SequenceRateMatchedDuration::new(last_go);
            }
            duration.forward(clock, frame, self.rate);
            self.duration_since_last_go = Some(duration);
        }
        if let Some(cue_finished_at) = self.cue_finished_at {
            let mut duration = self
                .duration_since_finished_at
                .unwrap_or_else(|| SequenceRateMatchedDuration::new(cue_finished_at));
            if duration.start != cue_finished_at {
                duration = SequenceRateMatchedDuration::new(cue_finished_at);
            }
            duration.forward(clock, frame, self.rate);
            self.duration_since_finished_at = Some(duration);
        }
    }
}

impl Default for SequenceState {
    fn default() -> Self {
        Self {
            active_cue_index: Default::default(),
            active: Default::default(),
            rate: 1.,
            last_go: Default::default(),
            cue_finished_at: Default::default(),
            fixture_values: Default::default(),
            channel_state: Default::default(),
            running_effects: Default::default(),
            duration_since_finished_at: Default::default(),
            duration_since_last_go: Default::default(),
        }
    }
}

#[derive(Debug, Copy, Clone, PartialEq)]
pub struct SequenceTimestamp {
    pub time: Instant,
    pub beat: f64,
}

impl SequenceTimestamp {
    pub(crate) fn has_passed(
        &self,
        clock: &impl Clock,
        frame: ClockFrame,
        duration: SequenceDuration,
    ) -> bool {
        match duration {
            SequenceDuration::Beats(beats) => self.beat + beats <= frame.frame,
            SequenceDuration::Seconds(duration) => {
                clock.now().duration_since(self.time) >= duration
            }
        }
    }
}

#[derive(Debug, Copy, Clone, PartialEq)]
pub enum SequenceDuration {
    Seconds(Duration),
    Beats(f64),
}

impl Default for SequenceDuration {
    fn default() -> Self {
        Self::Seconds(Duration::default())
    }
}

#[derive(Debug, Copy, Clone)]
pub(crate) struct CueChannel {
    pub start_time: SequenceTimestamp,
    pub duration: SequenceRateMatchedDuration,
    pub state: CueChannelState,
}

#[derive(Copy, Clone, Debug, PartialEq, Eq)]
pub enum CueChannelState {
    Delay,
    Fading,
    Active,
}

impl SequenceState {
    pub(crate) fn is_cue_finished(&self) -> bool {
        self.cue_finished_at.is_some()
    }

    pub fn go(
        &mut self,
        sequence: &Sequence,
        clock: &impl Clock,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        self.last_go = Some(SequenceTimestamp {
            time: clock.now(),
            beat: frame.frame,
        });
        self.cue_finished_at = None;
        self.stop_effects(effect_engine);
        if !self.active {
            self.active = true;
            self.active_cue_index = 0;
        } else {
            self.next_cue(sequence, effect_engine, clock, frame);
        }
        self.update_channel_states(sequence, clock, frame);
    }
    
    pub fn go_backward(
        &mut self,
        sequence: &Sequence,
        clock: &impl Clock,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        self.last_go = Some(SequenceTimestamp {
            time: clock.now(),
            beat: frame.frame,
        });
        self.cue_finished_at = None;
        self.stop_effects(effect_engine);
        if !self.active {
            self.active = true;
            self.active_cue_index = sequence.cues.len().saturating_sub(1);
        } else {
            self.prev_cue(sequence, effect_engine, clock, frame);
        }
        self.update_channel_states(sequence, clock, frame);
    }

    pub fn go_to(
        &mut self,
        sequence: &Sequence,
        cue_id: u32,
        clock: &impl Clock,
        effect_engine: &EffectEngine,
        frame: ClockFrame,
    ) {
        if let Some(cue_index) = sequence.cues.iter().position(|cue| cue.id == cue_id) {
            self.last_go = Some(SequenceTimestamp {
                time: clock.now(),
                beat: frame.frame,
            });
            self.cue_finished_at = None;
            self.stop_effects(effect_engine);
            self.active = true;
            self.active_cue_index = cue_index;
            self.update_channel_states(sequence, clock, frame);
        }
    }

    pub fn stop(
        &mut self,
        sequence: &Sequence,
        effect_engine: &EffectEngine,
        clock: &impl Clock,
        frame: ClockFrame,
    ) {
        self.active = false;
        self.active_cue_index = 0;
        self.fixture_values.clear();
        self.update_channel_states(sequence, clock, frame);
        self.stop_effects(effect_engine);
    }

    fn next_cue(
        &mut self,
        sequence: &Sequence,
        effect_engine: &EffectEngine,
        clock: &impl Clock,
        frame: ClockFrame,
    ) {
        self.active_cue_index += 1;
        if self.active_cue_index >= sequence.cues.len() {
            if sequence.wrap_around {
                self.active_cue_index = 0;
                return;
            }
            self.active_cue_index = 0;
            self.active = false;
            self.stop(sequence, effect_engine, clock, frame);
        }
    }

    fn prev_cue(
        &mut self,
        sequence: &Sequence,
        effect_engine: &EffectEngine,
        clock: &impl Clock,
        frame: ClockFrame,
    ) {
        if self.active_cue_index == 0 {
            if sequence.wrap_around {
                self.active_cue_index = sequence.cues.len().saturating_sub(1);
                return;
            }
            self.active_cue_index = 0;
            self.active = false;
            self.stop(sequence, effect_engine, clock, frame);
        }else {
            self.active_cue_index = self.active_cue_index.saturating_sub(1);
        }
    }

    fn update_channel_states(
        &mut self,
        sequence: &Sequence,
        clock: &impl Clock,
        frame: ClockFrame,
    ) {
        self.channel_state.clear();
        let cue = &sequence.cues[self.active_cue_index];
        for control in &cue.controls {
            let state = cue.initial_channel_state();
            let start_time = SequenceTimestamp {
                time: clock.now(),
                beat: frame.frame,
            };
            let channel = CueChannel {
                state,
                start_time,
                duration: SequenceRateMatchedDuration::new(start_time),
            };
            for fixture in sequence.fixtures.iter() {
                self.channel_state
                    .insert((*fixture, control.control.clone()), channel);
            }
        }
    }

    pub fn get_timer(&self) -> Duration {
        self.duration_since_last_go
            .map(|d| d.time)
            .unwrap_or_default()
    }

    pub fn get_beats_passed(&self) -> f64 {
        self.duration_since_last_go
            .map(|d| d.beat)
            .unwrap_or_default()
    }

    pub fn get_timer_since_finished(&self) -> Duration {
        self.duration_since_finished_at
            .map(|d| d.time)
            .unwrap_or_default()
    }

    pub fn get_beats_passed_since_finished(&self) -> f64 {
        self.duration_since_finished_at
            .map(|d| d.beat)
            .unwrap_or_default()
    }

    pub fn get_fixture_value(
        &self,
        fixture_id: FixtureId,
        control: &FixtureFaderControl,
    ) -> Option<f64> {
        self.fixture_values
            .get(&(fixture_id, control.clone()))
            .copied()
    }

    pub fn set_fixture_value(
        &mut self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
    ) {
        self.fixture_values.insert((fixture_id, control), value);
    }

    pub fn get_next_cue<'a>(&self, sequence: &'a Sequence) -> Option<&'a Cue> {
        let next_cue_index = self.active_cue_index + 1;
        if next_cue_index >= sequence.cues.len() {
            if sequence.wrap_around {
                Some(&sequence.cues[0])
            } else {
                None
            }
        } else {
            Some(&sequence.cues[next_cue_index])
        }
    }

    fn stop_effects(&mut self, effect_engine: &EffectEngine) {
        for id in self.running_effects.values() {
            effect_engine.stop_effect(id);
        }
        self.running_effects.clear();
    }
}

impl Cue {
    fn initial_channel_state(&self) -> CueChannelState {
        if self.cue_delay.is_some() {
            CueChannelState::Delay
        } else if self.cue_fade.is_some() {
            CueChannelState::Fading
        } else {
            CueChannelState::Active
        }
    }
}

#[cfg(test)]
mod tests {
    use std::time::Instant;

    use test_case::test_case;

    use mizer_module::ClockFrame;

    use crate::contracts::*;
    use crate::state::{SequenceDuration, SequenceTimestamp};

    #[test_case(0., 0., 1.)]
    #[test_case(0.5, 1., 2.)]
    fn sequence_timestamp_has_passed_should_return_false_when_beats_have_not_passed(
        start_beat: f64,
        current_beat: f64,
        duration: f64,
    ) {
        let clock = MockClock::new();
        let timestamp = SequenceTimestamp {
            beat: start_beat,
            time: Instant::now(),
        };
        let frame = ClockFrame {
            frame: current_beat,
            ..Default::default()
        };
        let duration = SequenceDuration::Beats(duration);

        let result = timestamp.has_passed(&clock, frame, duration);

        assert!(!result);
    }

    #[test_case(0., 1., 1.)]
    #[test_case(0., 3., 2.)]
    #[test_case(0.5, 2.5, 2.)]
    fn sequence_timestamp_has_passed_should_return_true_when_beats_have_passed(
        start_beat: f64,
        current_beat: f64,
        duration: f64,
    ) {
        let clock = MockClock::new();
        let timestamp = SequenceTimestamp {
            beat: start_beat,
            time: Instant::now(),
        };
        let frame = ClockFrame {
            frame: current_beat,
            ..Default::default()
        };
        let duration = SequenceDuration::Beats(duration);

        let result = timestamp.has_passed(&clock, frame, duration);

        assert!(result);
    }
}
