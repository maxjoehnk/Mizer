use std::fs;
use std::io::{Read, Write};
use std::path::{Path, PathBuf};

use uuid::Uuid;

const DEFAULT_MEDIA_PATH: &str = "media";
const DEFAULT_THUMBNAIL_PATH: &str = "thumbnails";
const DEFAULT_TMP_PATH: &str = "tmp";

#[derive(Debug, Clone)]
pub struct FileStorage {
    temp_path: PathBuf,
    media_path: PathBuf,
    thumbnail_path: PathBuf,
}

impl FileStorage {
    pub fn new(base_path: PathBuf) -> anyhow::Result<FileStorage> {
        let base_path = PathBuf::from(shellexpand::full(base_path.to_str().unwrap())?.into_owned());
        let media_path = base_path.join(DEFAULT_MEDIA_PATH);
        let thumbnail_path = base_path.join(DEFAULT_THUMBNAIL_PATH);
        let temp_path = base_path.join(DEFAULT_TMP_PATH);
        fs::create_dir_all(&media_path)?;
        fs::create_dir_all(&thumbnail_path)?;
        fs::create_dir_all(&temp_path)?;

        Ok(FileStorage {
            media_path,
            thumbnail_path,
            temp_path,
        })
    }

    pub fn store_temp_file(&self, id: Uuid, buffer: &[u8]) -> anyhow::Result<()> {
        let file_path = self.get_temp_file_path(id);
        let mut file = fs::File::create(file_path)?;

        file.write_all(buffer)?;

        Ok(())
    }

    pub fn create_temp_file(&self) -> PathBuf {
        self.get_temp_file_path(Uuid::new_v4())
    }

    pub fn get_temp_file_path(&self, id: Uuid) -> PathBuf {
        self.temp_path.join(id.to_string())
    }

    pub fn get_media_path<P: AsRef<Path>>(&self, path: P) -> PathBuf {
        self.media_path.join(path.as_ref().file_name().unwrap())
    }

    // TODO: use content hash as thumbnail filename
    pub fn get_thumbnail_path<P: AsRef<Path>>(&self, path: P) -> PathBuf {
        let mut target = self.thumbnail_path.join(path.as_ref().file_name().unwrap());
        target.set_extension("png");

        target
    }

    pub fn read_thumbnail(&self, id: &str) -> anyhow::Result<Vec<u8>> {
        let path = self.get_thumbnail_path(id);
        let mut file = fs::File::open(path)?;
        let mut buffer = Vec::new();

        file.read_to_end(&mut buffer)?;

        Ok(buffer)
    }
}
