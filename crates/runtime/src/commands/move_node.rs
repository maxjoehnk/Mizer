use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodePath, NodePosition};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MoveNodeCommand {
    pub path: NodePath,
    pub position: NodePosition,
}

impl<'a> Command<'a> for MoveNodeCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = NodePosition;
    type Result = ();

    fn label(&self) -> String {
        format!("Moving Node '{}' to '{:?}'", self.path, self.position)
    }

    fn apply(&self, pipeline: &mut PipelineAccess) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut nodes = pipeline.designer.read();
        let node = nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let mut previous = self.position;
        std::mem::swap(&mut node.position, &mut previous);
        pipeline.designer.set(nodes);

        Ok(((), previous))
    }

    fn revert(&self, pipeline: &mut PipelineAccess, state: Self::State) -> anyhow::Result<()> {
        let mut nodes = pipeline.designer.read();
        let node = nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        node.position = state;
        pipeline.designer.set(nodes);

        Ok(())
    }
}
