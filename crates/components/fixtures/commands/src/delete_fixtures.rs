use mizer_commander::{sub_command, Command, Ref, RefMut};
use mizer_fixtures::fixture::Fixture;
use mizer_fixtures::manager::FixtureManager;
use mizer_layouts::LayoutStorage;
use mizer_nodes::{Node, NodeDowncast};
use mizer_runtime::commands::DeleteNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::ExecutionPlanner;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteFixturesCommand {
    pub fixture_ids: Vec<u32>,
}

impl<'a> Command<'a> for DeleteFixturesCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        RefMut<PipelineAccess>,
        RefMut<ExecutionPlanner>,
        Ref<LayoutStorage>,
    );
    type State = Vec<(Fixture, sub_command!(DeleteNodeCommand))>;
    type Result = ();

    fn label(&self) -> String {
        let fixture_ids = self
            .fixture_ids
            .iter()
            .map(|id| id.to_string())
            .collect::<Vec<_>>();

        format!("Delete Fixtures ({})", fixture_ids.join(", "))
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
        let mut nodes = pipeline
            .nodes_view
            .iter()
            .filter_map(|node| {
                if let Node::Fixture(fixture_node) = node.downcast() {
                    Some((node.key().clone(), fixture_node))
                } else {
                    None
                }
            })
            .filter(|(_, node)| self.fixture_ids.contains(&node.fixture_id))
            .map(|(path, node)| (node.fixture_id, DeleteNodeCommand { path }))
            .collect::<HashMap<_, _>>();

        let mut states = Vec::new();

        for (fixture, command) in self.fixture_ids.iter().filter_map(|fixture_id| {
            let fixture = fixture_manager.delete_fixture(*fixture_id);
            let fixture_node = nodes.remove(fixture_id);

            fixture.zip(fixture_node)
        }) {
            let (_, state) = command.apply((pipeline, planner, layout_storage))?;
            states.push((fixture, (command, state)));
        }

        Ok(((), states))
    }

    fn revert(
        &self,
        (fixture_manager, pipeline, planner, layout_storage): (
            &FixtureManager,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
            &LayoutStorage,
        ),
        state: Self::State,
    ) -> anyhow::Result<()> {
        for (fixture, (delete_node_cmd, state)) in state {
            fixture_manager.add_fixture(
                fixture.id,
                fixture.name,
                fixture.definition,
                fixture.current_mode.name.into(),
                fixture.output,
                fixture.channel,
                fixture.universe.into(),
                fixture.configuration,
                fixture.placement,
            );
            delete_node_cmd.revert((pipeline, planner, layout_storage), state)?;
        }

        Ok(())
    }
}
