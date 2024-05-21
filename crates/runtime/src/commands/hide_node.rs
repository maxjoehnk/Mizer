use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_node::NodePath;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HideNodeCommand {
    pub path: NodePath,
}

impl<'a> Command<'a> for HideNodeCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = bool;
    type Result = ();

    fn label(&self) -> String {
        format!("Hiding Node '{}'", self.path)
    }

    fn apply(&self, pipeline: &mut PipelineAccess) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut nodes = pipeline.designer.read();
        let node = nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let mut previous = true;
        std::mem::swap(&mut node.hidden, &mut previous);
        pipeline.designer.set(nodes);

        Ok(((), previous))
    }

    fn revert(&self, pipeline: &mut PipelineAccess, state: Self::State) -> anyhow::Result<()> {
        let mut nodes = pipeline.designer.read();
        let node = nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        node.hidden = state;
        pipeline.designer.set(nodes);

        Ok(())
    }
}
