use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use crate::{Pipeline};
use crate::commands::StaticNodeDescriptor;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListNodesQuery;

impl<'a> Query<'a> for ListNodesQuery {
    type Dependencies = Ref<Pipeline>;
    type Result = Vec<StaticNodeDescriptor>;

    #[profiling::function]
    fn query(&self, pipeline: &Pipeline) -> anyhow::Result<Self::Result> {
        let nodes = pipeline.list_node_descriptors();

        Ok(nodes)
    }

    fn requires_main_loop(&self) -> bool {
        true
    }
}
