pub trait ConvertBytes {
    fn to_8bit(self) -> u8;
    fn from_8bit(value: u8) -> Self;
}

impl ConvertBytes for f64 {
    fn to_8bit(self) -> u8 {
        (self * u8::MAX as f64).min(255.).max(0.).floor() as u8
    }

    fn from_8bit(value: u8) -> Self {
        let max = u8::MAX as f64;
        let value = value as f64;

        value / max
    }
}

pub trait ConvertPercentages {
    fn to_percentage(self) -> f64;
}

impl ConvertPercentages for u8 {
    fn to_percentage(self) -> f64 {
        f64::from_8bit(self)
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    #[test_case(0., 0)]
    #[test_case(0.5, 127)]
    #[test_case(1., 255)]
    #[test_case(2., 255)]
    fn convert_to_8bit_should_convert_float_to_u8(input: f64, expected: u8) {
        let result = input.to_8bit();

        assert_eq!(result, expected);
    }

    #[test_case(0, 0.)]
    #[test_case(255, 1.)]
    fn convert_from_8bit_should_convert_u8_to_float(input: u8, expected: f64) {
        let result = f64::from_8bit(input);

        assert_eq!(result, expected);
    }

    #[test_case(0, 0.)]
    #[test_case(255, 1.)]
    fn to_percentage_should_convert_u8_to_float(input: u8, expected: f64) {
        let result = input.to_percentage();

        assert_eq!(result, expected);
    }
}
