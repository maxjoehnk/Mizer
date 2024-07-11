use std::path::{Path, PathBuf};
use std::sync::{Arc, RwLock};

use mizer_message_bus::{MessageBus, Subscriber};
use mizer_settings::Settings;
use mizer_status_bus::StatusHandle;
pub use module::MediaModule;

use crate::data_access::DataAccess;
pub use crate::discovery::MediaDiscovery;
use crate::documents::*;
use crate::events::MediaEvent;
use crate::file_storage::FileStorage;
use crate::import_handler::ImportFileHandler;

mod background_media_job;
mod data_access;
mod discovery;
pub mod documents;
mod events;
mod file_storage;
mod import_handler;
pub mod media_handlers;
mod module;
pub mod queries;
mod thumbnail_generator;
mod project_loading;

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

    pub fn add_path(&self, path: PathBuf) {
        let mut paths = self
            .0
            .write()
            .expect("Unable to lock media server import paths for writing");
        paths.push(path);
    }

    pub fn remove_path(&self, path: PathBuf) {
        let mut paths = self
            .0
            .write()
            .expect("Unable to lock media server import paths for writing");
        paths.retain(|p| p != &path);
    }
}

#[derive(Clone)]
pub struct MediaServer {
    storage: FileStorage,
    db: DataAccess,
    import_paths: ImportPaths,
    status_bus: StatusHandle,
    event_bus: MessageBus<MediaEvent>,
}

impl MediaServer {
    pub fn new(status_bus: StatusHandle, settings: Settings) -> anyhow::Result<Self> {
        let db = DataAccess::new()?;
        let storage = FileStorage::new(settings.paths.media_storage)?;
        let import_paths = ImportPaths::new();

        Ok(Self {
            status_bus,
            storage,
            db,
            import_paths,
            event_bus: MessageBus::new(),
        })
    }

    pub fn set_import_paths(&self, paths: Vec<PathBuf>) {
        self.import_paths.set_paths(paths);
    }

    pub fn get_import_paths(&self) -> Vec<PathBuf> {
        self.import_paths.paths()
    }

    pub async fn add_import_path(&self, path: PathBuf) {
        self.import_paths.add_path(path.clone());
        let api = self.clone();

        tokio::spawn(async move {
            let discovery = MediaDiscovery::new(api, path).discover().await;
            if let Err(err) = discovery {
                tracing::error!("Error discovering media files: {err:?}");
            }
        });
    }

    pub fn remove_import_path(&self, path: PathBuf) {
        self.import_paths.remove_path(path);
    }

    pub fn create_tag(&self, name: String) -> anyhow::Result<MediaTag> {
        let document = self.db.add_tag(TagCreateModel { name })?;

        Ok(document)
    }

    pub fn remove_tag(&self, id: TagId) {
        self.db.remove_tag(id);
    }

    pub fn clear(&self) {
        if let Err(err) = self.db.clear() {
            tracing::error!("Error clearing files: {err:?}");
        }
        self.import_paths.clear();
    }

    pub fn import_tags(&self, tags: Vec<MediaTag>) -> anyhow::Result<()> {
        self.db.import_tags(tags)
    }

    pub fn import_files(&self, files: Vec<MediaDocument>) -> anyhow::Result<()> {
        for file in &files {
            self.event_bus.send(MediaEvent::FileAdded(file.id));
        }
        self.db.import_media(files)
    }

    pub fn get_tags(&self) -> anyhow::Result<Vec<MediaTag>> {
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
        let file_handler = ImportFileHandler::new(
            self.db.clone(),
            self.storage.clone(),
            self.status_bus.clone(),
        );

        match file_handler
            .import_file(model, &file_path, relative_to)
            .await
        {
            Ok(Some(document)) => {
                self.event_bus.send(MediaEvent::FileAdded(document.id));

                Ok(Some(document))
            }
            Ok(None) => Ok(None),
            Err(err) => {
                tracing::error!("Error importing file {err:?}");
                mizer_console::error!(
                    mizer_console::ConsoleCategory::Media,
                    "Error importing file '{}'",
                    file_path.display()
                );
                Err(err)
            }
        }
    }

    pub fn relink_media(&self, id: MediaId, path: PathBuf) -> anyhow::Result<()> {
        self.db.relink_media(id, path)?;
        self.event_bus.send(MediaEvent::FileUpdated(id));

        Ok(())
    }

    pub fn get_media_file(&self, id: impl AsRef<MediaId>) -> Option<MediaDocument> {
        self.db.get_media(id.as_ref())
    }

    pub fn remove_file(&self, id: MediaId) {
        self.db.remove_media(id);
    }

    pub fn add_tag_to_media(&self, media_id: MediaId, tag_id: TagId) -> anyhow::Result<()> {
        self.db.add_tag_to_media(media_id, tag_id)
    }

    pub fn remove_tag_from_media(&self, media_id: MediaId, tag_id: TagId) -> anyhow::Result<()> {
        self.db.remove_tag_from_media(media_id, tag_id)
    }

    pub fn subscribe(&self) -> Subscriber<DataAccess> {
        self.db.bus.subscribe()
    }
}

#[derive(Debug, Clone)]
pub struct MediaCreateModel {
    pub name: String,
    pub tags: Vec<MediaTag>,
}

#[derive(Debug, Clone)]
pub struct TagCreateModel {
    pub name: String,
}

impl From<TagCreateModel> for MediaTag {
    fn from(model: TagCreateModel) -> Self {
        MediaTag {
            id: TagId::new(),
            name: model.name,
        }
    }
}
