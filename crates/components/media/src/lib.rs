use std::path::{Path, PathBuf};
use std::sync::{Arc, RwLock};

use uuid::Uuid;

use crate::data_access::DataAccess;
pub use crate::discovery::MediaDiscovery;
use crate::documents::*;
use crate::file_storage::FileStorage;
use crate::import_handler::ImportFileHandler;

mod data_access;
mod discovery;
pub mod documents;
mod file_storage;
mod import_handler;
pub mod media_handlers;

#[derive(Clone)]
#[repr(transparent)]
pub struct ImportPaths(Arc<RwLock<Vec<PathBuf>>>);

impl ImportPaths {
    fn new() -> Self {
        Self(Default::default())
    }

    fn clear(&self) {
        let mut paths = self
            .0
            .write()
            .expect("Unable to lock media server import paths for writing");
        paths.clear();
    }

    pub fn set_paths(&self, paths: Vec<PathBuf>) {
        let mut handle = self
            .0
            .write()
            .expect("Unable to lock media server import paths for writing");
        *handle = paths;
    }

    pub fn paths(&self) -> Vec<PathBuf> {
        self.0.read().unwrap().clone()
    }
}

#[derive(Clone)]
pub struct MediaServer {
    storage: FileStorage,
    db: DataAccess,
    import_paths: ImportPaths,
}

impl MediaServer {
    pub fn new() -> anyhow::Result<Self> {
        let db = DataAccess::new()?;
        let storage = FileStorage::new()?;
        let import_paths = ImportPaths::new();

        Ok(Self {
            storage,
            db,
            import_paths,
        })
    }

    pub fn set_import_paths(&self, paths: Vec<PathBuf>) {
        self.import_paths.set_paths(paths);
    }

    pub fn get_import_paths(&self) -> Vec<PathBuf> {
        self.import_paths.paths()
    }

    pub fn create_tag(&self, name: String) -> anyhow::Result<TagDocument> {
        let document = self.db.add_tag(TagCreateModel { name })?;

        Ok(document)
    }

    pub fn clear(&self) {
        if let Err(err) = self.db.clear() {
            log::error!("Error clearing files: {err:?}");
        }
        self.import_paths.clear();
    }

    pub fn import_tags(&self, tags: Vec<TagDocument>) -> anyhow::Result<()> {
        self.db.import_tags(tags)
    }

    pub fn import_files(&self, files: Vec<MediaDocument>) -> anyhow::Result<()> {
        self.db.import_media(files)
    }

    pub fn get_tags(&self) -> anyhow::Result<Vec<TagDocument>> {
        self.db.list_tags()
    }

    pub fn get_media(&self) -> anyhow::Result<Vec<MediaDocument>> {
        self.db.list_media()
    }

    pub async fn import_file(
        &self,
        model: MediaCreateModel,
        file_path: PathBuf,
        relative_to: Option<&Path>,
    ) -> anyhow::Result<Option<MediaDocument>> {
        let file_handler = ImportFileHandler::new(self.db.clone(), self.storage.clone());

        match file_handler
            .import_file(model, &file_path, relative_to)
            .await
        {
            Ok(document) => Ok(document),
            Err(err) => {
                log::error!("Error importing file {err:?}");
                Err(err)
            }
        }
    }
}

#[derive(Debug, Clone)]
pub struct MediaCreateModel {
    pub name: String,
    pub tags: Vec<AttachedTag>,
}

#[derive(Debug, Clone)]
pub struct TagCreateModel {
    pub name: String,
}

impl From<TagCreateModel> for TagDocument {
    fn from(model: TagCreateModel) -> Self {
        TagDocument {
            id: Uuid::new_v4(),
            name: model.name,
            media: Vec::new(),
        }
    }
}
