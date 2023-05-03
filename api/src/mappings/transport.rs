use crate::models::transport::{Timecode, Transport, TransportState};
use mizer_clock::{ClockSnapshot, ClockState};
use protobuf::{EnumOrUnknown, MessageField};

impl From<ClockSnapshot> for Transport {
    fn from(snapshot: ClockSnapshot) -> Self {
        Transport {
            speed: snapshot.speed,
            state: EnumOrUnknown::new(snapshot.state.into()),
            timecode: MessageField::some(snapshot.time.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_clock::Timecode> for Timecode {
    fn from(timecode: mizer_clock::Timecode) -> Self {
        Self {
            frames: timecode.frames,
            hours: timecode.hours,
            minutes: timecode.minutes,
            seconds: timecode.seconds,
            ..Default::default()
        }
    }
}

impl From<ClockState> for TransportState {
    fn from(state: ClockState) -> Self {
        match state {
            ClockState::Playing => Self::PLAYING,
            ClockState::Paused => Self::PAUSED,
            ClockState::Stopped => Self::STOPPED,
        }
    }
}

impl From<TransportState> for ClockState {
    fn from(state: TransportState) -> Self {
        match state {
            TransportState::PLAYING => Self::Playing,
            TransportState::PAUSED => Self::Paused,
            TransportState::STOPPED => Self::Stopped,
        }
    }
}
