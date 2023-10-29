use std::path::PathBuf;

use serde::{Deserialize, Serialize};

use crate::documents::{MediaId, MediaTag};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct MediaDocument {
    pub id: MediaId,
    pub filename: String,
    pub name: String,
    pub tags: Vec<MediaTag>,
    pub content_type: String,
    pub media_type: MediaType,
    pub file_path: PathBuf,
    pub source_path: Option<PathBuf>,
    /// File size in bytes
    pub file_size: u64,
    pub metadata: MediaMetadata,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct MediaMetadata {
    pub thumbnail_path: Option<PathBuf>,
    pub dimensions: Option<(u64, u64)>,
    /// Playback length in seconds
    pub duration: Option<u64>,
    pub framerate: Option<f64>,
    pub name: Option<String>,
    pub artist: Option<String>,
    pub album: Option<String>,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub enum MediaType {
    Image,
    Audio,
    Video,
    Vector,
}
