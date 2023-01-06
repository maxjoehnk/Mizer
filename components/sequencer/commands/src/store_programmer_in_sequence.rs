use mizer_commander::{Command, Ref};
use mizer_fixtures::programmer::{ProgrammedEffect, ProgrammerControl};
use mizer_sequencer::{CueControl, CueEffect, Sequence, Sequencer, SequencerValue};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct StoreProgrammerInSequenceCommand {
    pub sequence_id: u32,
    pub cue_id: Option<u32>,
    pub store_mode: StoreMode,
    pub controls: Vec<ProgrammerControl>,
    pub effects: Vec<ProgrammedEffect>,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, Hash, PartialEq, Eq)]
pub enum StoreMode {
    Overwrite,
    Merge,
    AddCue,
}

impl<'a> Command<'a> for StoreProgrammerInSequenceCommand {
    type Dependencies = Ref<Sequencer>;
    type State = Sequence;
    type Result = ();

    fn label(&self) -> String {
        format!("Update Sequence {}", self.sequence_id)
    }

    fn apply(&self, sequencer: &Sequencer) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut previous = None;
        sequencer.update_sequence(self.sequence_id, |sequence| {
            previous = Some(sequence.clone());
            let mut all_fixtures = self
                .controls
                .iter()
                .flat_map(|c| {
                    c.fixtures
                        .get_fixtures()
                        .iter()
                        .flatten()
                        .copied()
                        .collect::<Vec<_>>()
                })
                .collect();
            let cue = if self.store_mode == StoreMode::AddCue || sequence.cues.is_empty() {
                let cue_id = sequence.add_cue();
                sequence.cues.iter_mut().find(|c| c.id == cue_id)
            } else if let Some(cue_id) = self.cue_id {
                sequence.cues.iter_mut().find(|c| c.id == cue_id)
            } else {
                sequence.cues.last_mut()
            }
            .ok_or_else(|| anyhow::anyhow!("Missing cue"))?;
            let cue_channels = self
                .controls
                .clone()
                .into_iter()
                .map(|control| CueControl {
                    control: control.control,
                    fixtures: control.fixtures.clone().into(),
                    value: SequencerValue::Direct(control.value),
                })
                .collect();
            match self.store_mode {
                StoreMode::Merge => {
                    cue.merge(cue_channels);
                    for effect in &self.effects {
                        cue.effects.push(CueEffect {
                            effect: effect.effect_id,
                            fixtures: effect.fixtures.clone(),
                        });
                    }
                }
                StoreMode::Overwrite | StoreMode::AddCue => {
                    cue.controls = cue_channels;
                    cue.effects = self
                        .effects
                        .iter()
                        .map(|effect| CueEffect {
                            effect: effect.effect_id,
                            fixtures: effect.fixtures.clone(),
                        })
                        .collect();
                }
            }
            sequence.fixtures.append(&mut all_fixtures);
            sequence.fixtures.sort();
            sequence.fixtures.dedup();

            Ok(())
        })?;
        let previous = previous.unwrap();

        Ok(((), previous))
    }

    fn revert(&self, sequencer: &Sequencer, previous: Self::State) -> anyhow::Result<()> {
        sequencer.update_sequence(self.sequence_id, |sequence| {
            sequence.fixtures = previous.fixtures;
            sequence.cues = previous.cues;

            Ok(())
        })?;

        Ok(())
    }
}
