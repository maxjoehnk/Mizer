use std::path::Path;

use anyhow::Context;
use tokio::fs;
use tokio::io::AsyncReadExt;
use uuid::Uuid;

use crate::data_access::DataAccess;
use crate::documents::*;
use crate::file_storage::FileStorage;
use crate::media_handlers::*;
use crate::MediaCreateModel;

#[derive(Clone)]
pub struct ImportFileHandler {
    db: DataAccess,
    file_storage: FileStorage,
    video_handler: VideoHandler,
    image_handler: ImageHandler,
    audio_handler: AudioHandler,
    svg_handler: SvgHandler,
}

impl ImportFileHandler {
    pub(crate) fn new(db: DataAccess, file_storage: FileStorage) -> Self {
        ImportFileHandler {
            db,
            file_storage,
            video_handler: VideoHandler,
            image_handler: ImageHandler,
            audio_handler: AudioHandler,
            svg_handler: SvgHandler,
        }
    }

    pub(crate) async fn import_file(
        &self,
        model: MediaCreateModel,
        file_path: &Path,
        relative_to: Option<&Path>,
    ) -> anyhow::Result<Option<MediaDocument>> {
        log::debug!("importing file {:?}", file_path);
        let source_path = relative_to
            .map(|base_path| file_path.strip_prefix(base_path))
            .transpose()?
            .map(|path| path.to_path_buf());
        if let Some(source_path) = source_path.as_ref() {
            if self.db.contains_source(source_path)? {
                log::debug!("File already imported {file_path:?}");

                return Ok(None);
            }
        }
        let id = Uuid::new_v4();
        let mut file = fs::File::open(file_path).await?;
        let file_size = file.metadata().await?.len();
        let mut buffer = [0u8; 256];
        file.read_exact(&mut buffer).await?;
        let content_type = infer::get(&buffer)
            .ok_or_else(|| anyhow::anyhow!("Unknown file type"))?
            .mime_type();
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

        Ok(Some(media))
    }
}
