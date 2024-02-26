use std::path::Path;

use anyhow::Context;

pub use audio_handler::AudioHandler;
pub use data_handler::DataHandler;
pub use image_handler::ImageHandler;
pub use svg_handler::SvgHandler;
pub use video_handler::VideoHandler;

use crate::documents::{MediaMetadata, MediaType};
use crate::file_storage::FileStorage;

mod audio_handler;
mod data_handler;
mod image_handler;
mod svg_handler;
mod video_handler;

pub const THUMBNAIL_SIZE: u32 = 512;

pub trait MediaHandler {
    const MEDIA_TYPE: MediaType;

    fn supported(content_type: &str) -> bool;

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        file: P,
        storage: &FileStorage,
        content_type: &str,
    ) -> anyhow::Result<()>;

    fn read_metadata<P: AsRef<Path>>(
        &self,
        _file: P,
        _content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        Ok(Default::default())
    }

    fn process_file<P: AsRef<Path>>(&self, file: P, storage: &FileStorage) -> anyhow::Result<()> {
        let target = storage.get_media_path(&file);
        std::fs::copy(file, target)?;

        Ok(())
    }

    fn handle_file<P: AsRef<Path>>(
        &self,
        file_path: P,
        storage: &FileStorage,
        content_type: &str,
    ) -> anyhow::Result<(MediaType, MediaMetadata)> {
        let file_path = file_path.as_ref();
        let thumbnail_path = storage.get_thumbnail_path(file_path);
        let thumbnail_path = if !thumbnail_path.exists() {
            if let Err(err) = self
                .generate_thumbnail(file_path, storage, content_type)
                .context("Generating Thumbnail")
            {
                tracing::warn!("Unable to generate thumbnail for {file_path:?}: {err:?}");
                None
            } else {
                Some(thumbnail_path)
            }
        } else {
            Some(thumbnail_path)
        };
        let media_path = storage.get_media_path(file_path);
        if !media_path.exists() {
            self.process_file(file_path, storage)
                .context("Processing media file")?;
        }
        let mut metadata = match self
            .read_metadata(file_path, content_type)
            .context("Reading metadata")
        {
            Ok(metadata) => metadata,
            Err(err) => {
                tracing::warn!("Unable to read metadata for {file_path:?}: {err:?}");

                Default::default()
            }
        };
        metadata.thumbnail_path = thumbnail_path;

        Ok((Self::MEDIA_TYPE, metadata))
    }
}
