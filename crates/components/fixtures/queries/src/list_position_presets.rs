use mizer_commander::{Query, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Position, Preset, PresetId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListPositionPresetsQuery;

impl<'a> Query<'a> for ListPositionPresetsQuery {
    type Dependencies = Ref<FixtureManager>;
    type Result = Vec<(PresetId, Preset<Position>)>;

    fn query(&self, fixture_manager: &FixtureManager) -> anyhow::Result<Self::Result> {
        Ok(fixture_manager.presets.position_presets())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
