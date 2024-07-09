use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref, sub_command, SubCommand, SubCommandRunner};
use mizer_fixtures::fixture::Fixture;
use mizer_fixtures::manager::FixtureManager;
use mizer_nodes::FixtureNode;
use mizer_runtime::commands::DeleteNodesCommand;
use mizer_runtime::Pipeline;

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteFixturesCommand {
    pub fixture_ids: Vec<u32>,
}

impl<'a> Command<'a> for DeleteFixturesCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        Ref<Pipeline>,
        SubCommand<DeleteNodesCommand>,
    );
    type State = (Vec<Fixture>, sub_command!(DeleteNodesCommand));
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
        (fixture_manager, pipeline, delete_node_runner): (
            &FixtureManager,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let nodes =
            pipeline.find_node_paths::<FixtureNode>(|node| self.fixture_ids.contains(&node.fixture_id));
        let cmd = DeleteNodesCommand {
            paths: nodes.into_iter().cloned().collect(),
        };

        let mut fixtures = Vec::new();

        for fixture in self
            .fixture_ids
            .iter()
            .filter_map(|fixture_id| fixture_manager.delete_fixture(*fixture_id))
        {
            fixtures.push(fixture);
        }
        let (_, state) = delete_node_runner.apply(cmd)?;

        Ok(((), (fixtures, state)))
    }

    fn revert(
        &self,
        (fixture_manager, _, delete_node_runner): (
            &FixtureManager,
            &Pipeline,
            SubCommandRunner<DeleteNodesCommand>,
        ),
        (fixtures, sub_cmd): Self::State,
    ) -> anyhow::Result<()> {
        for fixture in fixtures {
            fixture_manager.add_fixture(
                fixture.id,
                fixture.name,
                fixture.definition,
                fixture.current_mode.name.into(),
                fixture.channel,
                fixture.universe.into(),
                fixture.configuration,
            );
        }
        delete_node_runner.revert(sub_cmd)?;

        Ok(())
    }
}
