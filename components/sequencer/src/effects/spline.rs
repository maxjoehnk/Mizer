use std::iter::FromIterator;
use geo_nd::Vector;
use std::num::FpCategory;
use num_traits::{Num, One, ToPrimitive, Zero};
use crate::{EffectControlPoint, SequencerValue};

pub type Bezier = bezier_nd::Bezier<SequencerValue<f64>, Point, 2>;

#[derive(Debug, Clone, Default)]
pub struct Spline(Vec<SplinePart>);

impl FromIterator<SplinePart> for Spline {
    fn from_iter<T: IntoIterator<Item = SplinePart>>(iter: T) -> Self {
        Self(iter.into_iter().collect())
    }
}

impl Spline {
    pub fn sample(&self, mut frame: f64) -> Option<SequencerValue<f64>> {
        while frame > self.0.len() as f64 {
            frame -= self.0.len() as f64;
        }
        let index = frame.floor() as usize;
        if let Some((index, curve)) = self.0.get(index).map(|c| (index, c)).or_else(|| self.0.get(0).map(|c| (0, c))) {
            let point_in_curve = frame - index as f64;
            let point = curve.0.point_at(SequencerValue::Direct(point_in_curve));

            Some(point[1])
        } else {
            None
        }
    }
}

#[derive(Debug, Clone)]
pub struct SplinePart(Bezier);

impl SplinePart {
    pub fn new(start: [SequencerValue<f64>; 2], end: [SequencerValue<f64>; 2], control_point: EffectControlPoint) -> Self {
        let start = Point::from_array(start);
        let end = Point::from_array(end);

        let bezier = match control_point {
            EffectControlPoint::Simple => Bezier::line(&start, &end),
            EffectControlPoint::Cubic(c0, c1) => Bezier::cubic(
                &start,
                &Point::from_array([
                    c0[0].into(),
                    c0[1].into(),
                ]),
                &Point::from_array([
                    c1[0].into(),
                    c1[1].into(),
                ]),
                &end,
            ),
            EffectControlPoint::Quadratic(c) => Bezier::quadratic(
                &start,
                &Point::from_array([
                    c[0].into(),
                    c[1].into(),
                ]),
                &end,
            ),
        };

        Self(bezier)
    }
}

type Point = geo_nd::FArray<SequencerValue<f64>, 2>;

impl geo_nd::Float for SequencerValue<f64> {}
impl num_traits::float::Float for SequencerValue<f64> {
    fn nan() -> Self {
        Self::Direct(f64::nan())
    }

    fn infinity() -> Self {
        Self::Direct(f64::infinity())
    }

    fn neg_infinity() -> Self {
        Self::Direct(f64::neg_infinity())
    }

    fn neg_zero() -> Self {
        Self::Direct(f64::neg_zero())
    }

    fn min_value() -> Self {
        Self::Direct(f64::min_value())
    }

    fn min_positive_value() -> Self {
        Self::Direct(f64::min_positive_value())
    }

    fn max_value() -> Self {
        Self::Direct(f64::max_value())
    }

    fn is_nan(self) -> bool {
        unimplemented!()
    }

    fn is_infinite(self) -> bool {
        unimplemented!()
    }

    fn is_finite(self) -> bool {
        unimplemented!()
    }

    fn is_normal(self) -> bool {
        unimplemented!()
    }

    fn classify(self) -> FpCategory {
        unimplemented!()
    }

    fn floor(self) -> Self {
        unimplemented!()
    }

    fn ceil(self) -> Self {
        unimplemented!()
    }

    fn round(self) -> Self {
        unimplemented!()
    }

    fn trunc(self) -> Self {
        unimplemented!()
    }

    fn fract(self) -> Self {
        unimplemented!()
    }

    fn abs(self) -> Self {
        unimplemented!()
    }

    fn signum(self) -> Self {
        unimplemented!()
    }

    fn is_sign_positive(self) -> bool {
        unimplemented!()
    }

    fn is_sign_negative(self) -> bool {
        unimplemented!()
    }

    fn mul_add(self, a: Self, b: Self) -> Self {
        unimplemented!()
    }

    fn recip(self) -> Self {
        unimplemented!()
    }

    fn powi(self, n: i32) -> Self {
        unimplemented!()
    }

    fn powf(self, n: Self) -> Self {
        unimplemented!()
    }

    fn sqrt(self) -> Self {
        unimplemented!()
    }

    fn exp(self) -> Self {
        unimplemented!()
    }

    fn exp2(self) -> Self {
        unimplemented!()
    }

    fn ln(self) -> Self {
        unimplemented!()
    }

    fn log(self, base: Self) -> Self {
        unimplemented!()
    }

    fn log2(self) -> Self {
        unimplemented!()
    }

    fn log10(self) -> Self {
        unimplemented!()
    }

    fn max(self, other: Self) -> Self {
        unimplemented!()
    }

    fn min(self, other: Self) -> Self {
        unimplemented!()
    }

    fn abs_sub(self, other: Self) -> Self {
        unimplemented!()
    }

    fn cbrt(self) -> Self {
        unimplemented!()
    }

    fn hypot(self, other: Self) -> Self {
        unimplemented!()
    }

    fn sin(self) -> Self {
        unimplemented!()
    }

    fn cos(self) -> Self {
        unimplemented!()
    }

    fn tan(self) -> Self {
        unimplemented!()
    }

    fn asin(self) -> Self {
        unimplemented!()
    }

    fn acos(self) -> Self {
        unimplemented!()
    }

    fn atan(self) -> Self {
        unimplemented!()
    }

    fn atan2(self, other: Self) -> Self {
        unimplemented!()
    }

    fn sin_cos(self) -> (Self, Self) {
        unimplemented!()
    }

    fn exp_m1(self) -> Self {
        unimplemented!()
    }

    fn ln_1p(self) -> Self {
        unimplemented!()
    }

    fn sinh(self) -> Self {
        unimplemented!()
    }

    fn cosh(self) -> Self {
        unimplemented!()
    }

    fn tanh(self) -> Self {
        unimplemented!()
    }

    fn asinh(self) -> Self {
        unimplemented!()
    }

    fn acosh(self) -> Self {
        unimplemented!()
    }

    fn atanh(self) -> Self {
        unimplemented!()
    }

    fn integer_decode(self) -> (u64, i16, i8) {
        unimplemented!()
    }
}

impl ToPrimitive for SequencerValue<f64> {
    fn to_i64(&self) -> Option<i64> {
        None
    }

    fn to_u64(&self) -> Option<u64> {
        None
    }

    fn to_f64(&self) -> Option<f64> {
        match self {
            Self::Direct(value) => Some(*value),
            _ => None,
        }
    }
}

impl num_traits::NumCast for SequencerValue<f64> {
    fn from<T: ToPrimitive>(n: T) -> Option<Self> {
        n.to_f64()
            .map(SequencerValue::Direct)
    }
}

impl Num for SequencerValue<f64> {
    type FromStrRadixErr = ();

    fn from_str_radix(str: &str, radix: u32) -> Result<Self, Self::FromStrRadixErr> {
        unimplemented!()
    }
}

impl Zero for SequencerValue<f64> {
    fn zero() -> Self {
        Self::Direct(f64::zero())
    }

    fn is_zero(&self) -> bool {
        match self {
            Self::Direct(v) => v.is_zero(),
            Self::Range((a, b)) => a.is_zero() && b.is_zero(),
        }
    }
}

impl One for SequencerValue<f64> {
    fn one() -> Self {
        Self::Direct(f64::one())
    }
}

impl geo_nd::Num for SequencerValue<f64> {}

#[cfg(test)]
mod tests {
    use std::iter::FromIterator;
    use geo_nd::Vector;
    use crate::{EffectControlPoint, SequencerValue, Spline, SplinePart};

    #[test]
    fn bezier_test() {
        pub type RangeBezier = bezier_nd::Bezier<f64, geo_nd::FArray<f64, 2>, 2>;
        let bezier = RangeBezier::line(&geo_nd::FArray::from_array([0., 0.]), &geo_nd::FArray::from_array([1., 0.]));

        assert_eq!(bezier.point_at(0.)[1], 0.);
        assert_eq!(bezier.point_at(1.)[1], 0.);
    }

    #[test]
    fn bezier_direct_test() {
        let spline = SplinePart::new([0.0.into(), 0.0.into()], [1.0.into(), 0.0.into()], EffectControlPoint::Simple);
        let spline = Spline::from_iter([spline]);

        assert_eq!(spline.sample(0.), Some(SequencerValue::Direct(0.)));
        assert_eq!(spline.sample(1.), Some(SequencerValue::Direct(0.)));
    }

    #[test]
    fn bezier_range_test() {
        let spline = SplinePart::new([0.0.into(), 0.0.into()], [1.0.into(), SequencerValue::Range((0., 1.))], EffectControlPoint::Simple);
        let spline = Spline::from_iter([spline]);

        assert_eq!(spline.sample(0.), Some(SequencerValue::Range((0., 0.))));
        assert_eq!(spline.sample(1.), Some(SequencerValue::Range((0., 1.))));
    }
}
