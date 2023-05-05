use crate::{FixtureId, GroupId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct Group {
    pub id: GroupId,
    pub name: String,
    pub fixtures: Vec<FixtureId>,
}
