use mizer_commander::{Command, Ref, RefMut};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::Group;
use mizer_fixtures::GroupId;
use mizer_layouts::LayoutStorage;
use mizer_nodes::{Node, NodeDowncast};
use mizer_runtime::commands::DeleteNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::ExecutionPlanner;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteGroupCommand {
    pub id: GroupId,
}

impl<'a> Command<'a> for DeleteGroupCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        RefMut<PipelineAccess>,
        RefMut<ExecutionPlanner>,
        Ref<LayoutStorage>,
    );
    type State = (
        Group,
        DeleteNodeCommand,
        <DeleteNodeCommand as Command<'a>>::State,
    );
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Group {}", self.id)
    }

    fn apply(
        &self,
        (fixture_manager, pipeline, planner, layout_storage): (
            &FixtureManager,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
            &LayoutStorage,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let group = fixture_manager
            .delete_group(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.id))?;

        let path = pipeline
            .nodes_view
            .iter()
            .find(|node| {
                if let Node::Group(node) = node.downcast() {
                    node.id == self.id
                } else {
                    false
                }
            })
            .map(|node| node.key().clone())
            .ok_or_else(|| anyhow::anyhow!("Missing node for group {}", self.id))?;

        let sub_cmd = DeleteNodeCommand { path };
        let (_, state) = sub_cmd.apply((pipeline, planner, layout_storage))?;

        Ok(((), (group, sub_cmd, state)))
    }

    fn revert(
        &self,
        (fixture_manager, pipeline, planner, layout_storage): (
            &FixtureManager,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
            &LayoutStorage,
        ),
        (group, sub_cmd, state): Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager.groups.insert(group.id, group);
        sub_cmd.revert((pipeline, planner, layout_storage), state)?;

        Ok(())
    }
}
