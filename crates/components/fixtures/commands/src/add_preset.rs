use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{GenericPreset, PresetId, PresetType};
use mizer_node::{NodeDesigner, NodeType};
use mizer_nodes::PresetNode;
use mizer_runtime::commands::AddNodeCommand;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddPresetCommand {
    pub name: Option<String>,
    pub preset_type: PresetType,
    pub values: Vec<FixtureControlValue>,
}

impl<'a> Command<'a> for AddPresetCommand {
    type Dependencies = (Ref<FixtureManager>, SubCommand<AddNodeCommand>);
    type State = (PresetId, sub_command!(AddNodeCommand));
    type Result = GenericPreset;

    fn label(&self) -> String {
        format!(
            "Add {} Preset {}",
            self.preset_type,
            self.name.as_deref().unwrap_or_default()
        )
    }

    fn apply(
        &self,
        (fixture_manager, add_node_runner): (&FixtureManager, SubCommandRunner<AddNodeCommand>),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let preset =
            fixture_manager.add_preset(self.name.clone(), self.preset_type, self.values.clone())?;
        let preset_id = preset.id();

        let node = PresetNode { id: preset_id };
        let sub_cmd = AddNodeCommand {
            node_type: NodeType::Preset,
            designer: NodeDesigner {
                hidden: true,
                ..Default::default()
            },
            node: Some(node.into()),
            parent: None,
        };
        let (_, state) = add_node_runner.apply(sub_cmd)?;

        Ok((preset, (preset_id, state)))
    }

    fn revert(
        &self,
        (fixture_manager, add_node_runner): (&FixtureManager, SubCommandRunner<AddNodeCommand>),
        (preset_id, state): Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager
            .delete_preset(preset_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown preset {preset_id:?}"))?;
        add_node_runner.revert(state)?;

        Ok(())
    }
}
