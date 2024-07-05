use super::StaticNodeDescriptor;
use crate::commands::{assert_valid_parent};
use mizer_commander::{Command, RefMut};
use mizer_node::{NodeDesigner, NodePath, NodeType};
use mizer_nodes::{Node};
use serde::{Deserialize, Serialize};
use crate::pipeline::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddNodeCommand {
    pub node_type: NodeType,
    pub designer: NodeDesigner,
    pub node: Option<Node>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for AddNodeCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = NodePath;
    type Result = StaticNodeDescriptor;

    fn label(&self) -> String {
        format!("Add Node {:?}", &self.node_type)
    }

    fn apply(
        &self,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        assert_valid_parent(pipeline, self.parent.as_ref())?;
        let descriptor = pipeline.add_node(self.node_type, self.designer, self.node.clone(), self.parent.as_ref())?;
        let path = descriptor.path.clone();

        Ok((descriptor, path))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        state: Self::State,
    ) -> anyhow::Result<()> {
        pipeline.remove_node(&state)?;

        Ok(())
    }
}
