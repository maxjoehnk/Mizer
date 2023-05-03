use mizer_command_executor::*;
use mizer_sequencer::{Sequencer, SequencerTime, SequencerValue, SequencerView};

use crate::models::sequencer::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct SequencerHandler<R: RuntimeApi> {
    sequencer: Sequencer,
    runtime: R,
}

impl<R: RuntimeApi> SequencerHandler<R> {
    pub fn new(sequencer: Sequencer, runtime: R) -> Self {
        Self { sequencer, runtime }
    }

    #[tracing::instrument(skip(self))]
    pub fn get_sequences(&self) -> Sequences {
        let sequences = self.sequencer.sequences();
        let sequences = sequences.into_iter().map(Sequence::from).collect();

        Sequences {
            sequences,
            ..Default::default()
        }
    }

    #[tracing::instrument(skip(self))]
    pub fn get_sequence(&self, sequence_id: u32) -> Option<Sequence> {
        self.sequencer.sequence(sequence_id).map(Sequence::from)
    }

    #[tracing::instrument(skip(self))]
    pub fn add_sequence(&self) -> Sequence {
        let sequence = self.runtime.run_command(AddSequenceCommand {}).unwrap();

        sequence.into()
    }

    #[tracing::instrument(skip(self))]
    pub fn duplicate_sequence(&self, sequence: u32) -> Sequence {
        let sequence = self
            .runtime
            .run_command(DuplicateSequenceCommand {
                sequence_id: sequence,
            })
            .unwrap();

        sequence.into()
    }

    #[tracing::instrument(skip(self))]
    pub fn sequence_go(&self, sequence: u32) {
        self.sequencer.sequence_go(sequence);
    }

    #[tracing::instrument(skip(self))]
    pub fn sequence_stop(&self, sequence: u32) {
        self.sequencer.sequence_stop(sequence);
    }

    #[tracing::instrument(skip(self))]
    pub fn delete_sequence(&self, sequence: u32) -> anyhow::Result<()> {
        self.runtime.run_command(DeleteSequenceCommand {
            sequence_id: sequence,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn update_cue_trigger(&self, request: CueTriggerRequest) {
        self.runtime
            .run_command(UpdateCueTriggerCommand {
                sequence_id: request.sequence,
                cue_id: request.cue,
                trigger: request.trigger.unwrap().into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_cue_trigger_time(&self, request: CueTriggerTimeRequest) {
        self.runtime
            .run_command(UpdateCueTriggerTimeCommand {
                sequence_id: request.sequence,
                cue_id: request.cue,
                trigger_time: request.time.into_option().map(SequencerTime::from),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_cue_effect_offset_time(&self, request: CueEffectOffsetTimeRequest) {
        self.runtime
            .run_command(UpdateCueEffectOffsetCommand {
                sequence_id: request.sequence,
                cue_id: request.cue,
                effect_id: request.effect,
                time: request.time.map(SequencerTime::Beats),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_cue_name(&self, request: CueNameRequest) {
        self.runtime
            .run_command(RenameCueCommand {
                sequence_id: request.sequence,
                cue_id: request.cue,
                name: request.name,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_cue_value(&self, request: CueValueRequest) {
        self.runtime
            .run_command(UpdateCueValueCommand {
                sequence_id: request.sequence_id,
                cue_id: request.cue_id,
                control_index: request.control_index,
                value: request.value.unwrap().into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_control_fade_time(&self, request: CueTimingRequest) {
        self.runtime
            .run_command(UpdateControlFadeTimeCommand {
                sequence_id: request.sequence_id,
                cue_id: request.cue_id,
                fade_time: request
                    .time
                    .into_option()
                    .and_then(Option::<SequencerValue<SequencerTime>>::from),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_control_delay_time(&self, request: CueTimingRequest) {
        self.runtime
            .run_command(UpdateControlDelayTimeCommand {
                sequence_id: request.sequence_id,
                cue_id: request.cue_id,
                delay_time: request
                    .time
                    .into_option()
                    .and_then(Option::<SequencerValue<SequencerTime>>::from),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_sequence_wrap_around(&self, request: SequenceWrapAroundRequest) {
        self.runtime
            .run_command(UpdateSequenceWrapAroundCommand {
                sequence_id: request.sequence,
                wrap_around: request.wrap_around,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_sequence_stop_on_last_cue(&self, request: SequenceStopOnLastCueRequest) {
        self.runtime
            .run_command(UpdateSequenceStopOnLastCueCommand {
                sequence_id: request.sequence,
                stop_on_last_cue: request.stop_on_last_cue,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn update_sequence_name(&self, request: SequenceNameRequest) {
        self.runtime
            .run_command(RenameSequenceCommand {
                sequence_id: request.sequence,
                name: request.name,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn sequencer_view(&self) -> SequencerView {
        self.sequencer.get_sequencer_view()
    }
}
