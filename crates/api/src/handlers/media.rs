use std::path::PathBuf;

use futures::{Stream, StreamExt};

use mizer_media::documents::{MediaDocument, MediaId, TagId};
use mizer_media::{MediaCreateModel, MediaServer};
use mizer_media::queries::{ListMediaFilesQuery, ListMediaFoldersQuery, ListMediaTagsQuery};

use crate::proto::media::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct MediaHandler<R> {
    api: MediaServer,
    runtime: R,
}

impl<R: RuntimeApi> MediaHandler<R> {
    pub fn new(api: MediaServer, runtime: R) -> Self {
        Self { api, runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn create_tag(&self, name: String) -> anyhow::Result<MediaTag> {
        let document = self.api.create_tag(name)?;

        Ok(document.into())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_tag(&self, tag_id: String) -> anyhow::Result<()> {
        self.api.remove_tag(TagId::try_from(tag_id)?);

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_tag_to_media(&self, media_id: String, tag_id: String) -> anyhow::Result<()> {
        self.api
            .add_tag_to_media(MediaId::try_from(media_id)?, TagId::try_from(tag_id)?)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_tag_from_media(&self, media_id: String, tag_id: String) -> anyhow::Result<()> {
        self.api
            .remove_tag_from_media(MediaId::try_from(media_id)?, TagId::try_from(tag_id)?)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_media(&self) -> anyhow::Result<MediaFiles> {
        let files = self.runtime.query(ListMediaFilesQuery)?;
        let folders = self.runtime.query(ListMediaFoldersQuery)?;
        let tags = self.runtime.query(ListMediaTagsQuery)?;

        let files = Self::map_files(files);
        let folders = folders
            .into_iter()
            .flat_map(|p| p.to_str().map(|p| p.to_string()))
            .collect();
        let tags = tags.into_iter().map(MediaTag::from).collect();

        Ok(MediaFiles {
            files,
            folders: Some(MediaFolders { paths: folders }),
            tags,
        })
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub async fn import_media(&self, files: Vec<String>) -> anyhow::Result<()> {
        for file in files {
            let path = PathBuf::from(file);
            let name = path.file_name().unwrap().to_str().unwrap().to_string();
            // TODO: queue import in background
            // * report progress to status bar and
            // * display failed imports in list with error message
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
    pub fn relink_media(&self, req: RelinkMediaRequest) -> anyhow::Result<()> {
        self.api.relink_media(MediaId::try_from(req.media_id)?, PathBuf::from(req.path))?;

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
        let folders = self.runtime.query(ListMediaFoldersQuery)?;
        let folders = folders
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

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn subscribe(&self) -> impl Stream<Item = MediaFiles> {
        self.api.subscribe().into_stream().map(|db| {
            let files = Self::map_files(db.list_media().unwrap());
            let tags = db
                .list_tags()
                .unwrap()
                .into_iter()
                .map(MediaTag::from)
                .collect();

            MediaFiles {
                files,
                folders: None,
                tags,
            }
        })
    }

    fn map_files(mut files: Vec<MediaDocument>) -> Vec<MediaFile> {
        files.sort_by(|lhs, rhs| lhs.name.cmp(&rhs.name));
        files.into_iter().map(MediaFile::from).collect()
    }
}
