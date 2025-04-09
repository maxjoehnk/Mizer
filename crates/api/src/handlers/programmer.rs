use crate::proto::fixtures::*;
use crate::proto::programmer::*;
use crate::RuntimeApi;
use futures::stream::{Stream, StreamExt};
use itertools::Itertools;
use mizer_command_executor::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::ProgrammerView;
use mizer_fixtures::GroupId;
use mizer_sequencer::Sequencer;

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
    #[profiling::function]
    pub fn state_stream(&self) -> impl Stream<Item = ProgrammerState> + 'static {
        let programmer = self.fixture_manager.get_programmer();
        programmer.bus().map(ProgrammerState::from)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn write_control(&self, request: WriteControlRequest) {
        let mut programmer = self.fixture_manager.get_programmer_mut();
        let control = request.as_controls();
        programmer.write_control(control);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn select_fixtures(&self, fixture_ids: Vec<FixtureId>) -> anyhow::Result<()> {
        tracing::debug!("select_fixtures {:?}", fixture_ids);
        self.runtime.run_command(SelectFixturesCommand {
            fixtures: fixture_ids.into_iter().map(|id| id.into()).collect(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn unselect_fixtures(&self, fixture_ids: Vec<FixtureId>) {
        tracing::debug!("unselect_fixtures {:?}", fixture_ids);
        let mut programmer = self.fixture_manager.get_programmer_mut();
        programmer.unselect_fixtures(fixture_ids.into_iter().map(|id| id.into()).collect());
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn select_group(&self, group_id: u32) -> anyhow::Result<()> {
        tracing::debug!("select_group {:?}", group_id);
        self.runtime.run_command(CallGroupCommand {
            group_id: GroupId(group_id),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn clear(&self) -> anyhow::Result<()> {
        self.runtime.run_command(ClearProgrammerCommand)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn highlight(&self, highlight: bool) {
        let mut programmer = self.fixture_manager.get_programmer_mut();
        programmer.set_highlight(highlight);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn store(&self, sequence_id: u32, store_mode: store_request::Mode, cue_id: Option<u32>) {
        let (controls, effects, presets) = {
            let programmer = self.fixture_manager.get_programmer();
            let controls = programmer.get_controls();
            let presets = programmer.active_presets();
            let effects = programmer.active_effects().cloned().collect::<Vec<_>>();

            (controls, effects, presets)
        };
        self.runtime
            .run_command(StoreProgrammerInSequenceCommand {
                sequence_id,
                cue_id,
                controls,
                presets,
                effects,
                store_mode: store_mode.into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_presets(&self) -> Presets {
        let intensities = self
            .runtime
            .execute_query(ListIntensityPresetsQuery)
            .unwrap();
        let shutters = self.runtime.execute_query(ListShutterPresetsQuery).unwrap();
        let colors = self.runtime.execute_query(ListColorPresetsQuery).unwrap();
        let positions = self
            .runtime
            .execute_query(ListPositionPresetsQuery)
            .unwrap();

        Presets {
            intensities: intensities
                .into_iter()
                .sorted_by_key(|(_, preset)| preset.id)
                .map(Preset::from)
                .collect(),
            shutters: shutters
                .into_iter()
                .sorted_by_key(|(_, preset)| preset.id)
                .map(Preset::from)
                .collect(),
            colors: colors
                .into_iter()
                .sorted_by_key(|(_, preset)| preset.id)
                .map(Preset::from)
                .collect(),
            positions: positions
                .into_iter()
                .sorted_by_key(|(_, preset)| preset.id)
                .map(Preset::from)
                .collect(),
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn call_preset(&self, preset_id: PresetId) -> anyhow::Result<()> {
        tracing::debug!("call_preset {:?}", preset_id);
        self.runtime.run_command(CallPresetCommand {
            preset_id: preset_id.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn call_effect(&self, effect_id: u32) -> anyhow::Result<()> {
        tracing::debug!("call_effect {:?}", effect_id);
        self.runtime.run_command(CallEffectCommand { effect_id })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_groups(&self) -> Groups {
        let groups = self.runtime.execute_query(ListGroupsQuery).unwrap();
        Groups {
            groups: groups.into_iter().map(|group| group.into()).collect(),
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_group(&self, name: String) -> Group {
        let group = self.runtime.run_command(AddGroupCommand { name }).unwrap();

        group.into()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_group(&self, id: u32) -> anyhow::Result<()> {
        self.runtime
            .run_command(DeleteGroupCommand { id: id.into() })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn rename_group(&self, id: u32, name: String) {
        self.runtime
            .run_command(RenameGroupCommand {
                id: id.into(),
                name,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn assign_fixtures_to_group(&self, req: AssignFixturesToGroupRequest) {
        let mode = req.mode();
        let group_id = GroupId(req.id);
        let fixture_ids = req
            .fixtures
            .into_iter()
            .map(|id| id.into())
            .collect::<Vec<_>>();
        self.runtime
            .run_command(AssignFixturesToGroupCommand {
                group_id,
                selection: fixture_ids.into(),
                mode: mode.into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn assign_fixture_selection_to_group(
        &self,
        req: AssignFixtureSelectionToGroupRequest,
    ) -> anyhow::Result<()> {
        let mode = req.mode();
        let group_id = GroupId(req.id);

        self.runtime.run_command(AssignProgrammerToGroupCommand {
            group_id,
            mode: mode.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn programmer_view(&self) -> ProgrammerView {
        self.fixture_manager.get_programmer().view()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_block_size(&self, block_size: usize) {
        self.fixture_manager
            .get_programmer_mut()
            .set_block_size(block_size);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_groups(&self, groups: usize) {
        self.fixture_manager.get_programmer_mut().set_groups(groups);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_wings(&self, wings: usize) {
        self.fixture_manager.get_programmer_mut().set_wings(wings);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn next(&self) {
        self.fixture_manager.get_programmer_mut().next();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn prev(&self) {
        self.fixture_manager.get_programmer_mut().prev();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn set(&self) {
        self.fixture_manager.get_programmer_mut().set();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn shuffle(&self) {
        self.fixture_manager.get_programmer_mut().shuffle();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn mark_offline(&self) {
        self.fixture_manager.get_programmer_mut().set_offline(true);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn mark_online(&self) {
        self.fixture_manager.get_programmer_mut().set_offline(false);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn write_effect_rate(&self, request: WriteEffectRateRequest) {
        self.fixture_manager
            .get_programmer_mut()
            .write_rate(request.effect_id, request.effect_rate);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn write_effect_offset(&self, request: WriteEffectOffsetRequest) {
        self.fixture_manager
            .get_programmer_mut()
            .write_offset(request.effect_id, request.effect_offset);
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn store_preset(
        &self, req: StorePresetRequest
    ) -> anyhow::Result<()> {
        let command = match req.target {
            Some(store_preset_request::Target::Existing(preset_id)) => StorePresetCommand::Existing { preset_id: preset_id.into() },
            Some(store_preset_request::Target::NewPreset(preset)) => StorePresetCommand::New {
                preset_type: preset.r#type().into(),
                preset_target: preset.target.map(|_| preset.target().into()),
name: preset.label,
            },
            None => anyhow::bail!("No target specified for store preset"),
        };
        self.runtime.run_command(command)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_preset(&self, preset_id: PresetId) {
        self.runtime
            .run_command(DeletePresetCommand {
                id: preset_id.into(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn rename_preset(&self, preset_id: PresetId, label: String) {
        self.runtime
            .run_command(RenamePresetCommand {
                id: preset_id.into(),
                label,
            })
            .unwrap();
    }
}
