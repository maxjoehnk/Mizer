use std::fmt::{Display, Formatter};
use std::ops::Add;

use serde::{Deserialize, Serialize};

use mizer_util::Spline;

// TODO: rename to something more fitting
#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct TimecodeTrack {
    pub id: TimecodeId,
    pub name: String,
    pub controls: Vec<TimecodeControlValues>,
    pub labels: Vec<TimecodeLabel>,
}

impl TimecodeTrack {
    pub fn get_control(&self, control_id: TimecodeControlId) -> Option<&TimecodeControlValues> {
        self.controls.iter().find(|c| c.id == control_id)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct TimecodeControlValues {
    pub id: TimecodeControlId,
    pub spline: Spline,
}

impl TimecodeControlValues {
    pub fn sample(&self, timestamp: u64) -> f64 {
        let max_frame = self
            .spline
            .steps
            .iter()
            .map(|s| s.x)
            .last()
            .unwrap_or_default();

        self.spline.sample(timestamp as f64, max_frame)
    }

    pub fn is_out_of_bounds(&self, timestamp: u64) -> bool {
        let max_frame = self
            .spline
            .steps
            .iter()
            .map(|s| s.x)
            .last()
            .unwrap_or_default();

        timestamp as f64 > max_frame
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct TimecodeLabel {
    pub timecode: TimecodeLabelId,
    pub label: String,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct TimecodeControl {
    pub id: TimecodeControlId,
    pub name: String,
}

#[derive(
    Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash,
)]
#[repr(transparent)]
#[serde(transparent)]
pub struct TimecodeId(pub u32);

impl From<u32> for TimecodeId {
    fn from(value: u32) -> Self {
        Self(value)
    }
}

impl From<TimecodeId> for u32 {
    fn from(value: TimecodeId) -> u32 {
        value.0
    }
}

impl Display for TimecodeId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

impl Add<u32> for TimecodeId {
    type Output = Self;

    fn add(self, rhs: u32) -> Self::Output {
        Self(self.0 + rhs)
    }
}

#[derive(
    Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash,
)]
#[repr(transparent)]
#[serde(transparent)]
pub struct TimecodeControlId(pub u32);

impl Display for TimecodeControlId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

impl Add<u32> for TimecodeControlId {
    type Output = Self;

    fn add(self, rhs: u32) -> Self::Output {
        Self(self.0 + rhs)
    }
}

impl From<u32> for TimecodeControlId {
    fn from(value: u32) -> Self {
        Self(value)
    }
}

impl From<TimecodeControlId> for u32 {
    fn from(value: TimecodeControlId) -> u32 {
        value.0
    }
}

#[derive(
    Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash,
)]
#[repr(transparent)]
#[serde(transparent)]
pub struct TimecodeLabelId(pub u32);

impl Display for TimecodeLabelId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

impl Add<u32> for TimecodeLabelId {
    type Output = Self;

    fn add(self, rhs: u32) -> Self::Output {
        Self(self.0 + rhs)
    }
}

impl From<u32> for TimecodeLabelId {
    fn from(value: u32) -> Self {
        Self(value)
    }
}

impl From<TimecodeLabelId> for u32 {
    fn from(value: TimecodeLabelId) -> u32 {
        value.0
    }
}
