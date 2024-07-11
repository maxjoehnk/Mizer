use serde::{Deserialize, Serialize};

use mizer_commander::{Query, Ref};
use mizer_node::NodeLink;

use crate::Pipeline;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListLinksQuery;

impl<'a> Query<'a> for ListLinksQuery {
    type Dependencies = Ref<Pipeline>;
    type Result = Vec<NodeLink>;

    fn query(&self, pipeline: &Pipeline) -> anyhow::Result<Self::Result> {
        let links = pipeline.list_links().cloned().collect();

        Ok(links)
    }

    fn requires_main_loop(&self) -> bool {
        true
    }
}
