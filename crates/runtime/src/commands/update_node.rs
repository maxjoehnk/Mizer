use std::hash::{Hash, Hasher};
use std::ops::DerefMut;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_node::NodePath;
use mizer_nodes::*;
use mizer_pipeline::ProcessingNodeExt;

use crate::pipeline_access::PipelineAccess;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateNodeCommand {
    pub path: NodePath,
    pub config: Node,
}

impl Hash for UpdateNodeCommand {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.path.hash(state)
    }
}

impl<'a> Command<'a> for UpdateNodeCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = Node;
    type Result = ();

    fn label(&self) -> String {
        format!("Update Node '{}'", self.path)
    }

    fn apply(
        &self,
        pipeline_access: &mut PipelineAccess,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        log::debug!("Updating {:?} with {:?}", self.path, self.config);

        let node = pipeline_access
            .nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let previous_config: Node = NodeDowncast::downcast(node);
        let node: &mut dyn ProcessingNodeExt = node.deref_mut();
        self.config.update(node.as_pipeline_node_mut())?;

        let mut node = pipeline_access
            .nodes_view
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node = node.value_mut();
        self.config.update(node.deref_mut())?;

        Ok(((), previous_config))
    }

    fn revert(
        &self,
        pipeline_access: &mut PipelineAccess,
        state: Self::State,
    ) -> anyhow::Result<()> {
        let node = pipeline_access
            .nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node: &mut dyn ProcessingNodeExt = node.deref_mut();
        state.update(node.as_pipeline_node_mut())?;

        let mut node = pipeline_access
            .nodes_view
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node = node.value_mut();
        state.update(node.deref_mut())?;

        Ok(())
    }
}
