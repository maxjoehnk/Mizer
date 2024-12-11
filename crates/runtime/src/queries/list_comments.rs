use crate::commands::StaticNodeDescriptor;
use crate::Pipeline;
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};
use mizer_node::NodeCommentArea;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListCommentsQuery;

impl<'a> Query<'a> for ListCommentsQuery {
    type Dependencies = Ref<Pipeline>;
    type Result = Vec<NodeCommentArea>;

    #[profiling::function]
    fn query(&self, pipeline: &Pipeline) -> anyhow::Result<Self::Result> {
        let comments = pipeline.list_comments().cloned().collect();

        Ok(comments)
    }

    fn requires_main_loop(&self) -> bool {
        true
    }
}
