use std::error::Error;
use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, Ord, PartialOrd, Eq, PartialEq, Hash, Serialize, Deserialize)]
#[repr(u8)]
pub enum FixturePriority {
    /**
     * Programmer always overrides everything else
     */
    Programmer = 10,
    /**
     * Highest takes precedence
     */
    HTP = 1,
    /**
     * Latest takes precedence
     */
    LTP(LTPPriority) = 0,
}

// We ignore the Programmer priority here as it is not supposed to be exposed to the user
impl Sequence for FixturePriority {
    const CARDINALITY: usize = LTPPriority::CARDINALITY + 1;

    fn next(&self) -> Option<Self> {
        match self {
            Self::Programmer => None,
            Self::HTP => Some(Self::LTP(LTPPriority::Highest)),
            Self::LTP(LTPPriority::Highest) => Some(Self::LTP(LTPPriority::High)),
            Self::LTP(LTPPriority::High) => Some(Self::LTP(LTPPriority::Normal)),
            Self::LTP(LTPPriority::Normal) => Some(Self::LTP(LTPPriority::Low)),
            Self::LTP(LTPPriority::Low) => Some(Self::LTP(LTPPriority::Lowest)),
            Self::LTP(LTPPriority::Lowest) => None,
        }
    }

    fn previous(&self) -> Option<Self> {
        match self {
            Self::Programmer => None,
            Self::HTP => None,
            Self::LTP(LTPPriority::Highest) => Some(Self::HTP),
            Self::LTP(LTPPriority::High) => Some(Self::LTP(LTPPriority::Highest)),
            Self::LTP(LTPPriority::Normal) => Some(Self::LTP(LTPPriority::High)),
            Self::LTP(LTPPriority::Low) => Some(Self::LTP(LTPPriority::Normal)),
            Self::LTP(LTPPriority::Lowest) => Some(Self::LTP(LTPPriority::Low)),
        }
    }

    fn first() -> Option<Self> {
        Some(Self::HTP)
    }

    fn last() -> Option<Self> {
        Some(Self::LTP(LTPPriority::Lowest))
    }
}

impl FixturePriority {
    pub const HIGHEST: Self = Self::LTP(LTPPriority::Highest);
    pub const HIGH: Self = Self::LTP(LTPPriority::High);
    pub const LOW: Self = Self::LTP(LTPPriority::Low);
    pub const LOWEST: Self = Self::LTP(LTPPriority::Lowest);
    
    pub fn is_programmer(&self) -> bool {
        matches!(self, Self::Programmer)
    }
    
    pub fn is_ltp(&self) -> bool {
        matches!(self, Self::LTP(_))
    }
    
    pub fn is_htp(&self) -> bool {
        matches!(self, Self::HTP)
    }
}

impl Default for FixturePriority {
    fn default() -> Self {
        Self::LTP(Default::default())
    }
}

#[derive(
    Debug,
    Clone,
    Copy,
    Default,
    PartialEq,
    Eq,
    PartialOrd,
    Ord,
    Hash,
    Deserialize,
    Serialize,
    Sequence,
)]
#[repr(u8)]
pub enum LTPPriority {
    Highest = 4,
    High = 3,
    #[default]
    Normal = 2,
    Low = 1,
    Lowest = 0,
}

impl From<LTPPriority> for FixturePriority {
    fn from(level: LTPPriority) -> Self {
        Self::LTP(level)
    }
}

impl From<FixturePriority> for u8 {
    fn from(value: FixturePriority) -> Self {
        match value {
            FixturePriority::Programmer => 10,
            FixturePriority::HTP => 5,
            FixturePriority::LTP(LTPPriority::Highest) => 4,
            FixturePriority::LTP(LTPPriority::High) => 3,
            FixturePriority::LTP(LTPPriority::Normal) => 2,
            FixturePriority::LTP(LTPPriority::Low) => 1,
            FixturePriority::LTP(LTPPriority::Lowest) => 0,
        }
    }
}

impl TryFrom<u8> for FixturePriority {
    type Error = InvalidFixturePriorityError;

    fn try_from(value: u8) -> Result<Self, Self::Error> {
        match value {
            10 => Ok(Self::Programmer),
            5 => Ok(Self::HTP),
            4 => Ok(Self::LTP(LTPPriority::Highest)),
            3 => Ok(Self::LTP(LTPPriority::High)),
            2 => Ok(Self::LTP(LTPPriority::Normal)),
            1 => Ok(Self::LTP(LTPPriority::Low)),
            0 => Ok(Self::LTP(LTPPriority::Lowest)),
            prio => Err(InvalidFixturePriorityError(prio)),
        }
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub struct InvalidFixturePriorityError(u8);

impl Display for InvalidFixturePriorityError {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "Invalid fixture priority: {}", self.0)
    }
}

impl Error for InvalidFixturePriorityError {}

impl Display for FixturePriority {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Programmer => write!(f, "Programmer"),
            Self::HTP => write!(f, "HTP"),
            Self::LTP(level) => write!(f, "LTP {:?}", level),
        }
    }
}

#[cfg(test)]
mod tests {
    use spectral::prelude::*;
    use test_case::test_case;

    use super::*;

    #[test_case(FixturePriority::HTP, FixturePriority::LOWEST)]
    #[test_case(FixturePriority::HTP, FixturePriority::HIGHEST)]
    #[test_case(FixturePriority::HIGHEST, FixturePriority::LOWEST)]
    #[test_case(FixturePriority::HIGHEST, FixturePriority::HIGH)]
    #[test_case(FixturePriority::HIGH, FixturePriority::LTP(LTPPriority::Normal))]
    #[test_case(FixturePriority::LTP(LTPPriority::Normal), FixturePriority::LOW)]
    #[test_case(FixturePriority::LOW, FixturePriority::LOWEST)]
    fn fixture_priority_should_implement_ord(a: FixturePriority, b: FixturePriority) {
        assert_that(&a).is_greater_than(&b);
    }

    #[test_case(FixturePriority::HTP, 5)]
    #[test_case(FixturePriority::HIGHEST, 4)]
    #[test_case(FixturePriority::HIGH, 3)]
    #[test_case(FixturePriority::default(), 2)]
    #[test_case(FixturePriority::LOW, 1)]
    #[test_case(FixturePriority::LOWEST, 0)]
    fn fixture_priority_should_convert_to_u8(priority: FixturePriority, expected: u8) {
        let result = priority.into();

        assert_that(&result).is_equal_to(expected);
    }

    #[test_case(FixturePriority::HTP, 5)]
    #[test_case(FixturePriority::HIGHEST, 4)]
    #[test_case(FixturePriority::HIGH, 3)]
    #[test_case(FixturePriority::default(), 2)]
    #[test_case(FixturePriority::LOW, 1)]
    #[test_case(FixturePriority::LOWEST, 0)]
    fn fixture_priority_should_convert_from_u8(expected: FixturePriority, value: u8) {
        let result = FixturePriority::try_from(value);

        assert_that(&result).is_equal_to(Ok(expected));
    }
}
