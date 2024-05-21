use serde::{Deserialize, Serialize};

use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::Group;
use mizer_fixtures::GroupId;
use mizer_node::{NodeDesigner, NodeType};
use mizer_nodes::GroupNode;
use mizer_runtime::commands::AddNodeCommand;

#[derive(Debug, Deserialize, Serialize)]
pub struct AddGroupCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddGroupCommand {
    type Dependencies = (Ref<FixtureManager>, SubCommand<AddNodeCommand>);
    type State = (GroupId, sub_command!(AddNodeCommand));
    type Result = Group;

    fn label(&self) -> String {
        format!("Add Group {}", self.name)
    }

    fn apply(
        &self,
        (fixture_manager, add_node_runner): (&FixtureManager, SubCommandRunner<AddNodeCommand>),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let group_id = fixture_manager.add_group(self.name.clone());
        let group = Group {
            id: group_id,
            name: self.name.clone(),
            fixtures: Vec::new(),
        };

        let node = GroupNode {
            id: group_id,
            ..Default::default()
        };
        let sub_cmd = AddNodeCommand {
            node_type: NodeType::Group,
            designer: NodeDesigner {
                hidden: true,
                ..Default::default()
            },
            node: Some(node.into()),
            parent: None,
        };
        let (_, state) = add_node_runner.apply(sub_cmd)?;

        Ok((group, (group_id, state)))
    }

    fn revert(
        &self,
        (fixture_manager, add_node_runner): (&FixtureManager, SubCommandRunner<AddNodeCommand>),
        (group_id, state): Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager
            .delete_group(group_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", group_id))?;
        add_node_runner.revert(state)?;

        Ok(())
    }
}
