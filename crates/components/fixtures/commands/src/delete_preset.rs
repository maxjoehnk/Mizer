use mizer_commander::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{GenericPreset, PresetId};
use mizer_nodes::{PresetNode};
use mizer_runtime::commands::DeleteNodesCommand;
use serde::{Deserialize, Serialize};
use mizer_runtime::Pipeline;

#[derive(Clone, Copy, Debug, Deserialize, Serialize)]
pub struct DeletePresetCommand {
    pub id: PresetId,
}

impl<'a> Command<'a> for DeletePresetCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        Ref<Pipeline>,
        SubCommand<DeleteNodesCommand>,
    );
    type State = (GenericPreset, sub_command!(DeleteNodesCommand));
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Preset {}", self.id)
    }

    fn apply(
        &self,
        (fixture_manager, pipeline, delete_node_runner): (
            &FixtureManager,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let preset = fixture_manager
            .delete_preset(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown preset {}", self.id))?;

        let path = pipeline.find_node_path::<PresetNode>(|node| node.id == self.id)
            .cloned()
            .ok_or_else(|| anyhow::anyhow!("Missing node for preset {}", self.id))?;

        let sub_cmd = DeleteNodesCommand { paths: vec![path] };
        let (_, state) = delete_node_runner.apply(sub_cmd)?;

        Ok(((), (preset, state)))
    }

    fn revert(
        &self,
        (fixture_manager, _, delete_node_runner): (
            &FixtureManager,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
        (preset, sub_cmd): Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager.presets.add(preset);
        delete_node_runner.revert(sub_cmd)?;

        Ok(())
    }
}
