use std::path::Path;

use protobuf::{EnumOrUnknown, MessageField};

use mizer_media::documents::{AttachedMediaDocument, AttachedTag, MediaDocument, TagDocument};
use mizer_media::TagCreateModel;

use crate::models::media::*;

impl From<CreateMediaTag> for TagCreateModel {
    fn from(model: CreateMediaTag) -> Self {
        TagCreateModel { name: model.name }
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
        let thumbnail_path = Path::new(&media.filename).with_extension("png");
        let thumbnail_path = thumbnail_path.as_os_str().to_str().unwrap();
        let content_url = format!("http://localhost:50050/media/{}", media.filename);

        MediaFile {
            id: media.id.to_string(),
            name: media.name,
            metadata: MessageField::some(MediaMetadata {
                tags: media.tags.into_iter().map(MediaTag::from).collect(),
                file_size: media.file_size,
                source_path: media
                    .source_path
                    .and_then(|path| path.to_str().map(|path| path.to_string()))
                    .unwrap_or_default(),
                dimensions: media
                    .metadata
                    .dimensions
                    .map(|(width, height)| media_metadata::Dimensions {
                        width,
                        height,
                        ..Default::default()
                    })
                    .into(),
                duration: media.metadata.duration,
                framerate: media.metadata.framerate,
                album: media.metadata.album,
                artist: media.metadata.artist,
                ..Default::default()
            }),
            content_url,
            thumbnail_url: format!("http://localhost:50050/thumbnails/{}", thumbnail_path),
            type_: EnumOrUnknown::new(media.media_type.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_media::documents::MediaType> for MediaType {
    fn from(value: mizer_media::documents::MediaType) -> Self {
        use mizer_media::documents::MediaType::*;

        match value {
            Image => Self::IMAGE,
            Audio => Self::AUDIO,
            Video => Self::VIDEO,
            Vector => Self::VECTOR,
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
            tag: MessageField::some(MediaTag {
                name: tag.name,
                id: tag.id.to_string(),
                ..Default::default()
            }),
            files: tag.media.into_iter().map(MediaFile::from).collect(),
            ..Default::default()
        }
    }
}

impl From<AttachedMediaDocument> for MediaFile {
    fn from(media: AttachedMediaDocument) -> Self {
        let document = match media {
            AttachedMediaDocument::Video(media) => media,
            AttachedMediaDocument::Image(media) => media,
            AttachedMediaDocument::Audio(media) => media,
            AttachedMediaDocument::Vector(media) => media,
        };

        MediaFile {
            id: document.id.to_string(),
            name: document.name,
            content_url: format!("http://localhost:50050/media/{}.mp4", document.id),
            thumbnail_url: format!("http://localhost:50050/thumbnails/{}.png", document.id),
            ..Default::default()
        }
    }
}
