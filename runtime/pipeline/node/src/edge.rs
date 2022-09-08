#[derive(Debug, Default)]
pub struct Edge {
    mode: EdgeMode,
    last_value: Option<f64>,
    last_trigger: bool,
}

#[derive(Debug, Default, PartialEq)]
pub enum EdgeMode {
    #[default]
    Rise,
    Fall,
    Both,
}

impl Edge {
    pub fn new() -> Self {
        Default::default()
    }

    // This is only used in test
    #[allow(dead_code)]
    pub(crate) fn with_mode(mode: EdgeMode) -> Self {
        Self {
            mode,
            ..Self::default()
        }
    }

    pub fn update(&mut self, value: f64) -> Option<bool> {
        if self.mode == EdgeMode::Both {
            let mut result = true;

            if let Some(last_value) = self.last_value {
                let did_keep_value =
                    both_above_zero(last_value, value) || both_are_zero(last_value, value);
                if did_keep_value && self.last_trigger {
                    result = false;
                }
            }

            self.last_value = Some(value);
            self.last_trigger = result;

            return Some(result);
        }

        if let Some(last_value) = self.last_value {
            if both_above_zero(last_value, value) {
                return None;
            }
            if both_are_zero(last_value, value) {
                return None;
            }
        }
        self.last_value = Some(value);

        match self.mode {
            EdgeMode::Fall => Some(value <= 0f64),
            EdgeMode::Rise => Some(value > 0f64),
            EdgeMode::Both => unreachable!(),
        }
    }
}

fn both_above_zero(last_value: f64, value: f64) -> bool {
    last_value > 0f64 && value > 0f64
}

fn both_are_zero(last_value: f64, value: f64) -> bool {
    (last_value - value) <= f64::EPSILON && value <= f64::EPSILON
}

#[cfg(test)]
mod tests {
    mod mode_rise {
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

    mod mode_fall {
        use test_case::test_case;

        use crate::edge::{Edge, EdgeMode};

        #[test]
        fn update_with_zero_should_return_true() {
            let mut edge = Edge::with_mode(EdgeMode::Fall);

            let result = edge.update(0f64);

            assert_eq!(Some(true), result);
        }

        #[test]
        fn update_with_value_above_zero_should_return_false() {
            let mut edge = Edge::with_mode(EdgeMode::Fall);

            let result = edge.update(1f64);

            assert_eq!(Some(false), result);
        }

        #[test_case(1f64)]
        #[test_case(0f64)]
        fn same_value_twice_in_a_row_should_return_none(value: f64) {
            let mut edge = Edge::with_mode(EdgeMode::Fall);
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
            let mut edge = Edge::with_mode(EdgeMode::Fall);
            edge.update(first);

            let result = edge.update(second);

            assert_eq!(None, result);
        }

        #[test_case(0.5f64)]
        #[test_case(1f64)]
        fn rising_edge_should_return_false(value: f64) {
            let mut edge = Edge::with_mode(EdgeMode::Fall);
            edge.update(0f64);

            let result = edge.update(value);

            assert_eq!(Some(false), result);
        }

        #[test_case(0.5f64)]
        #[test_case(1f64)]
        fn falling_edge_should_return_true(value: f64) {
            let mut edge = Edge::with_mode(EdgeMode::Fall);
            edge.update(value);

            let result = edge.update(0f64);

            assert_eq!(Some(true), result);
        }
    }

    mod mode_both {
        use test_case::test_case;

        use crate::edge::{Edge, EdgeMode};

        #[test]
        fn update_with_zero_should_return_true() {
            let mut edge = Edge::with_mode(EdgeMode::Both);

            let result = edge.update(0f64);

            assert_eq!(Some(true), result);
        }

        #[test]
        fn update_with_value_above_zero_should_return_true() {
            let mut edge = Edge::with_mode(EdgeMode::Both);

            let result = edge.update(1f64);

            assert_eq!(Some(true), result);
        }

        #[test_case(1f64)]
        #[test_case(0f64)]
        fn same_value_twice_in_a_row_should_return_false(value: f64) {
            let mut edge = Edge::with_mode(EdgeMode::Both);
            edge.update(value);

            let result = edge.update(value);

            assert_eq!(Some(false), result);
        }

        #[test_case(0.5f64, 1f64)]
        #[test_case(1f64, 0.5f64)]
        fn returning_two_values_above_zero_after_each_other_should_return_none(
            first: f64,
            second: f64,
        ) {
            let mut edge = Edge::with_mode(EdgeMode::Fall);
            edge.update(first);

            let result = edge.update(second);

            assert_eq!(None, result);
        }

        #[test_case(0.5f64)]
        #[test_case(1f64)]
        fn rising_edge_should_return_false(value: f64) {
            let mut edge = Edge::with_mode(EdgeMode::Fall);
            edge.update(0f64);

            let result = edge.update(value);

            assert_eq!(Some(false), result);
        }

        #[test_case(0.5f64)]
        #[test_case(1f64)]
        fn falling_edge_should_return_true(value: f64) {
            let mut edge = Edge::with_mode(EdgeMode::Fall);
            edge.update(value);

            let result = edge.update(0f64);

            assert_eq!(Some(true), result);
        }
    }
}
