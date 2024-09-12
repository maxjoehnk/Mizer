use crate::state::SequenceState;
use crate::Cue;
use mizer_fixtures::programmer::{PresetId, Presets, ProgrammedPreset};
use mizer_fixtures::selection::BackwardsCompatibleFixtureSelection;
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};
use mizer_fixtures::channels::{FixtureChannel, FixtureValue};

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
    pub(crate) fn values(
        &self,
        _cue: &Cue,
        _state: &SequenceState,
        presets: &Presets,
    ) -> Vec<(FixtureId, FixtureChannel, FixtureValue)> {
        presets
            .get_preset_values(self.preset_id)
            .into_iter()
            .flat_map(|control| control.into_channel_values())
            .flat_map(|value| {
                self.fixtures
                    .get_fixtures()
                    .into_iter()
                    .flatten()
                    .map(move |fixture_id| (fixture_id, value.channel, value.value))
            })
            .collect()
    }
}
