use std::collections::HashMap;
use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodePath, NodePosition};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MoveNodesCommand {
    pub movements: Vec<NodeMovement>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NodeMovement {
    pub path: NodePath,
    pub position: NodePosition,
}

impl<'a> Command<'a> for MoveNodesCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = HashMap<NodePath, NodePosition>;
    type Result = ();

    fn label(&self) -> String {
        format!("Moving {} Nodes", self.movements.len())
    }

    fn apply(&self, pipeline: &mut PipelineAccess) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut nodes = pipeline.designer.read();
        let mut state = HashMap::with_capacity(self.movements.len());
        for movement in &self.movements {
            let node = nodes
                .get_mut(&movement.path)
                .ok_or_else(|| anyhow::anyhow!("Unknown node {}", movement.path))?;
            let mut previous = movement.position;
            std::mem::swap(&mut node.position, &mut previous);
            state.insert(movement.path.clone(), previous);
        }
        pipeline.designer.set(nodes);

        Ok(((), state))
    }

    fn revert(&self, pipeline: &mut PipelineAccess, state: Self::State) -> anyhow::Result<()> {
        let mut nodes = pipeline.designer.read();
        for (path, position) in state {
            let node = nodes
                .get_mut(&path)
                .ok_or_else(|| anyhow::anyhow!("Unknown node {}", path))?;
            node.position = position;
        }
        pipeline.designer.set(nodes);

        Ok(())
    }
}
