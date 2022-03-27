use crate::models::fixtures::*;
use crate::models::programmer::*;
use crate::RuntimeApi;
use futures::stream::{Stream, StreamExt};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::ProgrammerView;
use mizer_sequencer::{CueControl, Sequencer, SequencerValue};
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
        let control = request.as_controls();
        programmer.write_control(control);
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
            programmer.select_group(&group);
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
            let mut fixtures = controls.iter().flat_map(|c| c.fixtures.clone()).collect();
            let cue = if store_mode == StoreRequest_Mode::AddCue || sequence.cues.is_empty() {
                let cue_id = sequence.add_cue();
                sequence.cues.iter_mut().find(|c| c.id == cue_id)
            } else {
                sequence.cues.last_mut()
            }
            .unwrap();
            let cue_channels = controls
                .into_iter()
                .map(|control| CueControl {
                    control: control.control,
                    fixtures: control.fixtures.clone(),
                    value: SequencerValue::Direct(control.value),
                })
                .collect();
            if store_mode == StoreRequest_Mode::Merge {
                cue.merge(cue_channels);
            } else {
                cue.controls = cue_channels;
            }
            sequence.fixtures.append(&mut fixtures);
            sequence.fixtures.sort();
            sequence.fixtures.dedup();
        })
    }

    pub fn get_presets(&self) -> Presets {
        Presets {
            intensities: self
                .fixture_manager
                .presets
                .intensity_presets()
                .into_iter()
                .map(Preset::from)
                .collect(),
            shutter: self
                .fixture_manager
                .presets
                .shutter_presets()
                .into_iter()
                .map(Preset::from)
                .collect(),
            color: self
                .fixture_manager
                .presets
                .color_presets()
                .into_iter()
                .map(Preset::from)
                .collect(),
            position: self
                .fixture_manager
                .presets
                .position_presets()
                .into_iter()
                .map(Preset::from)
                .collect(),
            ..Default::default()
        }
    }

    pub fn call_preset(&self, preset_id: PresetId) {
        log::debug!("call_preset {:?}", preset_id);
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.call_preset(&self.fixture_manager.presets, preset_id.into());
    }

    pub fn get_groups(&self) -> Groups {
        Groups {
            groups: self
                .fixture_manager
                .get_groups()
                .into_iter()
                .map(|group| group.deref().clone().into())
                .collect(),
            ..Default::default()
        }
    }

    pub fn add_group(&self, name: String) -> Group {
        let group_id = self.fixture_manager.add_group(name.clone());
        self.runtime.add_node_for_group(group_id);

        Group {
            name,
            id: group_id,
            ..Default::default()
        }
    }

    pub fn assign_fixtures_to_group(&self, group_id: u32, fixture_ids: Vec<FixtureId>) {
        if let Some(mut group) = self.fixture_manager.groups.get_mut(&group_id) {
            let mut fixture_ids = fixture_ids
                .into_iter()
                .map(|id| id.into())
                .collect::<Vec<_>>();
            group.fixtures.append(&mut fixture_ids);
        }
    }

    pub fn assign_fixture_selection_to_group(&self, group_id: u32) {
        if let Some(mut group) = self.fixture_manager.groups.get_mut(&group_id) {
            let programmer = self.fixture_manager.get_programmer();
            let state = programmer.view().read();
            let mut fixture_ids = state.fixtures.clone();
            group.fixtures.append(&mut fixture_ids);
        }
    }

    pub fn programmer_view(&self) -> ProgrammerView {
        self.fixture_manager.get_programmer().view()
    }
}
