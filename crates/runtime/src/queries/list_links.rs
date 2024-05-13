use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use mizer_node::NodeLink;
use crate::RuntimeAccess;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListLinksQuery;

impl<'a> Query<'a> for ListLinksQuery {
    type Dependencies = Ref<RuntimeAccess>;
    type Result = Vec<NodeLink>;

    fn query(&self, access: &RuntimeAccess) -> anyhow::Result<Self::Result> {
        let links =  access.links.read();

        Ok(links)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
