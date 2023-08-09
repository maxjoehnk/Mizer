use mizer_media::documents::{AttachedMediaDocument, AttachedTag, MediaDocument, TagDocument};
use mizer_media::TagCreateModel;

use crate::proto::media::*;

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
        MediaFile {
            id: media.id.to_string(),
            name: media.name,
            metadata: Some(MediaMetadata {
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
            thumbnail_path: media
                .metadata
                .thumbnail_path
                .and_then(|path| path.as_os_str().to_str().map(|path| path.to_string())),
            r#type: MediaType::from(media.media_type) as i32,
        }
    }
}

impl From<mizer_media::documents::MediaType> for MediaType {
    fn from(value: mizer_media::documents::MediaType) -> Self {
        use mizer_media::documents::MediaType::*;

        match value {
            Image => Self::Image,
            Audio => Self::Audio,
            Video => Self::Video,
            Vector => Self::Vector,
        }
    }
}

impl From<AttachedTag> for MediaTag {
    fn from(tag: AttachedTag) -> Self {
        MediaTag {
            id: tag.id.to_string(),
            name: tag.name,
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
            tag: Some(MediaTag {
                name: tag.name,
                id: tag.id.to_string(),
            }),
            files: tag.media.into_iter().map(MediaFile::from).collect(),
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
            ..Default::default()
        }
    }
}
