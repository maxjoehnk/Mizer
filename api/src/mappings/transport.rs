use mizer_clock::{ClockSnapshot, ClockState};
use crate::models::{Transport, TransportState};

impl From<ClockSnapshot> for Transport {
    fn from(snapshot: ClockSnapshot) -> Self {
        Transport {
            speed: snapshot.speed,
            state: snapshot.state.into(),
            time: snapshot.time,
            ..Default::default()
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
