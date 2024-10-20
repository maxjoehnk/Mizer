use crate::selection::BackwardsCompatibleFixtureSelection;
use crate::{FixtureId, GroupId};
use serde::{Deserialize, Serialize};
use mizer_appearance::Appearance;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Group {
    pub id: GroupId,
    pub name: String,
    #[serde(alias = "fixtures")]
    pub selection: BackwardsCompatibleFixtureSelection,
    #[serde(default)]
    pub appearance: Appearance,
}

impl Group {
    pub fn fixtures(&self) -> Vec<Vec<FixtureId>> {
        self.selection.get_fixtures()
    }
}
