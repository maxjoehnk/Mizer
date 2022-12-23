use mizer_media::api::{MediaServerApi, MediaServerCommand, TagCreateModel};

use crate::models::media::*;

#[derive(Clone)]
pub struct MediaHandler {
    api: MediaServerApi,
}

impl MediaHandler {
    pub fn new(api: MediaServerApi) -> Self {
        Self { api }
    }

    pub async fn create_tag(&self, name: String) -> anyhow::Result<MediaTag> {
        let (sender, receiver) = MediaServerApi::open_channel();
        let cmd = MediaServerCommand::CreateTag(TagCreateModel { name }, sender);
        self.api.send_command(cmd);

        let document = receiver.recv_async().await?;

        Ok(document.into())
    }

    pub async fn get_tags_with_media(&self) -> anyhow::Result<GroupedMediaFiles> {
        let (sender, receiver) = MediaServerApi::open_channel();
        let cmd = MediaServerCommand::GetTags(sender);
        self.api.send_command(cmd);

        let tags = receiver.recv_async().await?;
        let tags = tags.into_iter().map(MediaTagWithFiles::from).collect();

        Ok(GroupedMediaFiles {
            tags,
            ..Default::default()
        })
    }

    pub async fn get_media(&self) -> anyhow::Result<MediaFiles> {
        let (sender, receiver) = MediaServerApi::open_channel();
        let cmd = MediaServerCommand::GetMedia(sender);
        self.api.send_command(cmd);

        let files = receiver.recv_async().await.unwrap();
        let files = files.into_iter().map(MediaFile::from).collect();

        Ok(MediaFiles {
            files,
            ..Default::default()
        })
    }
}
