use mizer_commander::{Query, Ref};
use mizer_layouts::{Layout, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListLayoutsQuery;

impl<'a> Query<'a> for ListLayoutsQuery {
    type Dependencies = Ref<LayoutStorage>;
    type Result = Vec<Layout>;

    fn query(&self, layout_storage: &LayoutStorage) -> anyhow::Result<Self::Result> {
        Ok(layout_storage.read())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
