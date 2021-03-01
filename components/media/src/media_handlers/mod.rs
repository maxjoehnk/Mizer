use std::path::Path;

pub use audio_handler::AudioHandler;
pub use image_handler::ImageHandler;
pub use svg_handler::SvgHandler;
pub use video_handler::VideoHandler;

use crate::file_storage::FileStorage;

mod audio_handler;
mod image_handler;
mod svg_handler;
mod video_handler;

pub const THUMBNAIL_SIZE: u32 = 200;

pub trait MediaHandler {
    fn supported(content_type: &str) -> bool;

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        file: P,
        storage: &FileStorage,
        content_type: &str,
    ) -> anyhow::Result<()>;

    fn process_file<P: AsRef<Path>>(&self, file: P, storage: &FileStorage) -> anyhow::Result<()> {
        let target = storage.get_media_path(&file);
        std::fs::copy(file, &target)?;

        Ok(())
    }

    fn handle_file<P: AsRef<Path>>(
        &self,
        file_path: P,
        storage: &FileStorage,
        content_type: &str,
    ) -> anyhow::Result<()> {
        let thumbnail_path = storage.get_thumbnail_path(&file_path);
        if !thumbnail_path.exists() {
            self.generate_thumbnail(&file_path, storage, content_type)?;
        }
        let media_path = storage.get_media_path(&file_path);
        if !media_path.exists() {
            self.process_file(&file_path, storage)?;
        }

        Ok(())
    }
}
