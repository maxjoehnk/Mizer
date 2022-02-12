use crate::FixtureId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Group {
    pub id: u32,
    pub name: String,
    pub fixtures: Vec<FixtureId>,
}
