use std::ops::{Add, Div, Mul, Sub};

pub trait LerpExt<To: Sized = Self> {
    // This is not called lerp because it will conflict with a currently unstable function of the standard library [2022-01-01]
    fn linear_extrapolate(self, from: (Self, Self), to: (To, To)) -> To
    where
        Self: Sized;
}

impl<
        T: Add<Output = Self>
            + Sub<Output = Self>
            + Mul<Output = Self>
            + Div<Output = Self>
            + Copy
            + std::fmt::Debug
            + std::cmp::PartialEq,
    > LerpExt for T
{
    // TODO: measure whether we should inline this
    fn linear_extrapolate(self, from: (Self, Self), to: (Self, Self)) -> Self
    where
        Self: Sized,
    {
        // TODO: properly handle 0.linear_extrapolate((0, 0), (0, 1))
        if from.0 == from.1 {
            return to.1;
        }

        ((self - from.0) * (to.1 - to.0)) / (from.1 - from.0) + to.0
    }
}

impl LerpExt<f64> for u8 {
    fn linear_extrapolate(self, from: (u8, u8), to: (f64, f64)) -> f64 {
        let value = self as f64;
        let min = from.0 as f64;
        let max = from.1 as f64;

        value.linear_extrapolate((min, max), to)
    }
}

impl LerpExt<u8> for f64 {
    fn linear_extrapolate(self, from: (f64, f64), to: (u8, u8)) -> u8 {
        let value = self as f64;
        let min = from.0 as f64;
        let max = from.1 as f64;

        let result: f64 = value.linear_extrapolate((min, max), (to.0 as f64, to.1 as f64));
        result as u8
    }
}

#[cfg(test)]
mod tests {
    use crate::LerpExt;
    use test_case::test_case;

    #[test_case((0., 1.), (0., 1.), 0., 0.)]
    #[test_case((0., 1.), (0., 1.), 1., 1.)]
    fn linear_extrapolate_should_extrapolate(
        from: (f64, f64),
        to: (f64, f64),
        value: f64,
        expected: f64,
    ) {
        let result = value.linear_extrapolate(from, to);

        assert_eq!(expected, result);
    }
}
