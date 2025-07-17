use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};
use crate::view::{View, ViewRegistry};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListViewsQuery;

impl<'a> Query<'a> for ListViewsQuery {
    type Dependencies = Ref<ViewRegistry>;
    type Result = Vec<View>;

    fn query(&self, view_registry: &ViewRegistry) -> anyhow::Result<Self::Result> {
        let views = view_registry.views();
        
        Ok(views)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
