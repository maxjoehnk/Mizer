use crate::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodePath, NodePosition};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

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
    type Dependencies = RefMut<Pipeline>;
    type State = HashMap<NodePath, NodePosition>;
    type Result = ();

    fn label(&self) -> String {
        format!("Moving {} Nodes", self.movements.len())
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut state = HashMap::with_capacity(self.movements.len());
        for movement in &self.movements {
            let designer = pipeline
                .get_node_designer_mut(&movement.path)
                .ok_or_else(|| anyhow::anyhow!("Unknown node {}", &movement.path))?;
            let mut previous = movement.position;
            std::mem::swap(&mut designer.position, &mut previous);
            state.insert(movement.path.clone(), previous);
        }

        Ok(((), state))
    }

    fn revert(&self, pipeline: &mut Pipeline, state: Self::State) -> anyhow::Result<()> {
        for (path, position) in state {
            let designer = pipeline
                .get_node_designer_mut(&path)
                .ok_or_else(|| anyhow::anyhow!("Unknown node {}", &path))?;
            designer.position = position;
        }

        Ok(())
    }
}
