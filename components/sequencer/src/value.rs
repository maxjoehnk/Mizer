use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
#[serde(untagged)]
pub enum SequencerValue<T> {
    Direct(T),
    Range((T, T)),
}

impl<T: PartialOrd + Copy> SequencerValue<T> {
    pub fn highest(&self) -> T {
        match self {
            Self::Direct(value) => *value,
            Self::Range((lhs, rhs)) => {
                if lhs > rhs {
                    *lhs
                } else {
                    *rhs
                }
            }
        }
    }
}

impl<T> From<T> for SequencerValue<T> {
    fn from(value: T) -> Self {
        Self::Direct(value)
    }
}

impl<T> From<(T, T)> for SequencerValue<T> {
    fn from(value: (T, T)) -> Self {
        Self::Range(value)
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, PartialOrd)]
#[serde(tag = "unit", content = "value")]
pub enum SequencerTime {
    #[serde(rename = "seconds")]
    Seconds(f64),
    #[serde(rename = "beats")]
    Beats(f64),
}

impl Default for SequencerValue<SequencerTime> {
    fn default() -> Self {
        Self::Direct(SequencerTime::Seconds(0.))
    }
}
