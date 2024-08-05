use crate::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::NodePath;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HideNodeCommand {
    pub path: NodePath,
}

impl<'a> Command<'a> for HideNodeCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = bool;
    type Result = ();

    fn label(&self) -> String {
        format!("Hiding Node '{}'", self.path)
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let designer = pipeline
            .get_node_designer_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let mut previous = true;
        std::mem::swap(&mut designer.hidden, &mut previous);

        Ok(((), previous))
    }

    fn revert(&self, pipeline: &mut Pipeline, state: Self::State) -> anyhow::Result<()> {
        let designer = pipeline
            .get_node_designer_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        designer.hidden = state;

        Ok(())
    }
}
