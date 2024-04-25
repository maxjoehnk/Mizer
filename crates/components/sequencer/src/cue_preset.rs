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
        presets.get_preset_values(self.preset_id)
            .into_iter()
            .flat_map(|control| control.into_fader_values())
            .flat_map(|(control, value)| {
                self.fixtures.get_fixtures()
                    .into_iter()
                    .flatten()
                    .map(move |fixture_id| (fixture_id, control.clone(), value))
            })
            .collect()
    }
}
