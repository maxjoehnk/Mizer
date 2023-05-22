use super::StaticNodeDescriptor;
use crate::commands::add_path_to_container;
use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_execution_planner::{ExecutionNode, ExecutionPlanner};
use mizer_node::NodePath;
use mizer_nodes::NodeDowncast;
use serde::{Deserialize, Serialize};
use std::hash::Hash;

#[derive(Debug, Clone, Hash, Serialize, Deserialize)]
pub struct DuplicateNodeCommand {
    pub path: NodePath,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for DuplicateNodeCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = NodePath;
    type Result = StaticNodeDescriptor;

    fn label(&self) -> String {
        format!("Duplicate Node {:?}", &self.path)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let (config, designer) = {
            let node_to_duplicate = pipeline.nodes_view.get(&self.path).unwrap();
            let config = node_to_duplicate.downcast();
            let designer = pipeline
                .designer
                .read()
                .get(&self.path)
                .cloned()
                .unwrap_or_default();

            (config, designer)
        };
        let new_path =
            pipeline.handle_add_node(config.node_type(), designer.clone(), Some(config))?;
        planner.add_node(ExecutionNode {
            path: new_path.clone(),
            attached_executor: None,
        });
        add_path_to_container(pipeline, self.parent.as_ref(), &new_path)?;

        let node = pipeline.nodes_view.get(&new_path).unwrap();
        let ports = node.list_ports();
        let details = node.value().details();

        let descriptor = StaticNodeDescriptor {
            node_type: node.node_type(),
            path: new_path.clone(),
            designer,
            details,
            ports,
            settings: pipeline.get_settings(&self.path).unwrap_or_default(),
            config: node.downcast(),
        };

        Ok((descriptor, new_path))
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
