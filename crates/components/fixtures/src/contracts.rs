use std::sync::Arc;

use dashmap::DashMap;

use crate::definition::FixtureFaderControl;
use crate::fixture::{Fixture, IFixtureMut};
use crate::{FixtureId, FixturePriority};

#[cfg_attr(test, mockall::automock)]
pub(crate) trait FixtureController {
    fn write(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    );
    fn highlight(&self, fixture_id: FixtureId);
}

impl FixtureController for Arc<DashMap<u32, Fixture>> {
    fn write(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        match fixture_id {
            FixtureId::Fixture(fixture_id) => {
                if let Some(mut fixture) = self.get_mut(&fixture_id) {
                    fixture.write_fader_control(control, value, priority)
                }
            }
            FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                if let Some(mut fixture) = self.get_mut(&fixture_id) {
                    if let Some(mut sub_fixture) = fixture.sub_fixture_mut(sub_fixture_id) {
                        sub_fixture.write_fader_control(control, value, priority)
                    }
                }
            }
        }
    }

    fn highlight(&self, fixture_id: FixtureId) {
        match fixture_id {
            FixtureId::Fixture(fixture_id) => {
                if let Some(mut fixture) = self.get_mut(&fixture_id) {
                    fixture.highlight()
                }
            }
            FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                if let Some(mut fixture) = self.get_mut(&fixture_id) {
                    if let Some(mut sub_fixture) = fixture.sub_fixture_mut(sub_fixture_id) {
                        sub_fixture.highlight()
                    }
                }
            }
        }
    }
}

