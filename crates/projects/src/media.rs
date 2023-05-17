use serde::{Deserialize, Serialize};
use std::path::PathBuf;

use mizer_media::documents::{MediaDocument, TagDocument};
use mizer_media::MediaServer;

use crate::{Project, ProjectManager};

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(from = "BackwardsCompatibleMedia")]
pub struct Media {
    pub import_paths: Vec<PathBuf>,
    pub files: Vec<MediaDocument>,
    pub tags: Vec<TagDocument>,
}

#[derive(Clone, Serialize, Deserialize)]
#[serde(untagged)]
enum BackwardsCompatibleMedia {
    ImportPaths(Vec<PathBuf>),
    Media {
        import_paths: Vec<PathBuf>,
        files: Vec<MediaDocument>,
        tags: Vec<TagDocument>,
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

impl ProjectManager for MediaServer {
    fn load(&self, project: &Project) -> anyhow::Result<()> {
        self.set_import_paths(project.media.import_paths.clone());
        self.import_tags(project.media.tags.clone())?;
        self.import_files(project.media.files.clone())?;

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        project.media.import_paths = self.get_import_paths();
        // TODO: extend ProjectManager trait with Result for save method
        project.media.files = self.get_media().unwrap_or_default();
        project.media.tags = self.get_tags().unwrap_or_default();
    }

    fn clear(&self) {
        MediaServer::clear(self);
    }
}