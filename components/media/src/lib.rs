use crate::api::{MediaCreateModel, MediaServerApi, MediaServerCommand};
use crate::data_access::DataAccess;
use crate::documents::MediaDocument;
use crate::file_storage::FileStorage;
use crate::media_handlers::*;
use std::path::Path;
use uuid::Uuid;

pub use crate::discovery::MediaDiscovery;
use async_std::fs;
use flume::{Receiver, Sender};
use futures::{AsyncReadExt, StreamExt};

pub mod api;
mod data_access;
mod discovery;
pub mod documents;
mod file_storage;
pub mod http_api;
mod media_handlers;

pub struct MediaServer {
    pub db: DataAccess,
    pub file_storage: FileStorage,
    import_file: ImportFileHandler,
    command_queue: (Sender<MediaServerCommand>, Receiver<MediaServerCommand>),
}

impl MediaServer {
    pub fn new() -> anyhow::Result<Self> {
        let context = DataAccess::new()?;
        let file_storage = FileStorage::new()?;
        let import_file = ImportFileHandler::new(context.clone(), file_storage.clone());

        Ok(MediaServer {
            db: context,
            file_storage,
            import_file,
            command_queue: flume::unbounded(),
        })
    }

    pub fn get_api_handle(&self) -> MediaServerApi {
        MediaServerApi(self.command_queue.0.clone(), self.file_storage.clone())
    }

    pub async fn run_api(self) {
        let mut stream = self.command_queue.1.into_stream();
        while let Some(command) = stream.next().await {
            match command {
                MediaServerCommand::ClearFiles => {
                    self.db.clear();
                }
                MediaServerCommand::ImportFile(model, file_path, resp) => {
                    match self.import_file.import_file(model, &file_path).await {
                        Ok(document) => {
                            resp.send(Some(document)).unwrap();
                        }
                        Err(err) => {
                            log::error!("Error importing file {err:?}");
                            resp.send(None).unwrap();
                        }
                    }
                }
                MediaServerCommand::CreateTag(model, resp) => match self.db.add_tag(model) {
                    Ok(document) => resp.send(document).unwrap(),
                    Err(err) => {
                        log::error!("Error creating tag: {:?}", err);
                    }
                },
                MediaServerCommand::GetTags(resp) => match self.db.list_tags() {
                    Ok(documents) => {
                        resp.send(documents).unwrap();
                    }
                    Err(err) => {
                        log::error!("Error listing tags: {:?}", err);
                    }
                },
                MediaServerCommand::GetMedia(resp) => match self.db.list_media() {
                    Ok(documents) => {
                        resp.send(documents).unwrap();
                    }
                    Err(err) => {
                        log::error!("Error listing tags: {:?}", err);
                    }
                },
            }
        }
    }
}

pub struct ImportFileHandler {
    db: DataAccess,
    file_storage: FileStorage,
    video_handler: VideoHandler,
    image_handler: ImageHandler,
    audio_handler: AudioHandler,
    svg_handler: SvgHandler,
}

impl ImportFileHandler {
    fn new(db: DataAccess, file_storage: FileStorage) -> Self {
        ImportFileHandler {
            db,
            file_storage,
            video_handler: VideoHandler,
            image_handler: ImageHandler,
            audio_handler: AudioHandler,
            svg_handler: SvgHandler,
        }
    }

    async fn import_file(
        &self,
        model: MediaCreateModel,
        file_path: &Path,
    ) -> anyhow::Result<MediaDocument> {
        log::debug!("importing file {:?}", file_path);
        let id = Uuid::new_v4();
        let mut temp_file = fs::File::open(file_path).await?;
        let mut buffer = [0u8; 256];
        temp_file.read_exact(&mut buffer).await?;
        let content_type = infer::get(&buffer)
            .ok_or_else(|| anyhow::anyhow!("Unknown file type"))?
            .mime_type();
        log::debug!("got {} content type for {:?}", content_type, model);

        if VideoHandler::supported(content_type) {
            self.video_handler
                .handle_file(file_path, &self.file_storage, content_type)?;
        } else if ImageHandler::supported(content_type) {
            self.image_handler
                .handle_file(file_path, &self.file_storage, content_type)?;
        } else if AudioHandler::supported(content_type) {
            self.audio_handler
                .handle_file(file_path, &self.file_storage, content_type)?;
        } else if SvgHandler::supported(content_type) {
            self.svg_handler
                .handle_file(file_path, &self.file_storage, content_type)?;
        } else {
            anyhow::bail!("unsupported file")
        };

        let media = self.db.add_media(MediaDocument {
            id,
            path: file_path.to_str().unwrap().to_string(),
            content_type: content_type.to_string(),
            name: model.name,
            tags: model.tags,
        })?;

        Ok(media)
    }
}
