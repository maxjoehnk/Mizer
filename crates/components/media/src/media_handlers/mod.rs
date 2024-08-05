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

pub trait MediaHandler {
    const MEDIA_TYPE: MediaType;

    fn supported(content_type: &str) -> bool;

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
        let media_path = storage.get_media_path(file_path);
        if !media_path.exists() {
            self.process_file(file_path, storage)
                .context("Processing media file")?;
        }
        let metadata = self
            .read_metadata(file_path, content_type)
            .context("Reading metadata")
            .unwrap_or_else(|err| {
                tracing::warn!("Unable to read metadata for {file_path:?}: {err:?}");
                mizer_console::warn!(
                    mizer_console::ConsoleCategory::Media,
                    "Unable to read metadata for {file_path:?}"
                );

                Default::default()
            });

        Ok((Self::MEDIA_TYPE, metadata))
    }
}
