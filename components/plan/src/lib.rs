use mizer_fixtures::FixtureId;
use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use std::sync::Arc;

pub mod commands;

pub type PlanStorage = Arc<NonEmptyPinboard<Vec<Plan>>>;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Plan {
    pub name: String,
    pub fixtures: Vec<FixturePosition>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct FixturePosition {
    pub fixture: FixtureId,
    pub x: i32,
    pub y: i32,
}
