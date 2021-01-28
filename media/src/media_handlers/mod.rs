use std::path::Path;

pub use image_handler::ImageHandler;
pub use video_handler::VideoHandler;

use crate::file_storage::FileStorage;

mod image_handler;
mod video_handler;

pub trait MediaHandler {
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
        self.generate_thumbnail(&file_path, storage, content_type)?;
        self.process_file(&file_path, storage)?;

        Ok(())
    }
}
