use std::time::Instant;

use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureId, FixturePriority};
use mizer_fixtures::channels::{FixtureChannel, FixtureValue};

#[cfg_attr(test, mockall::automock)]
pub(crate) trait Clock {
    fn now(&self) -> Instant;
}

#[derive(Copy, Clone, Default)]
pub(crate) struct StdClock;

impl Clock for StdClock {
    fn now(&self) -> Instant {
        Instant::now()
    }
}

#[cfg_attr(test, mockall::automock)]
pub(crate) trait FixtureController {
    fn write(
        &self,
        fixture_id: FixtureId,
        control: FixtureChannel,
        value: FixtureValue,
        priority: FixturePriority,
    );
}

impl FixtureController for FixtureManager {
    fn write(
        &self,
        fixture_id: FixtureId,
        control: FixtureChannel,
        value: FixtureValue,
        priority: FixturePriority,
    ) {
        self.write_fixture_control(fixture_id, control, value, priority);
    }
}
