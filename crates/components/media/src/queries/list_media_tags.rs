use crate::documents::MediaTag;
use crate::MediaServer;
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListMediaTagsQuery;

impl<'a> Query<'a> for ListMediaTagsQuery {
    type Dependencies = Ref<MediaServer>;
    type Result = Vec<MediaTag>;

    fn query(&self, media_server: &MediaServer) -> anyhow::Result<Self::Result> {
        let tags = media_server.get_tags()?;

        Ok(tags)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
