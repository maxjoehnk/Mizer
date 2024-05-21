use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_execution_planner::ExecutionPlanner;
use mizer_node::{NodeLink, NodePath};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DisconnectPortsCommand {
    pub path: NodePath,
}

impl<'a> Command<'a> for DisconnectPortsCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = Vec<NodeLink>;
    type Result = ();

    fn label(&self) -> String {
        format!("Disconnect Ports of '{}'", self.path)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let links = pipeline.links.read();
        let (old_links, new_links) = links
            .into_iter()
            .partition(|link| link.source == self.path || link.target == self.path);
        pipeline.links.set(new_links);
        for link in &old_links {
            planner.remove_link(link);
        }

        Ok(((), old_links))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        mut state: Self::State,
    ) -> anyhow::Result<()> {
        for link in &state {
            planner.add_link(link.clone());
        }
        let mut links = pipeline.links.read();
        links.append(&mut state);
        pipeline.links.set(links);

        Ok(())
    }
}
