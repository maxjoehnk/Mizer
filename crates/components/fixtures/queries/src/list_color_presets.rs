use mizer_commander::{Query, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Color, Preset, PresetId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListColorPresetsQuery;

impl<'a> Query<'a> for ListColorPresetsQuery {
    type Dependencies = Ref<FixtureManager>;
    type Result = Vec<(PresetId, Preset<Color>)>;

    fn query(&self, fixture_manager: &FixtureManager) -> anyhow::Result<Self::Result> {
        Ok(fixture_manager.presets.color_presets())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
