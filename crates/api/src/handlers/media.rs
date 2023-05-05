use mizer_media::MediaServer;

use crate::models::media::*;

#[derive(Clone)]
pub struct MediaHandler {
    api: MediaServer,
}

impl MediaHandler {
    pub fn new(api: MediaServer) -> Self {
        Self { api }
    }

    #[tracing::instrument(skip(self))]
    pub fn create_tag(&self, name: String) -> anyhow::Result<MediaTag> {
        let document = self.api.create_tag(name)?;

        Ok(document.into())
    }

    #[tracing::instrument(skip(self))]
    pub fn get_tags_with_media(&self) -> anyhow::Result<GroupedMediaFiles> {
        let tags = self.api.get_tags()?;
        let tags = tags.into_iter().map(MediaTagWithFiles::from).collect();

        Ok(GroupedMediaFiles {
            tags,
            ..Default::default()
        })
    }

    #[tracing::instrument(skip(self))]
    pub fn get_media(&self) -> anyhow::Result<MediaFiles> {
        let files = self.api.get_media()?;
        let files = files.into_iter().map(MediaFile::from).collect();

        Ok(MediaFiles {
            files,
            ..Default::default()
        })
    }
}
