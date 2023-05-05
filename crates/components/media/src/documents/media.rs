use serde::{Deserialize, Serialize};
use std::path::PathBuf;
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct MediaDocument {
    pub id: Uuid,
    pub filename: String,
    pub name: String,
    pub tags: Vec<AttachedTag>,
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
    pub dimensions: Option<(u64, u64)>,
    /// Playback length in seconds
    pub duration: Option<u64>,
    pub framerate: Option<f64>,
    pub name: Option<String>,
    pub artist: Option<String>,
    pub album: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct AttachedTag {
    pub id: Uuid,
    pub name: String,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq)]
pub enum MediaType {
    Image,
    Audio,
    Video,
    Vector,
}
