use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureId, FixturePriority, GroupId};
use mizer_fixtures::channels::{FixtureChannel, FixtureValue};

#[cfg_attr(test, mockall::automock)]
pub(crate) trait FixtureController {
    fn write_group_control(
        &self,
        group_id: GroupId,
        control: FixtureChannel,
        value: FixtureValue,
        priority: FixturePriority,
    );
    fn write_fixture_control(
        &self,
        fixture_id: FixtureId,
        control: FixtureChannel,
        value: FixtureValue,
        priority: FixturePriority,
    );
    /// Returns a list of fixture id lists
    fn get_group_fixture_ids(&self, group_id: GroupId) -> Vec<Vec<FixtureId>>;
}

impl FixtureController for FixtureManager {
    fn write_group_control(
        &self,
        group_id: GroupId,
        channel: FixtureChannel,
        value: FixtureValue,
        priority: FixturePriority,
    ) {
        self.write_group_control(group_id, channel, value, priority);
    }

    fn write_fixture_control(
        &self,
        fixture_id: FixtureId,
        channel: FixtureChannel,
        value: FixtureValue,
        priority: FixturePriority,
    ) {
        self.write_fixture_control(fixture_id, channel, value, priority);
    }

    fn get_group_fixture_ids(&self, group_id: GroupId) -> Vec<Vec<FixtureId>> {
        self.get_group(group_id)
            .map(|g| g.fixtures())
            .unwrap_or_default()
    }
}
