use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use mizer_node::NodePath;
use crate::{RuntimeAccess};
use crate::commands::StaticNodeDescriptor;
use super::get_descriptor;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct GetNodeQuery {
    pub path: NodePath,
}

impl<'a> Query<'a> for GetNodeQuery {
    type Dependencies = Ref<RuntimeAccess>;
    type Result = Option<StaticNodeDescriptor>;

    #[profiling::function]
    fn query(&self, access: &RuntimeAccess) -> anyhow::Result<Self::Result> {
        let metadata = access.metadata.read();
        let designer = access.designer.read();
        let settings = access.settings.read();

        let node = access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .find(|node_path| node_path == &self.path)
            .map(|path| get_descriptor(access, path, &metadata, &designer, &settings));

        Ok(node)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
