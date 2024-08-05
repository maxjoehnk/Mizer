use serde::{Deserialize, Serialize};

use mizer_commander::{sub_command, Command, SubCommand, SubCommandRunner};
use mizer_layout_commands::AddLayoutControlCommand;
use mizer_layouts::{ControlPosition, ControlType};
use mizer_node::NodeType;
use mizer_runtime::commands::AddNodeCommand;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddLayoutControlWithNodeCommand {
    pub layout_id: String,
    pub node_type: NodeType,
    pub position: ControlPosition,
}

impl<'a> Command<'a> for AddLayoutControlWithNodeCommand {
    type Dependencies = (
        SubCommand<AddNodeCommand>,
        SubCommand<AddLayoutControlCommand>,
    );
    type State = (
        sub_command!(AddNodeCommand),
        sub_command!(AddLayoutControlCommand),
    );
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Add new {:?} node with control to layout {}",
            self.node_type, self.layout_id
        )
    }

    fn apply(
        &self,
        (add_node_runner, add_control_runner): (
            SubCommandRunner<AddNodeCommand>,
            SubCommandRunner<AddLayoutControlCommand>,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let add_node_command = AddNodeCommand {
            node_type: self.node_type,
            node: None,
            designer: Default::default(),
            parent: None,
            template: None,
        };
        let (descriptor, add_node_state) = add_node_runner.apply(add_node_command)?;
        let add_control_command = AddLayoutControlCommand {
            layout_id: self.layout_id.clone(),
            control_type: ControlType::Node {
                path: descriptor.path,
            },
            position: self.position,
        };
        let (_, add_control_state) = add_control_runner.apply(add_control_command)?;

        Ok(((), (add_node_state, add_control_state)))
    }

    fn revert(
        &self,
        (add_node_runner, add_control_runner): (
            SubCommandRunner<AddNodeCommand>,
            SubCommandRunner<AddLayoutControlCommand>,
        ),
        (add_node_state, add_control_state): Self::State,
    ) -> anyhow::Result<()> {
        add_control_runner.revert(add_control_state)?;
        add_node_runner.revert(add_node_state)?;

        Ok(())
    }
}
