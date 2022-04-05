use mizer_sequencer::SequencerValue;

use crate::models::*;
use protobuf::SingularPtrField;

impl From<mizer_sequencer::Sequence> for Sequence {
    fn from(sequence: mizer_sequencer::Sequence) -> Self {
        Self {
            id: sequence.id,
            name: sequence.name,
            cues: sequence.cues.into_iter().map(Cue::from).collect(),
            fixtures: sequence.fixtures.into_iter().map(FixtureId::from).collect(),
            wrapAround: sequence.wrap_around,
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::Cue> for Cue {
    fn from(cue: mizer_sequencer::Cue) -> Self {
        Self {
            id: cue.id,
            name: cue.name,
            trigger: SingularPtrField::some(CueTrigger {
                field_type: cue.trigger.into(),
                _time: cue
                    .trigger_time
                    .map(|time| CueTrigger_oneof__time::time(CueTime::from(time))),
                ..Default::default()
            }),
            // field_loop: matches!(cue.loop_mode, mizer_sequencer::LoopMode::JumpTo(_)),
            controls: cue.controls.into_iter().map(CueControl::from).collect(),
            // effects: cue.effects.into_iter().map(CueEffect::from).collect(),
            cue_timings: SingularPtrField::some(CueTimings {
                fade: SingularPtrField::some(CueTimer::from(cue.cue_fade)),
                delay: SingularPtrField::some(CueTimer::from(cue.cue_delay)),
                ..Default::default()
            }),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::CueTrigger> for CueTrigger_Type {
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

impl From<CueTrigger_Type> for mizer_sequencer::CueTrigger {
    fn from(trigger: CueTrigger_Type) -> Self {
        use CueTrigger_Type::*;

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
            field_type: channel.control.into(),
            value: SingularPtrField::some(channel.value.into()),
            fixtures: channel.fixtures.into_iter().map(FixtureId::from).collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::SequencerValue<f64>> for CueValue {
    fn from(value: mizer_sequencer::SequencerValue<f64>) -> Self {
        match value {
            SequencerValue::Direct(value) => CueValue {
                value: Some(CueValue_oneof_value::direct(value)),
                ..Default::default()
            },
            SequencerValue::Range((from, to)) => CueValue {
                value: Some(CueValue_oneof_value::range(CueValueRange {
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
            CueValue_oneof_value::direct(value) => SequencerValue::Direct(value),
            CueValue_oneof_value::range(range) => SequencerValue::Range((range.from, range.to)),
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
                timer: Some(CueTimer_oneof_timer::direct(CueTime {
                    time: Some(CueTime_oneof_time::seconds(value)),
                    ..Default::default()
                })),
                ..Default::default()
            },
            Some(SequencerValue::Direct(SequencerTime::Beats(value))) => CueTimer {
                hasTimer: true,
                timer: Some(CueTimer_oneof_timer::direct(CueTime {
                    time: Some(CueTime_oneof_time::beats(value)),
                    ..Default::default()
                })),
                ..Default::default()
            },
            Some(SequencerValue::Range((
                SequencerTime::Seconds(from),
                SequencerTime::Seconds(to),
            ))) => CueTimer {
                hasTimer: true,
                timer: Some(CueTimer_oneof_timer::range(CueTimerRange {
                    from: SingularPtrField::some(CueTime {
                        time: Some(CueTime_oneof_time::seconds(from)),
                        ..Default::default()
                    }),
                    to: SingularPtrField::some(CueTime {
                        time: Some(CueTime_oneof_time::seconds(to)),
                        ..Default::default()
                    }),
                    ..Default::default()
                })),
                ..Default::default()
            },
            Some(SequencerValue::Range((SequencerTime::Beats(from), SequencerTime::Beats(to)))) => {
                CueTimer {
                    hasTimer: true,
                    timer: Some(CueTimer_oneof_timer::range(CueTimerRange {
                        from: SingularPtrField::some(CueTime {
                            time: Some(CueTime_oneof_time::beats(from)),
                            ..Default::default()
                        }),
                        to: SingularPtrField::some(CueTime {
                            time: Some(CueTime_oneof_time::beats(to)),
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
            Some(CueTimer_oneof_timer::direct(time)) => Some(SequencerValue::Direct(time.into())),
            Some(CueTimer_oneof_timer::range(range)) => Some(SequencerValue::Range((
                range.from.unwrap().into(),
                range.to.unwrap().into(),
            ))),
        }
    }
}

impl From<CueTime> for mizer_sequencer::SequencerTime {
    fn from(time: CueTime) -> Self {
        match time.time.unwrap() {
            CueTime_oneof_time::seconds(seconds) => Self::Seconds(seconds),
            CueTime_oneof_time::beats(beats) => Self::Beats(beats),
        }
    }
}

impl From<mizer_sequencer::SequencerTime> for CueTime {
    fn from(time: mizer_sequencer::SequencerTime) -> Self {
        match time {
            mizer_sequencer::SequencerTime::Seconds(seconds) => Self {
                time: Some(CueTime_oneof_time::seconds(seconds)),
                ..Default::default()
            },
            mizer_sequencer::SequencerTime::Beats(beats) => Self {
                time: Some(CueTime_oneof_time::beats(beats)),
                ..Default::default()
            },
        }
    }
}

impl From<mizer_fixtures::definition::FixtureFaderControl> for CueControl_Type {
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
            Color(ColorChannel::Red) => Self::COLOR_RED,
            Color(ColorChannel::Green) => Self::COLOR_GREEN,
            Color(ColorChannel::Blue) => Self::COLOR_BLUE,
            Generic(_) => Self::GENERIC,
        }
    }
}

// impl From<mizer_sequencer::CueEffect> for CueEffect {
//     fn from(effect: mizer_sequencer::CueEffect) -> Self {
//         Self {
//             fixtures: effect.fixtures.into_iter().map(FixtureId::from).collect(),
//             effect_id: effect.effect,
//             ..Default::default()
//         }
//     }
// }
