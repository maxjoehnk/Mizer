use std::fmt::{Display, Formatter};
use serde::{Deserialize, Serialize};
use std::ops::{Mul, Sub, Add, Div, AddAssign, Neg, Rem, SubAssign, MulAssign, DivAssign, RemAssign};
use mizer_util::LerpExt;

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, PartialOrd)]
#[serde(untagged)]
pub enum SequencerValue<T> {
    Direct(T),
    Range((T, T)),
}

impl SequencerValue<f64> {
    pub fn cos(self) -> Self {
        match self {
            Self::Direct(value) => Self::Direct(value.cos()),
            Self::Range((a, b)) => Self::Range((a.cos(), b.cos())),
        }
    }
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

impl<T: Mul<T, Output = T> + Copy> Mul<Self> for SequencerValue<T> {
    type Output = Self;

    fn mul(self, rhs: Self) -> Self::Output {
        match (self, rhs) {
            (Self::Direct(lhs), Self::Direct(rhs)) => Self::Direct(lhs * rhs),
            (Self::Range(lhs), Self::Direct(rhs)) => Self::Range((lhs.0 * rhs, lhs.1 * rhs)),
            (Self::Direct(lhs), Self::Range(rhs)) => Self::Range((lhs * rhs.0, lhs * rhs.1)),
            (Self::Range(lhs), Self::Range(rhs)) => Self::Range((lhs.0 * rhs.0, lhs.1 * rhs.1)),
        }
    }
}

impl<T: Mul<T, Output = T> + Copy> Mul<T> for SequencerValue<T> {
    type Output = Self;

    fn mul(self, rhs: T) -> Self::Output {
        match self {
            Self::Direct(lhs) => Self::Direct(lhs * rhs),
            Self::Range((a, b)) => Self::Range((a * rhs, b * rhs)),
        }
    }
}

impl<T: Mul<Output = T> + Copy> MulAssign<Self> for SequencerValue<T> {
    fn mul_assign(&mut self, rhs: Self) {
        *self = *self * rhs;
    }
}

impl Mul<SequencerValue<f64>> for f64 {
    type Output = SequencerValue<f64>;

    fn mul(self, rhs: SequencerValue<f64>) -> Self::Output {
        match rhs {
            Self::Output::Direct(rhs) => Self::Output::Direct(rhs * self),
            Self::Output::Range((a, b)) => Self::Output::Range((a * self, b * self)),
        }
    }
}

impl<T: Sub<Output = T> + Copy> Sub<Self> for SequencerValue<T> {
    type Output = Self;

    fn sub(self, rhs: Self) -> Self::Output {
        match (self, rhs) {
            (Self::Direct(lhs), Self::Direct(rhs)) => Self::Direct(lhs - rhs),
            (Self::Direct(lhs), Self::Range((a, b))) => Self::Range((lhs - a, lhs - b)),
            (Self::Range((a, b)), Self::Direct(rhs)) => Self::Range((rhs - a, rhs - b)),
            (Self::Range((a1, b1)), Self::Range((a2, b2))) => Self::Range((a1 - a2, b1 - b2)),
        }
    }
}

impl<T: Sub<Output = T> + Copy> Sub<T> for SequencerValue<T> {
    type Output = Self;

    fn sub(self, rhs: T) -> Self::Output {
        match self {
            Self::Direct(lhs) => Self::Direct(lhs - rhs),
            Self::Range((a, b)) => Self::Range((a - rhs, b - rhs)),
        }
    }
}

impl<T: Sub<Output = T> + Copy> SubAssign<Self> for SequencerValue<T> {
    fn sub_assign(&mut self, rhs: Self) {
        *self = *self - rhs;
    }
}

impl Sub<SequencerValue<f64>> for f64 {
    type Output = SequencerValue<f64>;

    fn sub(self, rhs: SequencerValue<f64>) -> Self::Output {
        match rhs {
            SequencerValue::Direct(rhs) => SequencerValue::Direct(self - rhs),
            SequencerValue::Range((a, b)) => SequencerValue::Range((self - a, self - b)),
        }
    }
}

impl<T: Add<Output = T> + Copy> Add<Self> for SequencerValue<T> {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        match (self, rhs) {
            (Self::Direct(lhs), Self::Direct(rhs)) => SequencerValue::Direct(lhs + rhs),
            (Self::Direct(lhs), Self::Range((a, b))) => SequencerValue::Range((lhs + a, lhs + b)),
            (Self::Range((a, b)), Self::Direct(rhs)) => SequencerValue::Range((rhs + a, rhs + b)),
            (Self::Range((a1, b1)), Self::Range((a2, b2))) => SequencerValue::Range((a1 + a2, b1 + b2)),
        }
    }
}

impl<T: Add<Output = T> + Copy> AddAssign for SequencerValue<T> {
    fn add_assign(&mut self, rhs: Self) {
        *self = *self + rhs;
    }
}

impl Add<SequencerValue<f64>> for f64 {
    type Output = SequencerValue<f64>;

    fn add(self, rhs: SequencerValue<f64>) -> Self::Output {
        match rhs {
            SequencerValue::Direct(rhs) => SequencerValue::Direct(self + rhs),
            SequencerValue::Range((a, b)) => SequencerValue::Range((self + a, self + b)),
        }
    }
}

impl<T: Div<Output = T> + Copy> Div<T> for SequencerValue<T> {
    type Output = Self;

    fn div(self, rhs: T) -> Self::Output {
        match self {
            SequencerValue::Direct(lhs) => SequencerValue::Direct(lhs / rhs),
            SequencerValue::Range((a, b)) => SequencerValue::Range((a / rhs, b / rhs)),
        }
    }
}

impl<T: Div<Output = T> + Copy> Div<Self> for SequencerValue<T> {
    type Output = Self;

    fn div(self, rhs: Self) -> Self::Output {
        match (self, rhs) {
            (Self::Direct(lhs), Self::Direct(rhs)) => Self::Direct(lhs / rhs),
            (Self::Direct(lhs), Self::Range((a, b))) => Self::Range((lhs / a, lhs / b)),
            (Self::Range((a, b)), Self::Direct(rhs)) => Self::Range((a / rhs, b / rhs)),
            (Self::Range((a1, b1)), Self::Range((a2, b2))) => Self::Range((a1 / a2, b1 / b2)),
        }
    }
}

impl<T: Div<Output = T> + Copy> DivAssign<Self> for SequencerValue<T> {
    fn div_assign(&mut self, rhs: Self) {
        *self = *self / rhs;
    }
}

impl Div<SequencerValue<f64>> for f64 {
    type Output = SequencerValue<f64>;

    fn div(self, rhs: SequencerValue<f64>) -> Self::Output {
        match rhs {
            SequencerValue::Direct(rhs) => SequencerValue::Direct(self / rhs),
            SequencerValue::Range((a, b)) => SequencerValue::Range((self / a, self / b)),
        }
    }
}

impl<T: Rem<Output = T> + Copy> Rem<T> for SequencerValue<T> {
    type Output = Self;

    fn rem(self, rhs: T) -> Self::Output {
        match self {
            SequencerValue::Direct(lhs) => SequencerValue::Direct(lhs % rhs),
            SequencerValue::Range((a, b)) => SequencerValue::Range((a % rhs, b % rhs)),
        }
    }
}

impl<T: Rem<Output = T> + Copy> Rem<Self> for SequencerValue<T> {
    type Output = Self;

    fn rem(self, rhs: Self) -> Self::Output {
        match (self, rhs) {
            (Self::Direct(lhs), Self::Direct(rhs)) => Self::Direct(lhs % rhs),
            (Self::Direct(lhs), Self::Range((a, b))) => Self::Range((lhs % a, lhs % b)),
            (Self::Range((a, b)), Self::Direct(rhs)) => Self::Range((rhs % a, rhs % b)),
            (Self::Range((a1, b1)), Self::Range((a2, b2))) => Self::Range((a1 % a2, b1 % b2)),
        }
    }
}

impl<T: Rem<Output = T> + Copy> RemAssign for SequencerValue<T> {
    fn rem_assign(&mut self, rhs: Self) {
        *self = *self % rhs;
    }
}

impl<T: Neg<Output = T> + Copy> Neg for SequencerValue<T> {
    type Output = Self;

    fn neg(self) -> Self::Output {
        match self {
            SequencerValue::Direct(lhs) => SequencerValue::Direct(-lhs),
            SequencerValue::Range((a, b)) => SequencerValue::Range((-a, -b)),
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

impl Display for SequencerValue<f64> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        todo!()
    }
}

impl SequencerValue<f64> {
    pub fn fixture_values(&self, count: usize) -> Vec<f64> {
        match self {
            Self::Direct(value) => vec![*value; count],
            Self::Range((from, to)) => {
                let mut values = Vec::new();
                let source_range = (0., count as f64);
                for i in 0..count {
                    let value: f64 = (i as f64).linear_extrapolate(source_range, (*from, *to));
                    values.push(value)
                }
                values
            }
        }
    }
}
