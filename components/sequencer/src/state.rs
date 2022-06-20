use crate::contracts::Clock;
use crate::{Cue, CueEffect, EffectEngine, EffectInstanceId, Sequence};
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;
use std::collections::HashMap;
use std::time::{Duration, Instant};

#[derive(Debug, Default)]
pub(crate) struct SequenceState {
    pub active_cue_index: usize,
    pub active: bool,
    last_go: Option<SequenceTimestamp>,
    /// Timestamp when the currently active cue has finished
    pub cue_finished_at: Option<SequenceTimestamp>,
    pub fixture_values: HashMap<(FixtureId, FixtureFaderControl), f64>,
    pub channel_state: HashMap<(FixtureId, FixtureFaderControl), CueChannel>,
    pub running_effects: HashMap<CueEffect, EffectInstanceId>,
}

#[derive(Debug, Copy, Clone)]
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
pub struct CueChannel {
    pub start_time: SequenceTimestamp,
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
            let channel = CueChannel {
                state,
                start_time: SequenceTimestamp {
                    time: clock.now(),
                    beat: frame.frame,
                },
            };
            for fixture in &sequence.fixtures {
                self.channel_state
                    .insert((*fixture, control.control.clone()), channel);
            }
        }
    }

    pub fn get_timer(&self, clock: &impl Clock) -> Duration {
        clock.now().duration_since(
            self.last_go
                .map(|last_go| last_go.time)
                .unwrap_or_else(|| clock.now()),
        )
    }

    pub fn get_beats_passed(&self, frame: ClockFrame) -> f64 {
        let now = frame.frame;
        let last_go = self
            .last_go
            .map(|last_go| last_go.beat)
            .unwrap_or_else(|| frame.frame);

        now - last_go
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
    use crate::contracts::*;
    use crate::state::{SequenceDuration, SequenceTimestamp};
    use mizer_module::ClockFrame;
    use std::time::Instant;
    use test_case::test_case;

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
