use std::ops::Deref;
use std::path::{Path, PathBuf};
use serde::{Deserialize, Serialize};
use mizer_ecs::*;

#[derive(Debug, Clone)]
pub struct MediaFileView {
    pub id: MediaId,
    pub path: MediaPath,
    pub status: MediaImportStatus,
    pub file_size: Option<FileSize>,
    pub media_type: Option<MediaType>,
    pub duration: Option<MediaDuration>,
    pub audio_channels: Option<AudioChannels>,
    pub sample_rate: Option<SampleRate>,
}

#[derive(Component, Debug, Default, Clone, Copy)]
pub struct MediaId(uuid::Uuid);

impl MediaId {
    pub fn new() -> Self {
        MediaId(uuid::Uuid::new_v4())
    }
}

#[derive(Component, Debug, Clone)]
pub struct MediaPath(pub PathBuf);

#[derive(Component, Default, Debug, Clone, Copy)]
pub enum MediaImportStatus {
    #[default]
    Importing,
    Success,
    FileMissing,
    UnknownFile,
    UnknownError,
}

impl Deref for MediaPath {
    type Target = PathBuf;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl AsRef<Path> for MediaPath {
    fn as_ref(&self) -> &Path {
        &self.0
    }
}

#[derive(Component, Debug, Clone, Copy)]
pub struct FileSize(pub u64);

#[derive(Component, Debug, Clone)]
pub struct ThumbnailPath(pub PathBuf);

#[derive(Component, Debug, Clone, Copy)]
pub struct MediaDimensions {
    pub width: u64,
    pub height: u64,
}

#[derive(Component, Debug, Clone, Copy)]
pub struct MediaDuration(pub u64);

#[derive(Component, Debug, Clone, Copy)]
pub struct Framerate(pub f64);

#[derive(Component, Debug, Clone, Copy)]
pub struct SampleRate(pub u32);

#[derive(Component, Debug, Clone, Copy)]
pub struct AudioChannels(pub u32);

#[derive(Component, Debug, Clone)]
pub struct MediaContentType(pub String);

#[derive(Component, Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub enum MediaType {
    Image,
    Audio,
    Video,
    Vector,
    Data,
}

#[derive(Component, Debug, Clone)]
pub struct Interpret(pub String);

#[derive(Component, Debug, Clone)]
pub struct Album(pub String);

#[derive(Component, Debug, Clone)]
pub struct Title(pub String);
