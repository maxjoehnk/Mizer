use crate::proto::media::*;

impl From<mizer_media::documents::MediaTag> for MediaTag {
    fn from(tag: mizer_media::documents::MediaTag) -> Self {
        Self {
            name: tag.name,
            id: tag.id.to_string(),
        }
    }
}

impl From<mizer_media::documents::MediaDocument> for MediaFile {
    fn from(media: mizer_media::documents::MediaDocument) -> Self {
        Self {
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
                    .map(|(width, height)| media_metadata::Dimensions { width, height })
                    .into(),
                duration: media.metadata.duration,
                framerate: media.metadata.framerate,
                sample_rate: media.metadata.sample_rate,
                audio_channel_count: media.metadata.audio_channels,
                album: media.metadata.album,
                artist: media.metadata.artist,
            }),
            file_path: media
                .file_path
                .as_os_str()
                .to_str()
                .map(|path| path.to_string())
                .unwrap_or_default(),
            thumbnail_path: media
                .metadata
                .thumbnail_path
                .and_then(|path| path.as_os_str().to_str().map(|path| path.to_string())),
            r#type: MediaType::from(media.media_type) as i32,
            file_available: media.file_available,
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
            Data => Self::Data,
        }
    }
}
