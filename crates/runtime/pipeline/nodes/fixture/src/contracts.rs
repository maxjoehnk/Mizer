use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureId, FixturePriority, GroupId};

#[cfg_attr(test, mockall::automock)]
pub(crate) trait FixtureController {
    fn write_group_control(
        &self,
        group_id: GroupId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    );
    fn write_fixture_control(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    );
    /// Returns a list of fixture id lists
    fn get_group_fixture_ids(&self, group_id: GroupId) -> Vec<Vec<FixtureId>>;
}

impl FixtureController for FixtureManager {
    fn write_group_control(
        &self,
        group_id: GroupId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        self.write_group_control(group_id, control, value, priority);
    }

    fn write_fixture_control(
        &self,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        self.write_fixture_control(fixture_id, control, value, priority);
    }

    fn get_group_fixture_ids(&self, group_id: GroupId) -> Vec<Vec<FixtureId>> {
        self.get_group(group_id)
            .map(|g| g.fixtures())
            .unwrap_or_default()
    }
}
