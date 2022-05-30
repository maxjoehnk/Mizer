use crate::pipeline_access::PipelineAccess;
use crate::NodeDowncast;
use mizer_commander::{Command, RefMut};
use mizer_execution_planner::{ExecutionNode, ExecutionPlanner};
use mizer_node::{NodeDesigner, NodeDetails, NodePath, NodeType, PortMetadata};
use mizer_nodes::Node;
use mizer_ports::PortId;
use serde::{Deserialize, Serialize};
use std::hash::{Hash, Hasher};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddNodeCommand {
    pub node_type: NodeType,
    pub designer: NodeDesigner,
    pub node: Option<Node>,
}

impl Hash for AddNodeCommand {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.node_type.hash(state);
        self.designer.hash(state);
        state.write_u8(if self.node.is_some() { 1 } else { 0 });
    }
}

impl<'a> Command<'a> for AddNodeCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = NodePath;
    type Result = StaticNodeDescriptor;

    fn label(&self) -> String {
        format!("Add Node {:?}", &self.node_type)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let path =
            pipeline.handle_add_node(self.node_type, self.designer.clone(), self.node.clone())?;
        planner.add_node(ExecutionNode {
            path: path.clone(),
            attached_executor: None,
        });

        let node = pipeline.nodes_view.get(&path).unwrap();
        let ports = node.list_ports();
        let details = node.value().details();

        let descriptor = StaticNodeDescriptor {
            node_type: self.node_type,
            path: path.clone(),
            designer: self.designer.clone(),
            details,
            ports,
            config: node.downcast(),
        };

        Ok((descriptor, path))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        state: Self::State,
    ) -> anyhow::Result<()> {
        planner.remove_node(&state);
        pipeline.delete_node(state)?;

        Ok(())
    }
}

#[derive(Debug, Clone)]
pub struct StaticNodeDescriptor {
    pub node_type: NodeType,
    pub path: NodePath,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
    pub details: NodeDetails,
    pub config: Node,
}
