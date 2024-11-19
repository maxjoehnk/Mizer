use crate::commands::assert_valid_parent;
use crate::pipeline::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodeCommentArea, NodeCommentId, NodePath, NodePosition};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddCommentCommand {
    pub parent: Option<NodePath>,
    pub position: NodePosition,
    pub width: f64,
    pub height: f64,
}

impl<'a> Command<'a> for AddCommentCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = NodeCommentId;
    type Result = ();

    fn label(&self) -> String {
        "Add Comment".to_string()
    }

    fn apply(
        &self,
        (pipeline): (&mut Pipeline),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        assert_valid_parent(pipeline, self.parent.as_ref())?;
        let mut comment = NodeCommentArea::new(self.position, self.width, self.height);
        comment.parent = self.parent.clone();
        let comment_id = comment.id;
        pipeline.add_comment(comment);

        Ok(((), comment_id))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        state: Self::State,
    ) -> anyhow::Result<()> {
        pipeline.delete_comment(&state);

        Ok(())
    }
}
