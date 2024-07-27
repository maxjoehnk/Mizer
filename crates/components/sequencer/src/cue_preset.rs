use serde::{Deserialize, Serialize};
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::FixtureId;
use mizer_fixtures::programmer::{PresetId, Presets, ProgrammedPreset};
use mizer_fixtures::selection::BackwardsCompatibleFixtureSelection;
use crate::Cue;
use crate::state::SequenceState;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct CuePreset {
    pub preset_id: PresetId,
    pub fixtures: BackwardsCompatibleFixtureSelection,
}

impl From<ProgrammedPreset> for CuePreset {
    fn from(value: ProgrammedPreset) -> Self {
        Self {
            preset_id: value.preset_id,
            fixtures: value.fixtures.into(),
        }
    }
}

impl CuePreset {
    pub(crate) fn values(&self, _cue: &Cue, _state: &SequenceState, presets: &Presets) -> Vec<(FixtureId, FixtureFaderControl, f64)> {
        let fixture_ids = self.fixtures.get_fixtures()
                .into_iter()
                .flatten()
                .collect::<Vec<_>>();
        presets.get_values(self.preset_id, &fixture_ids)
            .into_iter()
            .flat_map(|(fixture_ids, fader_controls)| {
                fixture_ids
                    .into_iter()
                    .map(move |(fixture_id)| (fixture_id, fader_controls.clone()))
            })
            .flat_map(|(fixture, controls)| {
                controls.into_iter()
                    .flat_map(|control| control.into_fader_values())
                    .map(move |(control, value)| (fixture, control, value))
            })
            .collect()
    }
}
