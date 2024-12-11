use crate::pipeline::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodeCommentArea, NodeCommentId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DeleteCommentCommand {
    pub comment_id: NodeCommentId,
}

impl<'a> Command<'a> for DeleteCommentCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = NodeCommentArea;
    type Result = ();

    fn label(&self) -> String {
        "Delete Comment".to_string()
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let comment = pipeline
            .delete_comment(&self.comment_id)
            .ok_or_else(|| anyhow::anyhow!("Comment not found"))?;

        Ok(((), comment))
    }

    fn revert(&self, pipeline: &mut Pipeline, comment: Self::State) -> anyhow::Result<()> {
        pipeline.add_comment(comment);

        Ok(())
    }
}
