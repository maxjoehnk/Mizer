use super::StaticNodeDescriptor;
use crate::commands::{add_path_to_container, assert_valid_parent, remove_path_from_container};
use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_execution_planner::{ExecutionNode, ExecutionPlanner};
use mizer_node::{NodeDesigner, NodePath, NodeType};
use mizer_nodes::{Node};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddNodeCommand {
    pub node_type: NodeType,
    pub designer: NodeDesigner,
    pub node: Option<Node>,
    pub parent: Option<NodePath>,
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
        assert_valid_parent(pipeline, self.parent.as_ref())?;
        let path =
            pipeline.handle_add_node(self.node_type, self.designer.clone(), self.node.clone())?;
        planner.add_node(ExecutionNode {
            path: path.clone(),
            attached_executor: None,
        });
        add_path_to_container(pipeline, self.parent.as_ref(), &path)?;

        let node = pipeline.nodes_view.get(&path).unwrap();
        let details = node.value().details();

        let descriptor = StaticNodeDescriptor {
            node_type: self.node_type,
            path: path.clone(),
            designer: self.designer.clone(),
            metadata: Default::default(),
            details,
            ports: Default::default(),
            settings: Default::default(),
            children: Default::default(),
        };

        Ok((descriptor, path))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        state: Self::State,
    ) -> anyhow::Result<()> {
        remove_path_from_container(pipeline, self.parent.as_ref(), &state)?;
        planner.remove_node(&state);
        pipeline.delete_node(state)?;

        Ok(())
    }
}
