use mizer_commander::{Command, RefMut};
use mizer_node::{NodeColor, NodePath};
use serde::{Deserialize, Serialize};
use crate::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateNodeColorCommand {
    pub path: NodePath,
    pub color: Option<NodeColor>,
}

impl<'a> Command<'a> for UpdateNodeColorCommand {
    type Dependencies = RefMut<Pipeline>;
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

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let designer = pipeline.get_node_designer_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let mut previous = self.color;
        std::mem::swap(&mut designer.color, &mut previous);

        Ok(((), previous))
    }

    fn revert(&self, pipeline: &mut Pipeline, state: Self::State) -> anyhow::Result<()> {
        let designer = pipeline.get_node_designer_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        designer.color = state;

        Ok(())
    }
}
