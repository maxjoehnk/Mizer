#[derive(Default, Debug, Clone, Copy)]
pub struct Edge {
    last_value: Option<f64>,
}

impl Edge {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn update(&mut self, value: f64) -> Option<bool> {
        if let Some(last_value) = self.last_value {
            if last_value > 0f64 && value > 0f64 {
                return None;
            }
            if (last_value - value) <= f64::EPSILON && value <= f64::EPSILON {
                return None;
            }
        }
        self.last_value = Some(value);
        Some(value > 0f64)
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use crate::edge::Edge;

    #[test]
    fn update_with_zero_should_return_false() {
        let mut edge = Edge::new();

        let result = edge.update(0f64);

        assert_eq!(Some(false), result);
    }

    #[test]
    fn update_with_value_above_zero_should_return_true() {
        let mut edge = Edge::new();

        let result = edge.update(1f64);

        assert_eq!(Some(true), result);
    }

    #[test_case(1f64)]
    #[test_case(0f64)]
    fn same_value_twice_in_a_row_should_return_none(value: f64) {
        let mut edge = Edge::new();
        edge.update(value);

        let result = edge.update(value);

        assert_eq!(None, result);
    }

    #[test_case(0.5f64, 1f64)]
    #[test_case(1f64, 0.5f64)]
    fn returning_two_values_above_zero_after_each_other_should_return_none(
        first: f64,
        second: f64,
    ) {
        let mut edge = Edge::new();
        edge.update(first);

        let result = edge.update(second);

        assert_eq!(None, result);
    }

    #[test_case(0.5f64)]
    #[test_case(1f64)]
    fn rising_edge_should_return_true(value: f64) {
        let mut edge = Edge::new();
        edge.update(0f64);

        let result = edge.update(value);

        assert_eq!(Some(true), result);
    }

    #[test_case(0.5f64)]
    #[test_case(1f64)]
    fn falling_edge_should_return_false(value: f64) {
        let mut edge = Edge::new();
        edge.update(value);

        let result = edge.update(0f64);

        assert_eq!(Some(false), result);
    }
}
