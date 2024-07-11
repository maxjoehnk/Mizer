use std::path::PathBuf;

use serde::{Deserialize, Serialize};

use mizer_media::documents::{MediaDocument, MediaTag};
use mizer_media::MediaServer;

use crate::{Project, ProjectManager};

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(from = "BackwardsCompatibleMedia")]
pub struct Media {
    pub import_paths: Vec<PathBuf>,
    pub files: Vec<MediaDocument>,
    pub tags: Vec<MediaTag>,
}

#[derive(Clone, Serialize, Deserialize)]
#[serde(untagged)]
enum BackwardsCompatibleMedia {
    ImportPaths(Vec<PathBuf>),
    Media {
        import_paths: Vec<PathBuf>,
        files: Vec<MediaDocument>,
        tags: Vec<MediaTag>,
    },
}

impl From<BackwardsCompatibleMedia> for Media {
    fn from(value: BackwardsCompatibleMedia) -> Self {
        match value {
            BackwardsCompatibleMedia::Media {
                import_paths,
                files,
                tags,
            } => Self {
                import_paths,
                files,
                tags,
            },
            BackwardsCompatibleMedia::ImportPaths(paths) => Self {
                import_paths: paths,
                files: Default::default(),
                tags: Default::default(),
            },
        }
    }
}
