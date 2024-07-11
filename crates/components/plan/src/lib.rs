use mizer_fixtures::FixtureId;
use mizer_util::Base64Image;
pub use module::PlansModule;
use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use std::fmt::{Display, Formatter};
use std::sync::Arc;
use uuid::Uuid;

pub mod commands;
mod debug_ui_pane;
mod module;
pub mod queries;
mod project_handler;

pub type PlanStorage = Arc<NonEmptyPinboard<Vec<Plan>>>;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Plan {
    pub name: String,
    pub fixtures: Vec<FixturePosition>,
    #[serde(default)]
    pub screens: Vec<PlanScreen>,
    #[serde(default)]
    pub images: Vec<PlanImage>,
}

impl Plan {
    pub fn new(name: String) -> Self {
        Self {
            name,
            fixtures: Default::default(),
            screens: Default::default(),
            images: Default::default(),
        }
    }
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub struct FixturePosition {
    pub fixture: FixtureId,
    pub x: f64,
    pub y: f64,
    #[serde(default = "default_size")]
    pub width: f64,
    #[serde(default = "default_size")]
    pub height: f64,
}

fn default_size() -> f64 {
    1.0
}

#[derive(Default, Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq, PartialOrd, Ord)]
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

impl ScreenId {
    pub fn next(self) -> Self {
        Self(self.0 + 1)
    }
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub struct PlanScreen {
    #[serde(rename = "id")]
    pub id: ScreenId,
    pub x: f64,
    pub y: f64,
    pub width: f64,
    pub height: f64,
}

impl PlanScreen {
    pub fn contains_fixture(&self, fixture: &FixturePosition) -> bool {
        let screen_rect = (self.x, self.y, self.x + self.width, self.y + self.height);
        let fixture_rect = (
            fixture.x,
            fixture.y,
            fixture.x + fixture.width,
            fixture.y + fixture.height,
        );

        let x_overlap = fixture_rect.0 <= screen_rect.2 && fixture_rect.2 >= screen_rect.0;
        let y_overlap = fixture_rect.1 <= screen_rect.3 && fixture_rect.3 >= screen_rect.1;

        x_overlap && y_overlap
    }

    pub fn translate_position(&self, fixture: &FixturePosition) -> (f64, f64) {
        let x = fixture.x - self.x;
        let y = fixture.y - self.y;

        (x, y)
    }
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct PlanImage {
    pub id: ImageId,
    pub x: f64,
    pub y: f64,
    pub width: f64,
    pub height: f64,
    pub transparency: f64,
    pub data: Base64Image,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
#[serde(transparent)]
#[repr(transparent)]
pub struct ImageId(Uuid);

impl ImageId {
    pub fn new() -> Self {
        Self(Uuid::new_v4())
    }
}

impl Display for ImageId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0.as_hyphenated())
    }
}

impl TryFrom<String> for ImageId {
    type Error = uuid::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        let uuid = Uuid::parse_str(&value)?;

        Ok(Self(uuid))
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
            id: ScreenId(0),
            x: screen_x as f64,
            y: screen_y as f64,
            width: width as f64,
            height: height as f64,
        };
        let fixture = FixturePosition {
            fixture: FixtureId::Fixture(0),
            x: fixture_x as f64,
            y: fixture_y as f64,
            width: 1.0,
            height: 1.0,
        };

        let result = screen.contains_fixture(&fixture);

        assert!(result);
    }

    #[test_case(0, 0, 1, 1, 2, 2)]
    #[test_case(0, 0, 1, 1, -2, -2; "negatives")]
    #[test_case(2, 2, 4, 4, 0, 3)]
    #[test_case(2, 2, 4, 4, 3, 0)]
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
            id: ScreenId(0),
            x: screen_x as f64,
            y: screen_y as f64,
            width: width as f64,
            height: height as f64,
        };
        let fixture = FixturePosition {
            fixture: FixtureId::Fixture(0),
            x: fixture_x as f64,
            y: fixture_y as f64,
            width: 1.0,
            height: 1.0,
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
            id: ScreenId(0),
            x: screen_x as f64,
            y: screen_y as f64,
            width: u32::MAX as f64,
            height: u32::MAX as f64,
        };
        let fixture = FixturePosition {
            fixture: FixtureId::Fixture(0),
            x: fixture_x as f64,
            y: fixture_y as f64,
            width: 1.0,
            height: 1.0,
        };

        let (x, y) = screen.translate_position(&fixture);

        assert_eq!(expected_x as f64, x);
        assert_eq!(expected_y as f64, y);
    }
}
