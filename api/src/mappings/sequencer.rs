use mizer_sequencer::{SequencerTime, SequencerValue};

use crate::models::*;
use protobuf::SingularPtrField;

impl From<mizer_sequencer::Sequence> for Sequence {
    fn from(sequence: mizer_sequencer::Sequence) -> Self {
        Self {
            id: sequence.id,
            name: sequence.name,
            cues: sequence.cues.into_iter().map(Cue::from).collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::Cue> for Cue {
    fn from(cue: mizer_sequencer::Cue) -> Self {
        Self {
            id: cue.id,
            name: cue.name,
            trigger: cue.trigger.into(),
            field_loop: false,
            channels: cue.channels.into_iter().map(CueChannel::from).collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::CueTrigger> for CueTrigger {
    fn from(trigger: mizer_sequencer::CueTrigger) -> Self {
        use mizer_sequencer::CueTrigger::*;

        match trigger {
            Go => CueTrigger::GO,
            Follow => CueTrigger::FOLLOW,
            Beats => CueTrigger::BEATS,
            Timecode => CueTrigger::TIMECODE,
        }
    }
}

impl From<mizer_sequencer::CueChannel> for CueChannel {
    fn from(channel: mizer_sequencer::CueChannel) -> Self {
        let value = match channel.value {
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
        };

        Self {
            fixtures: channel.fixtures.into_iter()
                .map(FixtureId::from)
                .collect(),
            control: channel.control.into(),
            value: SingularPtrField::some(value),
            fade: SingularPtrField::some(CueTimer::from(channel.fade)),
            delay: SingularPtrField::some(CueTimer::from(channel.delay)),
            ..Default::default()
        }
    }
}

impl From<Option<SequencerValue<SequencerTime>>> for CueTimer {
    fn from(value: Option<SequencerValue<SequencerTime>>) -> Self {
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

impl From<mizer_fixtures::definition::FixtureControl> for CueControl {
    fn from(fixture_control: mizer_fixtures::definition::FixtureControl) -> Self {
        use mizer_fixtures::definition::FixtureControl::*;
        use mizer_fixtures::definition::ColorChannel;

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
            Color(ColorChannel::Red) => Self::COLOR_RED,
            Color(ColorChannel::Green) => Self::COLOR_GREEN,
            Color(ColorChannel::Blue) => Self::COLOR_BLUE,
            Generic(_) => Self::GENERIC,
        }
    }
}
