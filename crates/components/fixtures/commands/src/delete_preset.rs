use mizer_commander::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{GenericPreset, PresetId};
use mizer_nodes::{Node, NodeDowncast};
use mizer_runtime::commands::DeleteNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, Deserialize, Serialize, Hash)]
pub struct DeletePresetCommand {
    pub id: PresetId,
}

impl<'a> Command<'a> for DeletePresetCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        Ref<PipelineAccess>,
        SubCommand<DeleteNodeCommand>,
    );
    type State = (GenericPreset, sub_command!(DeleteNodeCommand));
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Preset {}", self.id)
    }

    fn apply(
        &self,
        (fixture_manager, pipeline, delete_node_runner): (
            &FixtureManager,
            &PipelineAccess,
            SubCommandRunner<DeleteNodeCommand>,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let preset = fixture_manager
            .delete_preset(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown preset {}", self.id))?;

        let path = pipeline
            .nodes_view
            .iter()
            .find(|node| {
                if let Node::Preset(node) = node.downcast() {
                    node.id == self.id
                } else {
                    false
                }
            })
            .map(|node| node.key().clone())
            .ok_or_else(|| anyhow::anyhow!("Missing node for preset {}", self.id))?;

        let sub_cmd = DeleteNodeCommand { path };
        let (_, state) = delete_node_runner.apply(sub_cmd)?;

        Ok(((), (preset, state)))
    }

    fn revert(
        &self,
        (fixture_manager, _, delete_node_runner): (
            &FixtureManager,
            &PipelineAccess,
            SubCommandRunner<DeleteNodeCommand>,
        ),
        (preset, sub_cmd): Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager.presets.add(preset);
        delete_node_runner.revert(sub_cmd)?;

        Ok(())
    }
}
