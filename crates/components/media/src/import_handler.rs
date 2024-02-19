use std::path::Path;
use std::time::Duration;

use anyhow::Context;
use tokio::fs;
use tokio::io::AsyncReadExt;

use mizer_status_bus::StatusHandle;

use crate::data_access::DataAccess;
use crate::documents::*;
use crate::file_storage::FileStorage;
use crate::media_handlers::*;
use crate::MediaCreateModel;

#[derive(Clone)]
pub struct ImportFileHandler {
    db: DataAccess,
    file_storage: FileStorage,
    status_bus: StatusHandle,
    video_handler: VideoHandler,
    image_handler: ImageHandler,
    audio_handler: AudioHandler,
    svg_handler: SvgHandler,
    data_handler: DataHandler,
}

impl ImportFileHandler {
    pub(crate) fn new(db: DataAccess, file_storage: FileStorage, status_bus: StatusHandle) -> Self {
        ImportFileHandler {
            db,
            file_storage,
            status_bus,
            video_handler: VideoHandler,
            image_handler: ImageHandler,
            audio_handler: AudioHandler,
            svg_handler: SvgHandler::new(),
            data_handler: DataHandler,
        }
    }

    pub(crate) async fn import_file(
        &self,
        model: MediaCreateModel,
        file_path: &Path,
        relative_to: Option<&Path>,
    ) -> anyhow::Result<Option<MediaDocument>> {
        log::debug!("importing file {:?}", file_path);
        self.status_bus
            .add_message(format!("Importing file {file_path:?}"), None);
        let source_path = relative_to
            .map(|base_path| file_path.strip_prefix(base_path))
            .or(Some(Ok(file_path)))
            .transpose()?
            .map(|path| path.to_path_buf());
        if let Some(source_path) = source_path.as_ref() {
            if self.db.contains_source(source_path)? {
                log::debug!("File already imported {file_path:?}");

                return Ok(None);
            }
        }
        let id = MediaId::new();
        let mut file = fs::File::open(file_path).await?;
        let file_size = file.metadata().await?.len();
        let content_type = if file_size < 256 {
            let mut buffer = vec![0u8; file_size as usize];
            file.read_to_end(&mut buffer).await?;

            infer::get(&buffer)
        } else {
            let mut buffer = [0u8; 256];
            file.read_exact(&mut buffer).await?;

            infer::get(&buffer)
        };
        let mime = mime_guess::from_path(file_path).first();
        let content_type = content_type
            .map(|content_type| content_type.mime_type())
            .or_else(|| mime.as_ref().map(|mime| mime.essence_str()))
            .ok_or_else(|| anyhow::anyhow!("Unknown file type"))?;
        log::debug!("got {} content type for {:?}", content_type, model);

        let (media_type, metadata) = if VideoHandler::supported(content_type) {
            self.video_handler
                .handle_file(file_path, &self.file_storage, content_type)
                .context(format!("Handling file {file_path:?}"))?
        } else if ImageHandler::supported(content_type) {
            self.image_handler
                .handle_file(file_path, &self.file_storage, content_type)
                .context(format!("Handling file {file_path:?}"))?
        } else if AudioHandler::supported(content_type) {
            self.audio_handler
                .handle_file(file_path, &self.file_storage, content_type)
                .context(format!("Handling file {file_path:?}"))?
        } else if SvgHandler::supported(content_type) {
            self.svg_handler
                .handle_file(file_path, &self.file_storage, content_type)
                .context(format!("Handling file {file_path:?}"))?
        } else if DataHandler::supported(content_type) {
            self.data_handler
                .handle_file(file_path, &self.file_storage, content_type)
                .context(format!("Handling file {file_path:?}"))?
        } else {
            anyhow::bail!("unsupported file")
        };

        let media = self.db.add_media(MediaDocument {
            id,
            filename: model.name.clone(),
            content_type: content_type.to_string(),
            name: metadata.name.clone().unwrap_or(model.name),
            tags: model.tags,
            media_type,
            metadata,
            file_path: self.file_storage.get_media_path(file_path),
            source_path,
            file_size,
        })?;

        self.status_bus.add_message(
            format!("Imported file {file_path:?}"),
            Some(Duration::from_secs(10)),
        );

        Ok(Some(media))
    }
}
