use crate::models::fixtures::*;
use crate::models::programmer::*;
use crate::RuntimeApi;
use futures::stream::{Stream, StreamExt};
use mizer_fixtures::manager::FixtureManager;
use mizer_sequencer::{CueChannel, Sequencer, SequencerValue};
use std::ops::Deref;

#[derive(Clone)]
pub struct ProgrammerHandler<R> {
    fixture_manager: FixtureManager,
    sequencer: Sequencer,
    runtime: R,
}

impl<R: RuntimeApi> ProgrammerHandler<R> {
    pub fn new(fixture_manager: FixtureManager, sequencer: Sequencer, runtime: R) -> Self {
        Self {
            fixture_manager,
            sequencer,
            runtime,
        }
    }

    pub fn state_stream(&self) -> impl Stream<Item = ProgrammerState> + 'static {
        let programmer = self.fixture_manager.get_programmer();
        programmer.bus().map(ProgrammerState::from)
    }

    pub fn write_control(&self, request: WriteControlRequest) {
        let mut programmer = self.fixture_manager.get_programmer();
        for (control, value) in request.as_controls() {
            programmer.write_control(control, value);
        }
    }

    pub fn select_fixtures(&self, fixture_ids: Vec<FixtureId>) {
        log::debug!("select_fixtures {:?}", fixture_ids);
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.select_fixtures(fixture_ids.into_iter().map(|id| id.into()).collect());
    }

    pub fn select_group(&self, group_id: u32) {
        log::debug!("select_group {:?}", group_id);
        if let Some(group) = self.fixture_manager.get_group(group_id) {
            let mut programmer = self.fixture_manager.get_programmer();
            programmer.select_fixtures(group.fixtures.clone());
        }
    }

    pub fn clear(&self) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.clear();
    }

    pub fn highlight(&self, highlight: bool) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.store_highlight(highlight);
    }

    pub fn store(&self, sequence_id: u32, store_mode: StoreRequest_Mode) {
        let programmer = self.fixture_manager.get_programmer();
        let controls = programmer.get_controls();
        self.sequencer.update_sequence(sequence_id, |sequence| {
            let cue = if store_mode == StoreRequest_Mode::AddCue || sequence.cues.is_empty() {
                let cue_id = sequence.add_cue();
                sequence.cues.iter_mut().find(|c| c.id == cue_id)
            } else {
                sequence.cues.last_mut()
            }
            .unwrap();
            let cue_channels = controls
                .into_iter()
                .map(|control| CueChannel {
                    control: control.control,
                    fixtures: control.fixtures,
                    value: SequencerValue::Direct(control.value),
                    fade: None,
                    delay: None,
                })
                .collect();
            if store_mode == StoreRequest_Mode::Merge {
                cue.merge(cue_channels);
            } else {
                cue.channels = cue_channels;
            }
        })
    }

    pub fn get_presets(&self) -> Presets {
        Presets {
            intensities: self.fixture_manager.presets.intensity_presets().into_iter().map(Preset::from).collect(),
            shutter: self.fixture_manager.presets.shutter_presets().into_iter().map(Preset::from).collect(),
            color: self.fixture_manager.presets.color_presets().into_iter().map(Preset::from).collect(),
            position: self.fixture_manager.presets.position_presets().into_iter().map(Preset::from).collect(),
            ..Default::default()
        }
    }

    pub fn call_preset(&self, preset_id: PresetId) {
        log::debug!("call_preset {:?}", preset_id);
        let values = self.fixture_manager.presets.get_preset_values(preset_id.into());
        let mut programmer = self.fixture_manager.get_programmer();
        for (control, value) in values {
            programmer.write_control(control, value);
        }
    }

    pub fn get_groups(&self) -> Groups {
        Groups {
            groups: self.fixture_manager.get_groups().into_iter().map(|group| {
                group.deref().clone().into()
            }).collect(),
            ..Default::default()
        }
    }
}
