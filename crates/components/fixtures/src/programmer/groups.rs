use crate::{FixtureId, GroupId};
use serde::{Deserialize, Serialize};
use crate::selection::{BackwardsCompatibleFixtureSelection};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct Group {
    pub id: GroupId,
    pub name: String,
    #[serde(alias = "fixtures")]
    pub selection: BackwardsCompatibleFixtureSelection,
}

impl Group {
    pub fn fixtures(&self) -> Vec<Vec<FixtureId>> {
        self.selection.get_fixtures()
    }
}
