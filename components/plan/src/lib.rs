use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Plan {
    pub name: String,
    pub fixtures: Vec<FixturePosition>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixturePosition {
    pub fixture: FixtureId,
    pub x: u32,
    pub y: u32,
}
