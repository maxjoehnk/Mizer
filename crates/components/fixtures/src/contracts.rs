use std::ops::DerefMut;
use std::sync::Arc;

use dashmap::DashMap;
use crate::channels::{FixtureChannel, FixtureValue};
use crate::fixture::{Fixture, IFixtureMut};
use crate::FixtureId;

#[cfg_attr(test, mockall::automock)]
pub(crate) trait FixtureController {
    fn write(&self, fixture_id: FixtureId, channel: FixtureChannel, value: FixtureValue);
    fn highlight(&self, fixture_id: FixtureId);
}

impl FixtureController for Arc<DashMap<u32, Fixture>> {
    fn write(&self, fixture_id: FixtureId, channel: FixtureChannel, value: FixtureValue) {
        act_on_fixture(fixture_id, self, |fixture| {
            fixture.write_channel(channel, value, Default::default())
        });
    }

    fn highlight(&self, fixture_id: FixtureId) {
        act_on_fixture(fixture_id, self, |fixture| fixture.highlight());
    }
}

fn act_on_fixture(
    fixture_id: FixtureId,
    fixtures: &Arc<DashMap<u32, Fixture>>,
    act: impl FnOnce(&mut dyn IFixtureMut),
) {
    match fixture_id {
        FixtureId::Fixture(fixture_id) => {
            if let Some(mut fixture) = fixtures.get_mut(&fixture_id) {
                act(fixture.deref_mut());
            }
        }
        FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
            if let Some(mut fixture) = fixtures.get_mut(&fixture_id) {
                if let Some(mut sub_fixture) = fixture.sub_fixture_mut(sub_fixture_id) {
                    act(&mut sub_fixture);
                }
            }
        }
    }
}
