use serde::{Deserialize, Serialize};

use mizer_commander::{Query, Ref};
use mizer_node::NodePath;

use crate::commands::StaticNodeDescriptor;
use crate::Pipeline;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct GetNodeQuery {
    pub path: NodePath,
}

impl<'a> Query<'a> for GetNodeQuery {
    type Dependencies = Ref<Pipeline>;
    type Result = Option<StaticNodeDescriptor>;

    #[profiling::function]
    fn query(&self, pipeline: &Pipeline) -> anyhow::Result<Self::Result> {
        let node = pipeline.get_node_descriptor(&self.path);

        Ok(node)
    }

    fn requires_main_loop(&self) -> bool {
        true
    }
}
