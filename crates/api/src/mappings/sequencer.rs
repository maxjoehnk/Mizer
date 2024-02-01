use crate::proto::fixtures::FixtureId;
use crate::proto::sequencer::*;

impl From<mizer_sequencer::Sequence> for Sequence {
    fn from(sequence: mizer_sequencer::Sequence) -> Self {
        Self {
            id: sequence.id,
            name: sequence.name,
            cues: sequence.cues.into_iter().map(Cue::from).collect(),
            fixtures: sequence.fixtures.into_iter().map(FixtureId::from).collect(),
            wrap_around: sequence.wrap_around,
            stop_on_last_cue: sequence.stop_on_last_cue,
            priority: FixturePriority::from(sequence.priority) as i32,
        }
    }
}

impl From<mizer_sequencer::Cue> for Cue {
    fn from(cue: mizer_sequencer::Cue) -> Self {
        Self {
            id: cue.id,
            name: cue.name,
            trigger: Some(CueTrigger {
                r#type: cue_trigger::Type::from(cue.trigger) as i32,
                time: cue.trigger_time.map(|time| time.into()).into(),
                ..Default::default()
            }),
            controls: cue.controls.into_iter().map(CueControl::from).collect(),
            effects: cue.effects.into_iter().map(CueEffect::from).collect(),
            cue_timings: Some(CueTimings {
                fade: Some(CueTimer::from(cue.cue_fade)),
                delay: Some(CueTimer::from(cue.cue_delay)),
            }),
            dimmer_timings: None,
            position_timings: None,
            color_timings: None,
        }
    }
}

impl From<mizer_sequencer::CueTrigger> for cue_trigger::Type {
    fn from(trigger: mizer_sequencer::CueTrigger) -> Self {
        use mizer_sequencer::CueTrigger::*;

        match trigger {
            Go => Self::Go,
            Follow => Self::Follow,
            Time => Self::Time,
            Beats => Self::Beats,
            Timecode => Self::Timecode,
        }
    }
}

impl From<cue_trigger::Type> for mizer_sequencer::CueTrigger {
    fn from(trigger: cue_trigger::Type) -> Self {
        use cue_trigger::Type::*;

        match trigger {
            Go => Self::Go,
            Follow => Self::Follow,
            Time => Self::Time,
            Beats => Self::Beats,
            Timecode => Self::Timecode,
        }
    }
}

impl From<mizer_sequencer::CueControl> for CueControl {
    fn from(channel: mizer_sequencer::CueControl) -> Self {
        Self {
            r#type: cue_control::Type::from(channel.control) as i32,
            value: Some(channel.value.into()),
            fixtures: channel
                .fixtures
                .get_fixtures()
                .into_iter()
                .flatten()
                .map(FixtureId::from)
                .collect(),
        }
    }
}

impl From<mizer_sequencer::SequencerValue<f64>> for CueValue {
    fn from(value: mizer_sequencer::SequencerValue<f64>) -> Self {
        use mizer_sequencer::SequencerValue;
        match value {
            SequencerValue::Direct(value) => CueValue {
                value: Some(cue_value::Value::Direct(value)),
            },
            SequencerValue::Range((from, to)) => CueValue {
                value: Some(cue_value::Value::Range(CueValueRange { from, to })),
            },
        }
    }
}

impl From<CueValue> for mizer_sequencer::SequencerValue<f64> {
    fn from(value: CueValue) -> Self {
        use mizer_sequencer::SequencerValue;
        match value.value.unwrap() {
            cue_value::Value::Direct(value) => SequencerValue::Direct(value),
            cue_value::Value::Range(range) => SequencerValue::Range((range.from, range.to)),
        }
    }
}

impl From<Option<mizer_sequencer::SequencerValue<mizer_sequencer::SequencerTime>>> for CueTimer {
    fn from(
        value: Option<mizer_sequencer::SequencerValue<mizer_sequencer::SequencerTime>>,
    ) -> Self {
        use mizer_sequencer::{SequencerTime, SequencerValue};
        match value {
            None => CueTimer {
                has_timer: false,
                timer: None,
            },
            Some(SequencerValue::Direct(SequencerTime::Seconds(value))) => CueTimer {
                has_timer: true,
                timer: Some(cue_timer::Timer::Direct(CueTime {
                    time: Some(cue_time::Time::Seconds(value)),
                })),
            },
            Some(SequencerValue::Direct(SequencerTime::Beats(value))) => CueTimer {
                has_timer: true,
                timer: Some(cue_timer::Timer::Direct(CueTime {
                    time: Some(cue_time::Time::Beats(value)),
                })),
            },
            Some(SequencerValue::Range((
                SequencerTime::Seconds(from),
                SequencerTime::Seconds(to),
            ))) => CueTimer {
                has_timer: true,
                timer: Some(cue_timer::Timer::Range(CueTimerRange {
                    from: Some(CueTime {
                        time: Some(cue_time::Time::Seconds(from)),
                    }),
                    to: Some(CueTime {
                        time: Some(cue_time::Time::Seconds(to)),
                    }),
                })),
            },
            Some(SequencerValue::Range((SequencerTime::Beats(from), SequencerTime::Beats(to)))) => {
                CueTimer {
                    has_timer: true,
                    timer: Some(cue_timer::Timer::Range(CueTimerRange {
                        from: Some(CueTime {
                            time: Some(cue_time::Time::Beats(from)),
                        }),
                        to: Some(CueTime {
                            time: Some(cue_time::Time::Beats(to)),
                        }),
                    })),
                }
            }
            _ => unreachable!("invalid combination of beats and seconds in range"),
        }
    }
}

impl From<CueTimer> for Option<mizer_sequencer::SequencerValue<mizer_sequencer::SequencerTime>> {
    fn from(timer: CueTimer) -> Self {
        use mizer_sequencer::SequencerValue;
        match timer.timer {
            None => None,
            Some(cue_timer::Timer::Direct(time)) => Some(SequencerValue::Direct(time.into())),
            Some(cue_timer::Timer::Range(range)) => Some(SequencerValue::Range((
                range.from.unwrap().into(),
                range.to.unwrap().into(),
            ))),
        }
    }
}

impl From<CueTime> for mizer_sequencer::SequencerTime {
    fn from(time: CueTime) -> Self {
        match time.time.unwrap() {
            cue_time::Time::Seconds(seconds) => Self::Seconds(seconds),
            cue_time::Time::Beats(beats) => Self::Beats(beats),
        }
    }
}

impl From<mizer_sequencer::SequencerTime> for CueTime {
    fn from(time: mizer_sequencer::SequencerTime) -> Self {
        match time {
            mizer_sequencer::SequencerTime::Seconds(seconds) => Self {
                time: Some(cue_time::Time::Seconds(seconds)),
            },
            mizer_sequencer::SequencerTime::Beats(beats) => Self {
                time: Some(cue_time::Time::Beats(beats)),
            },
        }
    }
}

impl From<mizer_fixtures::definition::FixtureFaderControl> for cue_control::Type {
    fn from(fixture_control: mizer_fixtures::definition::FixtureFaderControl) -> Self {
        use mizer_fixtures::definition::ColorChannel;
        use mizer_fixtures::definition::FixtureFaderControl::*;

        match fixture_control {
            Intensity => Self::Intensity,
            Shutter => Self::Shutter,
            Focus => Self::Focus,
            Zoom => Self::Zoom,
            Iris => Self::Iris,
            Prism => Self::Prism,
            Frost => Self::Frost,
            Pan => Self::Pan,
            Tilt => Self::Tilt,
            Gobo => Self::Gobo,
            ColorMixer(ColorChannel::Red) => Self::ColorRed,
            ColorMixer(ColorChannel::Green) => Self::ColorGreen,
            ColorMixer(ColorChannel::Blue) => Self::ColorBlue,
            ColorWheel => Self::ColorWheel,
            Generic(_) => Self::Generic,
        }
    }
}

impl From<mizer_sequencer::CueEffect> for CueEffect {
    fn from(effect: mizer_sequencer::CueEffect) -> Self {
        use mizer_sequencer::SequencerTime;
        Self {
            effect_id: effect.effect,
            effect_offsets: effect.effect_offset.and_then(|time| {
                if let SequencerTime::Beats(value) = time {
                    Some(value)
                } else {
                    None
                }
            }),
            fixtures: effect
                .fixtures
                .get_fixtures()
                .into_iter()
                .flatten()
                .map(FixtureId::from)
                .collect(),
            effect_rate: None,
        }
    }
}

impl From<mizer_fixtures::FixturePriority> for FixturePriority {
    fn from(priority: mizer_fixtures::FixturePriority) -> Self {
        use mizer_fixtures::LTPPriority::*;

        match priority {
            mizer_fixtures::FixturePriority::HTP => Self::PriorityHtp,
            mizer_fixtures::FixturePriority::LTP(Highest) => Self::PriorityLtpHighest,
            mizer_fixtures::FixturePriority::LTP(High) => Self::PriorityLtpHigh,
            mizer_fixtures::FixturePriority::LTP(Normal) => Self::PriorityLtpNormal,
            mizer_fixtures::FixturePriority::LTP(Low) => Self::PriorityLtpLow,
            mizer_fixtures::FixturePriority::LTP(Lowest) => Self::PriorityLtpLowest,
        }
    }
}

impl From<FixturePriority> for mizer_fixtures::FixturePriority {
    fn from(priority: FixturePriority) -> Self {
        use mizer_fixtures::LTPPriority::*;

        match priority {
            FixturePriority::PriorityHtp => Self::HTP,
            FixturePriority::PriorityLtpHighest => Self::LTP(Highest),
            FixturePriority::PriorityLtpHigh => Self::LTP(High),
            FixturePriority::PriorityLtpNormal => Self::LTP(Normal),
            FixturePriority::PriorityLtpLow => Self::LTP(Low),
            FixturePriority::PriorityLtpLowest => Self::LTP(Lowest),
        }
    }
}
