use crate::{get_cue, get_effect};
use mizer_commander::{Command, Ref};
use mizer_sequencer::{Sequencer, SequencerTime};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateCueEffectOffsetCommand {
    pub sequence_id: u32,
    pub cue_id: u32,
    pub effect_id: u32,
    pub time: Option<SequencerTime>,
}

impl<'a> Command<'a> for UpdateCueEffectOffsetCommand {
    type Dependencies = Ref<Sequencer>;
    type State = Option<SequencerTime>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Update Cue Effect Offset '{}.{}' to '{:?}'",
            self.sequence_id, self.cue_id, self.time
        )
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            let effect = get_effect(cue, self.effect_id)?;
            previous = Some(effect.effect_offset);
            effect.effect_offset = self.time;

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, effect_offset: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            let cue = get_cue(sequence, self.cue_id)?;
            let effect = get_effect(cue, self.effect_id)?;
            effect.effect_offset = effect_offset;

            Ok(())
        })?;

        Ok(())
    }
}
