use std::path::Path;

use crate::file_storage::FileStorage;
use crate::media_handlers::MediaHandler;

pub struct AudioHandler;

impl MediaHandler for AudioHandler {
    fn supported(content_type: &str) -> bool {
        content_type.starts_with("audio")
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        _file: P,
        _storage: &FileStorage,
        _content_type: &str,
    ) -> anyhow::Result<()> {
        Ok(())
    }
}
