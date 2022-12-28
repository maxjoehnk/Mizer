use crate::commands::AddNodeCommand;
use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_execution_planner::ExecutionPlanner;
use mizer_node::{NodeDesigner, NodePath, NodeType};
use mizer_nodes::{ContainerNode, Node};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct GroupNodesCommand {
    pub nodes: Vec<NodePath>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for GroupNodesCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = (AddNodeCommand, <AddNodeCommand as Command<'a>>::State);
    type Result = ();

    fn label(&self) -> String {
        format!("Grouping Nodes '{:?}'", self.nodes)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let cmd = AddNodeCommand {
            node_type: NodeType::Container,
            parent: self.parent.clone(),
            node: Some(Node::Container(ContainerNode {
                nodes: self.nodes.clone(),
            })),
            designer: NodeDesigner::default(),
        };
        let (_, state) = cmd.apply((pipeline, planner))?;

        Ok(((), (cmd, state)))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        (cmd, state): Self::State,
    ) -> anyhow::Result<()> {
        cmd.revert((pipeline, planner), state)?;

        Ok(())
    }
}
