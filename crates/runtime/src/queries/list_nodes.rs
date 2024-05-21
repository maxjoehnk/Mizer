use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use crate::{RuntimeAccess};
use crate::commands::StaticNodeDescriptor;
use super::get_descriptor;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListNodesQuery;

impl<'a> Query<'a> for ListNodesQuery {
    type Dependencies = Ref<RuntimeAccess>;
    type Result = Vec<StaticNodeDescriptor>;

    #[profiling::function]
    fn query(&self, access: &RuntimeAccess) -> anyhow::Result<Self::Result> {
        let metadata = access.metadata.read();
        let designer = access.designer.read();
        let settings = access.settings.read();

        let nodes = access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .map(|path| get_descriptor(access, path, &metadata, &designer, &settings))
            .collect();

        Ok(nodes)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
