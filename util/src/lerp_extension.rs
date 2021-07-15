use std::ops::{Add, Div, Mul, Sub};

pub trait LerpExt<To: Sized = Self> {
    fn lerp(self, from: (Self, Self), to: (To, To)) -> To
    where
        Self: Sized;
}

impl<
        T: Add<Output = Self>
            + Sub<Output = Self>
            + Mul<Output = Self>
            + Div<Output = Self>
            + Copy
            + std::fmt::Debug,
    > LerpExt for T
{
    // TODO: measure whether we should inline this
    fn lerp(self, from: (Self, Self), to: (Self, Self)) -> Self
    where
        Self: Sized,
    {
        ((self - from.0) * (to.1 - to.0)) / (from.1 - from.0) + to.0
    }
}

impl LerpExt<f64> for u8 {
    fn lerp(self, from: (u8, u8), to: (f64, f64)) -> f64 {
        let value = self as f64;
        let min = from.0 as f64;
        let max = from.1 as f64;

        value.lerp((min, max), to)
    }
}

impl LerpExt<u8> for f64 {
    fn lerp(self, from: (f64, f64), to: (u8, u8)) -> u8 {
        let value = self as f64;
        let min = from.0 as f64;
        let max = from.1 as f64;

        let result: f64 = value.lerp((min, max), (to.0 as f64, to.1 as f64));
        result as u8
    }
}
