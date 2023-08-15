use mizer_media::documents::MediaId;
use mizer_media::{MediaCreateModel, MediaServer};
use std::path::PathBuf;

use crate::proto::media::*;

#[derive(Clone)]
pub struct MediaHandler {
    api: MediaServer,
}

impl MediaHandler {
    pub fn new(api: MediaServer) -> Self {
        Self { api }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn create_tag(&self, name: String) -> anyhow::Result<MediaTag> {
        let document = self.api.create_tag(name)?;

        Ok(document.into())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_tags_with_media(&self) -> anyhow::Result<GroupedMediaFiles> {
        let tags = self.api.get_tags()?;
        let tags = tags.into_iter().map(MediaTagWithFiles::from).collect();

        Ok(GroupedMediaFiles {
            tags,
            ..Default::default()
        })
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_media(&self) -> anyhow::Result<MediaFiles> {
        let files = self.api.get_media()?;
        let files = files.into_iter().map(MediaFile::from).collect();
        let folders = self.api.get_import_paths();
        let folders = folders
            .into_iter()
            .flat_map(|p| p.to_str().map(|p| p.to_string()))
            .collect();

        Ok(MediaFiles {
            files,
            folders: Some(MediaFolders { paths: folders }),
        })
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub async fn import_media(&self, files: Vec<String>) -> anyhow::Result<()> {
        for file in files {
            let path = PathBuf::from(file);
            let name = path.file_name().unwrap().to_str().unwrap().to_string();
            self.api
                .import_file(
                    MediaCreateModel {
                        name,
                        tags: Default::default(),
                    },
                    path,
                    None,
                )
                .await?;
        }

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_media(&self, file_id: String) -> anyhow::Result<()> {
        self.api.remove_file(MediaId::try_from(file_id)?);

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_folders(&self) -> anyhow::Result<Vec<String>> {
        let folders = self
            .api
            .get_import_paths()
            .into_iter()
            .flat_map(|path| path.to_str().map(|s| s.to_string()))
            .collect();

        Ok(folders)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub async fn add_folder(&self, path: String) -> anyhow::Result<()> {
        self.api.add_import_path(PathBuf::from(path)).await;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_folder(&self, path: String) -> anyhow::Result<()> {
        self.api.remove_import_path(PathBuf::from(path));

        Ok(())
    }
}
