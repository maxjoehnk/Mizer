use crate::api::{MediaCreateModel, MediaServerApi, MediaServerCommand};
use crate::data_access::DataAccess;
use crate::documents::MediaDocument;
use crate::file_storage::FileStorage;
use crate::media_handlers::*;
use std::path::{Path, PathBuf};
use tokio::io::AsyncReadExt;
use tokio::stream::StreamExt;
use uuid::Uuid;

pub use crate::discovery::MediaDiscovery;

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
}

impl MediaServer {
    pub async fn new() -> anyhow::Result<Self> {
        let context = DataAccess::new("mongodb://localhost:27017").await?;
        let file_storage = FileStorage::new()?;
        let import_file = ImportFileHandler::new(context.clone(), file_storage.clone());

        Ok(MediaServer {
            db: context,
            file_storage,
            import_file,
        })
    }

    pub fn open_api(self, handle: &tokio::runtime::Handle) -> anyhow::Result<MediaServerApi> {
        let (tx, rx) = flume::unbounded();
        let file_storage = self.file_storage.clone();

        handle.spawn(async move {
            let mut stream = rx.into_stream();
            while let Some(command) = stream.next().await {
                match command {
                    MediaServerCommand::ImportFile(model, file_path, resp) => {
                        let document = self
                            .import_file
                            .import_file(model, &file_path)
                            .await
                            .unwrap();
                        resp.send(document).unwrap();
                    }
                    MediaServerCommand::CreateTag(model, resp) => {
                        let document = self.db.add_tag(model).await.unwrap();
                        resp.send(document).unwrap();
                    }
                    MediaServerCommand::GetTags(resp) => {
                        let documents = self.db.list_tags().await.unwrap();
                        resp.send(documents).unwrap();
                    }
                }
            }
        });

        Ok(MediaServerApi(tx, file_storage))
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
        let mut temp_file = tokio::fs::File::open(file_path).await?;
        let mut buffer = [0u8; 256];
        temp_file.read(&mut buffer).await?;
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

        let media = self
            .db
            .add_media(MediaDocument {
                id,
                content_type: content_type.to_string(),
                name: model.name,
                tags: model.tags,
            })
            .await?;

        Ok(media)
    }
}
