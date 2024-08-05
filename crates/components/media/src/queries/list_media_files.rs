use crate::documents::MediaDocument;
use crate::MediaServer;
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListMediaFilesQuery;

impl<'a> Query<'a> for ListMediaFilesQuery {
    type Dependencies = Ref<MediaServer>;
    type Result = Vec<MediaDocument>;

    fn query(&self, media_server: &MediaServer) -> anyhow::Result<Self::Result> {
        let files = media_server.get_media()?;

        Ok(files)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
