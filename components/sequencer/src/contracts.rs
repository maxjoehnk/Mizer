use std::time::Instant;
use mizer_fixtures::definition::FixtureControl;
use mizer_fixtures::FixtureId;
use mizer_fixtures::manager::FixtureManager;

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
    fn write(&self, fixture_id: FixtureId, control: FixtureControl, value: f64);
}

impl FixtureController for FixtureManager {
    fn write(&self, fixture_id: FixtureId, control: FixtureControl, value: f64) {
        self.write_fixture_control(fixture_id, control, value);
    }
}
