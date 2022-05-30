use mizer_commander::{Command, Ref, RefMut};
use mizer_layout_commands::AddLayoutControlCommand;
use mizer_layouts::{ControlPosition, LayoutStorage};
use mizer_node::NodeType;
use mizer_runtime::commands::AddNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::ExecutionPlanner;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct AddLayoutControlWithNodeCommand {
    pub layout_id: String,
    pub node_type: NodeType,
    pub position: ControlPosition,
}

impl<'a> Command<'a> for AddLayoutControlWithNodeCommand {
    type Dependencies = (
        RefMut<PipelineAccess>,
        Ref<LayoutStorage>,
        RefMut<ExecutionPlanner>,
    );
    type State = (
        AddNodeCommand,
        <AddNodeCommand as Command<'a>>::State,
        AddLayoutControlCommand,
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
        (pipeline_access, layout_storage, planner): (
            &mut PipelineAccess,
            &LayoutStorage,
            &mut ExecutionPlanner,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let add_node_command = AddNodeCommand {
            node_type: self.node_type,
            node: None,
            designer: Default::default(),
        };
        let (descriptor, state) = add_node_command.apply((pipeline_access, planner))?;
        let add_control_command = AddLayoutControlCommand {
            layout_id: self.layout_id.clone(),
            path: descriptor.path,
            position: self.position,
        };
        add_control_command.apply((layout_storage, pipeline_access))?;

        Ok(((), (add_node_command, state, add_control_command)))
    }

    fn revert(
        &self,
        (pipeline_access, layout_storage, planner): (
            &mut PipelineAccess,
            &LayoutStorage,
            &mut ExecutionPlanner,
        ),
        (add_node_command, add_node_state, add_layout_control_command): Self::State,
    ) -> anyhow::Result<()> {
        add_layout_control_command.revert((layout_storage, pipeline_access), ())?;
        add_node_command.revert((pipeline_access, planner), add_node_state)?;

        Ok(())
    }
}
