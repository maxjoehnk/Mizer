use mizer_commander::{Command, RefMut};
use mizer_node::{NodeColor, NodePath};
use serde::{Deserialize, Serialize};

use crate::pipeline_access::PipelineAccess;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateNodeColorCommand {
    pub path: NodePath,
    pub color: Option<NodeColor>,
}

impl<'a> Command<'a> for UpdateNodeColorCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = Option<NodeColor>;
    type Result = ();

    fn label(&self) -> String {
        match &self.color {
            Some(value) => {
                format!("Update Node {} color to {:?}", self.path, value)
            }
            None => format!("Remove Node {} color", self.path),
        }
    }

    fn apply(&self, pipeline: &mut PipelineAccess) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut nodes = pipeline.designer.read();
        let node = nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let mut previous = self.color;
        std::mem::swap(&mut node.color, &mut previous);
        pipeline.designer.set(nodes);

        Ok(((), previous))
    }

    fn revert(&self, pipeline: &mut PipelineAccess, state: Self::State) -> anyhow::Result<()> {
        let mut nodes = pipeline.designer.read();
        let node = nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        node.color = state;
        pipeline.designer.set(nodes);

        Ok(())
    }
}
