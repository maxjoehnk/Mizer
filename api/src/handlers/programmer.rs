use crate::models::fixtures::*;
use crate::models::programmer::*;
use crate::RuntimeApi;
use futures::stream::{Stream, StreamExt};
use mizer_command_executor::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::ProgrammerView;
use mizer_sequencer::Sequencer;
use std::ops::Deref;

#[derive(Clone)]
pub struct ProgrammerHandler<R> {
    fixture_manager: FixtureManager,
    runtime: R,
}

impl<R: RuntimeApi> ProgrammerHandler<R> {
    pub fn new(fixture_manager: FixtureManager, _: Sequencer, runtime: R) -> Self {
        Self {
            fixture_manager,
            runtime,
        }
    }

    #[tracing::instrument(skip(self))]
    pub fn state_stream(&self) -> impl Stream<Item = ProgrammerState> + 'static {
        let programmer = self.fixture_manager.get_programmer();
        programmer.bus().map(ProgrammerState::from)
    }

    #[tracing::instrument(skip(self))]
    pub fn write_control(&self, request: WriteControlRequest) {
        let mut programmer = self.fixture_manager.get_programmer();
        let control = request.as_controls();
        programmer.write_control(control);
    }

    #[tracing::instrument(skip(self))]
    pub fn select_fixtures(&self, fixture_ids: Vec<FixtureId>) {
        log::debug!("select_fixtures {:?}", fixture_ids);
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.select_fixtures(fixture_ids.into_iter().map(|id| id.into()).collect());
    }

    #[tracing::instrument(skip(self))]
    pub fn select_group(&self, group_id: u32) {
        log::debug!("select_group {:?}", group_id);
        if let Some(group) = self.fixture_manager.get_group(group_id) {
            let mut programmer = self.fixture_manager.get_programmer();
            programmer.select_group(&group);
        }
    }

    #[tracing::instrument(skip(self))]
    pub fn clear(&self) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.clear();
    }

    #[tracing::instrument(skip(self))]
    pub fn highlight(&self, highlight: bool) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.set_highlight(highlight);
    }

    #[tracing::instrument(skip(self))]
    pub fn store(&self, sequence_id: u32, store_mode: StoreRequest_Mode) {
        let (controls, effects) = {
            let programmer = self.fixture_manager.get_programmer();
            let controls = programmer.get_controls();
            let effects = programmer.active_effects().cloned().collect::<Vec<_>>();

            (controls, effects)
        };
        self.runtime
            .run_command(StoreProgrammerInSequenceCommand {
                sequence_id,
                controls,
                store_mode: store_mode.into(),
                effects,
            })
            .unwrap();
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

    #[tracing::instrument(skip(self))]
    pub fn call_preset(&self, preset_id: PresetId) {
        log::debug!("call_preset {:?}", preset_id);
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.call_preset(&self.fixture_manager.presets, preset_id.into());
    }

    #[tracing::instrument(skip(self))]
    pub fn call_effect(&self, effect_id: u32) {
        log::debug!("call_effect {:?}", effect_id);
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.call_effect(effect_id);
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
        let group = self.runtime.run_command(AddGroupCommand { name }).unwrap();

        group.into()
    }

    pub fn assign_fixtures_to_group(&self, group_id: u32, fixture_ids: Vec<FixtureId>) {
        let fixture_ids = fixture_ids
            .into_iter()
            .map(|id| id.into())
            .collect::<Vec<_>>();
        self.runtime
            .run_command(AssignFixturesToGroupCommand {
                group_id,
                fixture_ids,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn assign_fixture_selection_to_group(&self, group_id: u32) {
        let programmer = self.fixture_manager.get_programmer();
        let state = programmer.view().read();
        let fixture_ids = state.all_fixtures();
        self.runtime
            .run_command(AssignFixturesToGroupCommand {
                group_id,
                fixture_ids,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn programmer_view(&self) -> ProgrammerView {
        self.fixture_manager.get_programmer().view()
    }
}
