use mizer_commander::{Query, Ref};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Preset, PresetId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListShutterPresetsQuery;

impl<'a> Query<'a> for ListShutterPresetsQuery {
    type Dependencies = Ref<FixtureManager>;
    type Result = Vec<(PresetId, Preset<f64>)>;

    fn query(&self, fixture_manager: &FixtureManager) -> anyhow::Result<Self::Result> {
        Ok(fixture_manager.presets.shutter_presets())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
