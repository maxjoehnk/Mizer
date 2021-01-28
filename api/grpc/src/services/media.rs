use crate::protos::{MediaApi, MediaTagWithFiles};
use grpc::{ServerHandlerContext, ServerResponseUnarySink, ServerRequestSingle};
use crate::protos::{MediaFile, CreateMediaTag, GetMediaTags, GroupedMediaFiles, MediaTag};
use mizer_media::documents::{TagDocument, AttachedTag, MediaDocument, AttachedMediaDocument};
use protobuf::SingularPtrField;
use mizer_media::api::{MediaServerApi, MediaServerCommand, TagCreateModel};

pub struct MediaApiImpl {
    api: MediaServerApi
}

impl MediaApiImpl {
    pub fn new(api: MediaServerApi) -> Self {
        MediaApiImpl {
            api
        }
    }
}

impl MediaApi for MediaApiImpl {
    fn create_tag(&self, o: ServerHandlerContext, req: ServerRequestSingle<CreateMediaTag>, resp: ServerResponseUnarySink<MediaTag>) -> grpc::Result<()> {
        let api = self.api.clone();
        o.spawn(async move {
            let (sender, receiver) = MediaServerApi::open_channel();
            let cmd = MediaServerCommand::CreateTag(req.message.into(), sender);
            api.send_command(cmd);

            let document = receiver.recv_async().await.unwrap();

            resp.finish(document.into())
        });

        Ok(())
    }

    fn get_tags_with_media(&self, o: ServerHandlerContext, req: ServerRequestSingle<GetMediaTags>, resp: ServerResponseUnarySink<GroupedMediaFiles>) -> grpc::Result<()> {
        let api = self.api.clone();
        o.spawn(async move {
            let (sender, receiver) = MediaServerApi::open_channel();
            let cmd = MediaServerCommand::GetTags(sender);
            api.send_command(cmd);

            let tags = receiver.recv_async().await.unwrap();
            let tags = tags.into_iter().map(MediaTagWithFiles::from).collect::<Vec<_>>();

            resp.finish(GroupedMediaFiles {
                tags: tags.into(),
                ..Default::default()
            })
        });

        Ok(())
    }
}

impl From<CreateMediaTag> for TagCreateModel {
    fn from(model: CreateMediaTag) -> Self {
        TagCreateModel {
            name: model.name
        }
    }
}

impl From<TagDocument> for MediaTag {
    fn from(tag: TagDocument) -> Self {
        MediaTag {
            name: tag.name,
            id: tag.id.to_string(),
            ..Default::default()
        }
    }
}

impl From<MediaDocument> for MediaFile {
    fn from(media: MediaDocument) -> Self {
        MediaFile {
            id: media.id.to_string(),
            name: media.name,
            tags: media.tags.into_iter().map(MediaTag::from).collect::<Vec<_>>().into(),
            contentUrl: format!("http://localhost:50050/media/{}.mp4", media.id),
            thumbnailUrl: format!("http://localhost:50050/thumbnails/{}.png", media.id),
            ..Default::default()
        }
    }
}

impl From<AttachedTag> for MediaTag {
    fn from(tag: AttachedTag) -> Self {
        MediaTag {
            id: tag.id.to_string(),
            name: tag.name,
            ..Default::default()
        }
    }
}

impl From<MediaTag> for AttachedTag {
    fn from(tag: MediaTag) -> Self {
        AttachedTag {
            id: tag.id.parse().unwrap(),
            name: tag.name,
        }
    }
}

impl From<TagDocument> for MediaTagWithFiles {
    fn from(tag: TagDocument) -> Self {
        MediaTagWithFiles {
            tag: SingularPtrField::some(MediaTag {
                name: tag.name,
                id: tag.id.to_string(),
                ..Default::default()
            }),
            files: tag.media.into_iter().map(MediaFile::from).collect::<Vec<_>>().into(),
            ..Default::default()
        }
    }
}

impl From<AttachedMediaDocument> for MediaFile {
    fn from(media: AttachedMediaDocument) -> Self {
        let document = match media {
            AttachedMediaDocument::Video(media) => media,
            AttachedMediaDocument::Image(media) => media,
        };

        MediaFile {
            id: document.id.to_string(),
            name: document.name,
            contentUrl: format!("http://localhost:50050/media/{}.mp4", document.id),
            thumbnailUrl: format!("http://localhost:50050/thumbnails/{}.png", document.id),
            ..Default::default()
        }
    }
}
