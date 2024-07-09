use super::StaticNodeDescriptor;
use crate::commands::{assert_valid_parent};
use mizer_commander::{Command, InjectorRef, RefMut};
use mizer_node::{NodeDesigner, NodePath, NodeType};
use mizer_nodes::{Node};
use serde::{Deserialize, Serialize};
use mizer_processing::Injector;
use crate::pipeline::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddNodeCommand {
    pub node_type: NodeType,
    pub designer: NodeDesigner,
    pub node: Option<Node>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for AddNodeCommand {
    type Dependencies = (RefMut<Pipeline>, InjectorRef);
    type State = NodePath;
    type Result = StaticNodeDescriptor;

    fn label(&self) -> String {
        format!("Add Node {:?}", &self.node_type)
    }

    fn apply(
        &self,
        (pipeline, injector): (&mut Pipeline, &Injector),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        assert_valid_parent(pipeline, self.parent.as_ref())?;
        let descriptor = pipeline.add_node(injector, self.node_type, self.designer, self.node.clone(), self.parent.as_ref())?;
        let path = descriptor.path.clone();

        Ok((descriptor, path))
    }

    fn revert(
        &self,
        (pipeline, _injector): (&mut Pipeline, &Injector),
        state: Self::State,
    ) -> anyhow::Result<()> {
        pipeline.delete_node(&state);

        Ok(())
    }
}
