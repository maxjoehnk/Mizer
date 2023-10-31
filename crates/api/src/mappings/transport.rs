use mizer_clock::{ClockSnapshot, ClockState};

use crate::proto::transport::{Timecode, Transport, TransportState};

impl From<ClockSnapshot> for Transport {
    fn from(snapshot: ClockSnapshot) -> Self {
        Transport {
            speed: snapshot.speed,
            state: TransportState::from(snapshot.state) as i32,
            timecode: Some(snapshot.time.into()),
            fps: snapshot.fps,
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
        }
    }
}

impl From<ClockState> for TransportState {
    fn from(state: ClockState) -> Self {
        match state {
            ClockState::Playing => Self::Playing,
            ClockState::Paused => Self::Paused,
            ClockState::Stopped => Self::Stopped,
        }
    }
}

impl From<TransportState> for ClockState {
    fn from(state: TransportState) -> Self {
        match state {
            TransportState::Playing => Self::Playing,
            TransportState::Paused => Self::Paused,
            TransportState::Stopped => Self::Stopped,
        }
    }
}
