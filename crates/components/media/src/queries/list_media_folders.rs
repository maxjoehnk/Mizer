use crate::MediaServer;
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};
use std::path::PathBuf;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListMediaFoldersQuery;

impl<'a> Query<'a> for ListMediaFoldersQuery {
    type Dependencies = Ref<MediaServer>;
    type Result = Vec<PathBuf>;

    fn query(&self, media_server: &MediaServer) -> anyhow::Result<Self::Result> {
        let folders = media_server.get_import_paths();

        Ok(folders)
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
