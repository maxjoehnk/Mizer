use serde::{Deserialize, Serialize};

use mizer_commander::{sub_command, Command, Ref, SubCommand, SubCommandRunner};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::Group;
use mizer_fixtures::GroupId;
use mizer_nodes::GroupNode;
use mizer_runtime::commands::DeleteNodesCommand;
use mizer_runtime::Pipeline;

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteGroupCommand {
    pub id: GroupId,
}

impl<'a> Command<'a> for DeleteGroupCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        Ref<Pipeline>,
        SubCommand<DeleteNodesCommand>,
    );
    type State = (Group, sub_command!(DeleteNodesCommand));
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Group {}", self.id)
    }

    fn apply(
        &self,
        (fixture_manager, pipeline, delete_node_runner): (
            &FixtureManager,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let group = fixture_manager
            .delete_group(self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown group {}", self.id))?;

        let paths = pipeline
            .find_node_paths::<GroupNode>(|node| node.id == self.id)
            .into_iter()
            .cloned()
            .collect::<Vec<_>>();

        let sub_cmd = DeleteNodesCommand { paths };
        let (_, state) = delete_node_runner.apply(sub_cmd)?;

        Ok(((), (group, state)))
    }

    fn revert(
        &self,
        (fixture_manager, _, delete_node_runner): (
            &FixtureManager,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
        (group, sub_cmd): Self::State,
    ) -> anyhow::Result<()> {
        fixture_manager.groups.insert(group.id, group);
        delete_node_runner.revert(sub_cmd)?;

        Ok(())
    }
}
