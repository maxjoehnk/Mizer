use crate::commands::{add_path_to_container, assert_valid_parent, remove_path_from_container};
use mizer_commander::{Command, RefMut};
use mizer_node::{NodePath, NodePosition};
use serde::{Deserialize, Serialize};
use crate::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ShowNodeCommand {
    pub path: NodePath,
    pub position: NodePosition,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for ShowNodeCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = (bool, NodePosition);
    type Result = ();

    fn label(&self) -> String {
        format!("Showing Node '{}'", self.path)
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        assert_valid_parent(pipeline, self.parent.as_ref())?;
        let designer = pipeline.get_node_designer_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let mut hidden = false;
        let mut position = self.position;
        std::mem::swap(&mut designer.hidden, &mut hidden);
        std::mem::swap(&mut designer.position, &mut position);
        add_path_to_container(pipeline, self.parent.as_ref(), &self.path)?;

        Ok(((), (hidden, position)))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        (hidden, position): Self::State,
    ) -> anyhow::Result<()> {
        let designer = pipeline.get_node_designer_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        designer.hidden = hidden;
        designer.position = position;
        remove_path_from_container(pipeline, self.parent.as_ref(), &self.path)?;

        Ok(())
    }
}
