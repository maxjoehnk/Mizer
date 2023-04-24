use protobuf::{EnumOrUnknown, MessageField};

use mizer_sequencer::{SequencerTime, SequencerValue};

use crate::models::fixtures::FixtureId;
use crate::models::sequencer::*;

impl From<mizer_sequencer::Sequence> for Sequence {
    fn from(sequence: mizer_sequencer::Sequence) -> Self {
        Self {
            id: sequence.id,
            name: sequence.name,
            cues: sequence.cues.into_iter().map(Cue::from).collect(),
            fixtures: sequence.fixtures.into_iter().map(FixtureId::from).collect(),
            wrapAround: sequence.wrap_around,
            stopOnLastCue: sequence.stop_on_last_cue,
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::Cue> for Cue {
    fn from(cue: mizer_sequencer::Cue) -> Self {
        Self {
            id: cue.id,
            name: cue.name,
            trigger: MessageField::some(CueTrigger {
                type_: EnumOrUnknown::new(cue.trigger.into()),
                time: cue.trigger_time.map(|time| time.into()).into(),
                ..Default::default()
            }),
            controls: cue.controls.into_iter().map(CueControl::from).collect(),
            effects: cue.effects.into_iter().map(CueEffect::from).collect(),
            cue_timings: MessageField::some(CueTimings {
                fade: MessageField::some(CueTimer::from(cue.cue_fade)),
                delay: MessageField::some(CueTimer::from(cue.cue_delay)),
                ..Default::default()
            }),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::CueTrigger> for cue_trigger::Type {
    fn from(trigger: mizer_sequencer::CueTrigger) -> Self {
        use mizer_sequencer::CueTrigger::*;

        match trigger {
            Go => Self::GO,
            Follow => Self::FOLLOW,
            Time => Self::TIME,
            Beats => Self::BEATS,
            Timecode => Self::TIMECODE,
        }
    }
}

impl From<cue_trigger::Type> for mizer_sequencer::CueTrigger {
    fn from(trigger: cue_trigger::Type) -> Self {
        use cue_trigger::Type::*;

        match trigger {
            GO => Self::Go,
            FOLLOW => Self::Follow,
            TIME => Self::Time,
            BEATS => Self::Beats,
            TIMECODE => Self::Timecode,
        }
    }
}

impl From<mizer_sequencer::CueControl> for CueControl {
    fn from(channel: mizer_sequencer::CueControl) -> Self {
        Self {
            type_: EnumOrUnknown::new(channel.control.into()),
            value: MessageField::some(channel.value.into()),
            fixtures: channel
                .fixtures
                .get_fixtures()
                .into_iter()
                .flatten()
                .map(FixtureId::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::SequencerValue<f64>> for CueValue {
    fn from(value: mizer_sequencer::SequencerValue<f64>) -> Self {
        match value {
            SequencerValue::Direct(value) => CueValue {
                value: Some(cue_value::Value::Direct(value)),
                ..Default::default()
            },
            SequencerValue::Range((from, to)) => CueValue {
                value: Some(cue_value::Value::Range(CueValueRange {
                    from,
                    to,
                    ..Default::default()
                })),
                ..Default::default()
            },
        }
    }
}

impl From<CueValue> for mizer_sequencer::SequencerValue<f64> {
    fn from(value: CueValue) -> Self {
        match value.value.unwrap() {
            cue_value::Value::Direct(value) => SequencerValue::Direct(value),
            cue_value::Value::Range(range) => SequencerValue::Range((range.from, range.to)),
        }
    }
}

impl From<Option<SequencerValue<mizer_sequencer::SequencerTime>>> for CueTimer {
    fn from(value: Option<SequencerValue<mizer_sequencer::SequencerTime>>) -> Self {
        use mizer_sequencer::SequencerTime;
        match value {
            None => CueTimer {
                hasTimer: false,
                timer: None,
                ..Default::default()
            },
            Some(SequencerValue::Direct(SequencerTime::Seconds(value))) => CueTimer {
                hasTimer: true,
                timer: Some(cue_timer::Timer::Direct(CueTime {
                    time: Some(cue_time::Time::Seconds(value)),
                    ..Default::default()
                })),
                ..Default::default()
            },
            Some(SequencerValue::Direct(SequencerTime::Beats(value))) => CueTimer {
                hasTimer: true,
                timer: Some(cue_timer::Timer::Direct(CueTime {
                    time: Some(cue_time::Time::Beats(value)),
                    ..Default::default()
                })),
                ..Default::default()
            },
            Some(SequencerValue::Range((
                SequencerTime::Seconds(from),
                SequencerTime::Seconds(to),
            ))) => CueTimer {
                hasTimer: true,
                timer: Some(cue_timer::Timer::Range(CueTimerRange {
                    from: MessageField::some(CueTime {
                        time: Some(cue_time::Time::Seconds(from)),
                        ..Default::default()
                    }),
                    to: MessageField::some(CueTime {
                        time: Some(cue_time::Time::Seconds(to)),
                        ..Default::default()
                    }),
                    ..Default::default()
                })),
                ..Default::default()
            },
            Some(SequencerValue::Range((SequencerTime::Beats(from), SequencerTime::Beats(to)))) => {
                CueTimer {
                    hasTimer: true,
                    timer: Some(cue_timer::Timer::Range(CueTimerRange {
                        from: MessageField::some(CueTime {
                            time: Some(cue_time::Time::Beats(from)),
                            ..Default::default()
                        }),
                        to: MessageField::some(CueTime {
                            time: Some(cue_time::Time::Beats(to)),
                            ..Default::default()
                        }),
                        ..Default::default()
                    })),
                    ..Default::default()
                }
            }
            _ => unreachable!("invalid combination of beats and seconds in range"),
        }
    }
}

impl From<CueTimer> for Option<SequencerValue<mizer_sequencer::SequencerTime>> {
    fn from(timer: CueTimer) -> Self {
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
                ..Default::default()
            },
            mizer_sequencer::SequencerTime::Beats(beats) => Self {
                time: Some(cue_time::Time::Beats(beats)),
                ..Default::default()
            },
        }
    }
}

impl From<mizer_fixtures::definition::FixtureFaderControl> for cue_control::Type {
    fn from(fixture_control: mizer_fixtures::definition::FixtureFaderControl) -> Self {
        use mizer_fixtures::definition::ColorChannel;
        use mizer_fixtures::definition::FixtureFaderControl::*;

        match fixture_control {
            Intensity => Self::INTENSITY,
            Shutter => Self::SHUTTER,
            Focus => Self::FOCUS,
            Zoom => Self::ZOOM,
            Iris => Self::IRIS,
            Prism => Self::PRISM,
            Frost => Self::FROST,
            Pan => Self::PAN,
            Tilt => Self::TILT,
            Gobo => Self::GOBO,
            ColorMixer(ColorChannel::Red) => Self::COLOR_RED,
            ColorMixer(ColorChannel::Green) => Self::COLOR_GREEN,
            ColorMixer(ColorChannel::Blue) => Self::COLOR_BLUE,
            ColorWheel => Self::COLOR_WHEEL,
            Generic(_) => Self::GENERIC,
        }
    }
}

impl From<mizer_sequencer::CueEffect> for CueEffect {
    fn from(effect: mizer_sequencer::CueEffect) -> Self {
        Self {
            effect_id: effect.effect,
            effect_offsets: effect.effect_offset.and_then(|time| {
                if let SequencerTime::Beats(value) = time {
                    Some(value)
                } else {
                    None
                }
            }),
            ..Default::default()
        }
    }
}
