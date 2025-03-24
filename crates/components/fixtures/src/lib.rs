use std::collections::HashMap;
use std::fmt::{Display, Formatter};
use std::ops::Add;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};

use crate::fixture::Fixture;
pub use crate::module::*;
pub use crate::priority::*;
use crate::programmer::Color;

mod contracts;
pub mod definition;
pub mod fixture;
pub mod library;
pub mod manager;
mod processor;
mod sub_fixture;
pub mod ui_handlers;
// TODO: should probably find a better name
mod color_mixer;
mod debug_ui_pane;
mod module;
mod priority;
pub mod programmer;
pub mod selection;

#[derive(Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash)]
#[serde(untagged)]
pub enum FixtureId {
    Fixture(u32),
    SubFixture(u32, u32),
}

impl Display for FixtureId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            FixtureId::Fixture(id) => write!(f, "F.{id}"),
            FixtureId::SubFixture(pid, cid) => write!(f, "F.{pid}.{cid}"),
        }
    }
}

impl From<u32> for FixtureId {
    fn from(id: u32) -> Self {
        Self::Fixture(id)
    }
}

impl From<(u32, u32)> for FixtureId {
    fn from((fixture_id, child_id): (u32, u32)) -> Self {
        Self::SubFixture(fixture_id, child_id)
    }
}

impl Add<u32> for FixtureId {
    type Output = Self;

    fn add(self, rhs: u32) -> Self::Output {
        match self {
            FixtureId::Fixture(id) => FixtureId::Fixture(id + rhs),
            FixtureId::SubFixture(pid, cid) => FixtureId::SubFixture(pid, cid + 1),
        }
    }
}

#[derive(
    Default, Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash,
)]
#[repr(transparent)]
#[serde(transparent)]
pub struct GroupId(pub u32);

impl GroupId {
    pub fn next(&self) -> GroupId {
        Self(self.0 + 1)
    }
}

impl Display for GroupId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "G.{}", self.0)
    }
}

impl From<u32> for GroupId {
    fn from(id: u32) -> Self {
        Self(id)
    }
}

impl From<GroupId> for u32 {
    fn from(group_id: GroupId) -> Self {
        group_id.0
    }
}

#[derive(Clone)]
pub struct FixtureStates(Arc<NonEmptyPinboard<HashMap<FixtureId, FixtureState>>>);

impl Default for FixtureStates {
    fn default() -> Self {
        Self(Arc::new(NonEmptyPinboard::new(HashMap::new())))
    }
}

impl FixtureStates {
    pub(crate) fn add_fixture(&self, fixture: &Fixture) {
        let mut states = self.0.read();
        states.insert(FixtureId::Fixture(fixture.id), Default::default());
        for sub_fixture in fixture.current_mode.sub_fixtures.iter() {
            states.insert(
                FixtureId::SubFixture(fixture.id, sub_fixture.id),
                Default::default(),
            );
        }
        self.0.set(states);
    }

    pub(crate) fn remove_fixture(&self, fixture: &Fixture) {
        let mut states = self.0.read();
        states.remove(&FixtureId::Fixture(fixture.id));
        for sub_fixture in fixture.current_mode.sub_fixtures.iter() {
            states.remove(&FixtureId::SubFixture(fixture.id, sub_fixture.id));
        }
        self.0.set(states);
    }

    pub fn clear(&self) {
        self.0.set(Default::default());
    }

    pub fn read(&self) -> HashMap<FixtureId, FixtureState> {
        profiling::scope!("FixtureStates::read");
        self.0.read()
    }

    pub(crate) fn write(&self, state: HashMap<FixtureId, FixtureState>) {
        profiling::scope!("FixtureStates::write");
        self.0.set(state);
    }
}

#[derive(Clone, Copy, Debug, Default)]
pub struct FixtureState {
    pub brightness: Option<f64>,
    pub color: Option<Color>,
}

#[derive(Debug, Clone, Copy, Default)]
pub struct RgbColor {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
}
