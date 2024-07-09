use crate::commands::AddNodeCommand;
use mizer_commander::{Command, sub_command, SubCommand, SubCommandRunner};
use mizer_node::{NodeDesigner, NodePath, NodeType};
use mizer_nodes::{ContainerNode, Node};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GroupNodesCommand {
    pub nodes: Vec<NodePath>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for GroupNodesCommand {
    type Dependencies = SubCommand<AddNodeCommand>;
    type State = sub_command!(AddNodeCommand);
    type Result = ();

    fn label(&self) -> String {
        format!("Grouping Nodes '{:?}'", self.nodes)
    }

    fn apply(
        &self,
        add_node_runner: SubCommandRunner<AddNodeCommand>,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let cmd = AddNodeCommand {
            node_type: NodeType::Container,
            parent: self.parent.clone(),
            node: Some(Node::Container(ContainerNode {
                nodes: self.nodes.clone(),
            })),
            designer: NodeDesigner::default(),
        };
        let (_, state) = add_node_runner.apply(cmd)?;

        Ok(((), state))
    }

    fn revert(
        &self,
        add_node_runner: SubCommandRunner<AddNodeCommand>,
        state: Self::State,
    ) -> anyhow::Result<()> {
        add_node_runner.revert(state)?;

        Ok(())
    }
}
