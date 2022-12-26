use mizer_fixtures::FixtureId;
use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use std::sync::Arc;

pub mod commands;

pub type PlanStorage = Arc<NonEmptyPinboard<Vec<Plan>>>;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct Plan {
    pub name: String,
    pub fixtures: Vec<FixturePosition>,
    #[serde(default)]
    pub screens: Vec<PlanScreen>,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub struct FixturePosition {
    pub fixture: FixtureId,
    pub x: i32,
    pub y: i32,
    #[serde(default = "default_size")]
    pub width: u32,
    #[serde(default = "default_size")]
    pub height: u32,
}

fn default_size() -> u32 {
    1
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
#[repr(transparent)]
pub struct ScreenId(pub u32);

impl From<u32> for ScreenId {
    fn from(screen_id: u32) -> Self {
        Self(screen_id)
    }
}

impl From<ScreenId> for u32 {
    fn from(screen_id: ScreenId) -> Self {
        screen_id.0
    }
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub struct PlanScreen {
    #[serde(rename = "id")]
    pub screen_id: ScreenId,
    pub x: i32,
    pub y: i32,
    pub width: u32,
    pub height: u32,
}

impl PlanScreen {
    pub fn contains_fixture(&self, fixture: &FixturePosition) -> bool {
        let x_1 = self.x;
        let x_2 = self.x + (self.width as i32);
        let y_1 = self.y;
        let y_2 = self.y + (self.height as i32);

        x_1 <= fixture.x && fixture.x <= x_2 && y_1 <= fixture.y && fixture.y <= y_2
    }

    pub fn translate_position(&self, fixture: &FixturePosition) -> (usize, usize) {
        let x = fixture.x - self.x;
        let y = fixture.y - self.y;

        (x as usize, y as usize)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use test_case::test_case;

    #[test_case(0, 0, 1, 1, 0, 0)]
    #[test_case(0, 0, 1, 1, 1, 1)]
    #[test_case(2, 2, 4, 4, 2, 4)]
    #[test_case(2, 2, 4, 4, 4, 2)]
    fn contains_fixture_should_return_true_when_fixture_is_in_screen(
        screen_x: i32,
        screen_y: i32,
        width: u32,
        height: u32,
        fixture_x: i32,
        fixture_y: i32,
    ) {
        let screen = PlanScreen {
            screen_id: ScreenId(0),
            x: screen_x,
            y: screen_y,
            width,
            height,
        };
        let fixture = FixturePosition {
            fixture: FixtureId::Fixture(0),
            x: fixture_x,
            y: fixture_y,
            width: 1,
            height: 1,
        };

        let result = screen.contains_fixture(&fixture);

        assert!(result);
    }

    #[test_case(0, 0, 1, 1, 2, 2)]
    #[test_case(0, 0, 1, 1, -1, -1)]
    #[test_case(2, 2, 4, 4, 1, 4)]
    #[test_case(2, 2, 4, 4, 4, 1)]
    #[test_case(2, 2, 4, 4, 2, 7)]
    #[test_case(2, 2, 4, 4, 7, 2)]
    fn contains_fixture_should_return_false_when_fixture_is_not_in_screen(
        screen_x: i32,
        screen_y: i32,
        width: u32,
        height: u32,
        fixture_x: i32,
        fixture_y: i32,
    ) {
        let screen = PlanScreen {
            screen_id: ScreenId(0),
            x: screen_x,
            y: screen_y,
            width,
            height,
        };
        let fixture = FixturePosition {
            fixture: FixtureId::Fixture(0),
            x: fixture_x,
            y: fixture_y,
            width: 1,
            height: 1,
        };

        let result = screen.contains_fixture(&fixture);

        assert!(!result);
    }

    #[test_case(0, 0, 0, 0, 0, 0)]
    #[test_case(1, 2, 3, 4, 2, 2)]
    #[test_case(2, 2, 3, 5, 1, 3)]
    fn translate_position_should_translate_fixture_position_to_screen_space(
        screen_x: i32,
        screen_y: i32,
        fixture_x: i32,
        fixture_y: i32,
        expected_x: usize,
        expected_y: usize,
    ) {
        let screen = PlanScreen {
            screen_id: ScreenId(0),
            x: screen_x,
            y: screen_y,
            width: u32::MAX,
            height: u32::MAX,
        };
        let fixture = FixturePosition {
            fixture: FixtureId::Fixture(0),
            x: fixture_x,
            y: fixture_y,
            width: 1,
            height: 1,
        };

        let (x, y) = screen.translate_position(&fixture);

        assert_eq!(expected_x, x);
        assert_eq!(expected_y, y);
    }
}
