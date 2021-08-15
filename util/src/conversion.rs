pub trait ConvertToDmx {
    fn to_8bit(self) -> u8;
}

impl ConvertToDmx for f64 {
    fn to_8bit(self) -> u8 {
        (self * u8::MAX as f64).min(255.).max(0.).floor() as u8
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    #[test_case(0., 0)]
    #[test_case(0.5, 127)]
    #[test_case(2., 255)]
    fn convert_to_8bit_should_convert_float_to_u8(input: f64, expected: u8) {
        let result = input.to_8bit();

        assert_eq!(result, expected);
    }
}
