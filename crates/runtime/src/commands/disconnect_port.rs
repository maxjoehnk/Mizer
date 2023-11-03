use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_execution_planner::ExecutionPlanner;
use mizer_node::{NodeLink, NodePath};
use mizer_ports::PortId;

use crate::pipeline_access::PipelineAccess;

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct DisconnectPortCommand {
    pub path: NodePath,
    pub port: PortId,
}

impl<'a> Command<'a> for DisconnectPortCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = Vec<NodeLink>;
    type Result = ();

    fn label(&self) -> String {
        format!("Disconnect Port {} of '{}'", self.port, self.path)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let links = pipeline.links.read();
        let (old_links, new_links) = links.into_iter().partition(|link| {
            (link.source == self.path && link.source_port == self.port)
                || (link.target == self.path && link.target_port == self.port)
        });
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
