use std::time::Instant;

use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::manager::{FadeTimings, FixtureManager, FixtureValueSource};
use mizer_fixtures::{FixtureId, FixturePriority};

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
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
        fade_timings: FadeTimings,
        source: FixtureValueSource,
    );
}

impl FixtureController for FixtureManager {
    fn write(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
        fade_timings: FadeTimings,
        source: FixtureValueSource,
    ) {
        self.write_fixture_control_with_timings(fixture_id, control, value, priority, Some(source), fade_timings);
    }
}
