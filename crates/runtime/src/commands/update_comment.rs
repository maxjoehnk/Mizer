use crate::pipeline::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodeColor, NodeCommentArea, NodeCommentId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateCommentCommand {
    pub id: NodeCommentId,
    pub label: Option<String>,
    pub color: Option<NodeColor>,
    pub show_background: Option<bool>,
    pub show_border: Option<bool>,
}

impl<'a> Command<'a> for UpdateCommentCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = NodeCommentArea;
    type Result = ();

    fn label(&self) -> String {
        "Update Comment".to_string()
    }

    fn apply(
        &self,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let comment = pipeline.get_comment_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Comment not found"))?;
        let prev = comment.clone();
        if let Some(label) = &self.label {
            comment.label = Some(label.clone());
        }
        if let Some(color) = self.color {
            comment.designer.color = Some(color);
        }
        if let Some(show_background) = self.show_background {
            comment.show_background = show_background;
        }
        if let Some(show_border) = self.show_border {
            comment.show_border = show_border;
        }

        Ok(((), prev))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        state: Self::State,
    ) -> anyhow::Result<()> {
        pipeline.add_comment(state);

        Ok(())
    }
}
