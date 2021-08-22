use crate::RuntimeApi;
use mizer_fixtures::manager::FixtureManager;
use crate::models::programmer::*;
use mizer_sequencer::{Sequencer, Cue, CueChannel, SequencerValue};

#[derive(Clone)]
pub struct ProgrammerHandler<R> {
    fixture_manager: FixtureManager,
    sequencer: Sequencer,
    runtime: R,
}

impl<R: RuntimeApi> ProgrammerHandler<R> {
    pub fn new(
        fixture_manager: FixtureManager,
        sequencer: Sequencer,
        runtime: R,
    ) -> Self {
        Self {
            fixture_manager,
            sequencer,
            runtime,
        }
    }

    pub fn write_channels(&self, request: WriteChannelsRequest) {
        let value = request.value.unwrap();
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.write_channels(request.channel, value.into());
    }

    pub fn select_fixtures(&self, fixture_ids: Vec<u32>) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.select_fixtures(fixture_ids);
    }

    pub fn clear(&self) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.clear();
    }

    pub fn highlight(&self, highlight: bool) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.highlight = highlight;
    }

    pub fn store(&self, sequence_id: u32, store_mode: StoreRequest_Mode) {
        let mut programmer = self.fixture_manager.get_programmer();
        let channels = programmer.get_channels();
        self.sequencer.update_sequence(sequence_id, |sequence| {
            let cue = if store_mode == StoreRequest_Mode::AddCue || sequence.cues.is_empty() {
                let cue_id = sequence.add_cue();
                sequence.cues.iter_mut().find(|c| c.id == cue_id)
            }else {
                sequence.cues.last_mut()
            }.unwrap();
            let cue_channels = channels.into_iter()
                .map(|channel| CueChannel {
                    channel: channel.channel,
                    fixtures: channel.fixtures,
                    value: SequencerValue::Direct(channel.value),
                    fade: None,
                    delay: None,
                })
                .collect();
            if store_mode == StoreRequest_Mode::Merge {
                cue.merge(cue_channels);
            }else {
                cue.channels = cue_channels;
            }
        })
    }
}
