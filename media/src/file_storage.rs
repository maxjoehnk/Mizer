use uuid::Uuid;
use std::fs;
use std::path::{PathBuf, Path};
use std::io::{Write, Read};

const DEFAULT_MEDIA_PATH: &str = ".storage/media";
const DEFAULT_THUMBNAIL_PATH: &str = ".storage/thumbnails";
const DEFAULT_TMP_PATH: &str = ".storage/tmp";

#[derive(Debug, Clone)]
pub struct FileStorage {
    temp_path: String,
    media_path: String,
    thumbnail_path: String
}

impl FileStorage {
    pub fn new() -> anyhow::Result<FileStorage> {
        fs::create_dir_all(DEFAULT_MEDIA_PATH)?;
        fs::create_dir_all(DEFAULT_THUMBNAIL_PATH)?;
        fs::create_dir_all(DEFAULT_TMP_PATH)?;

        Ok(FileStorage {
            media_path: String::from(DEFAULT_MEDIA_PATH),
            thumbnail_path: String::from(DEFAULT_THUMBNAIL_PATH),
            temp_path: String::from(DEFAULT_TMP_PATH),
        })
    }

    pub fn store_file(&self, id: Uuid, buffer: &[u8]) -> anyhow::Result<()> {
        let file_path = self.get_temp_file_path(id);
        let mut file = fs::File::create(&file_path)?;

        file.write(buffer)?;

        Ok(())
    }

    pub fn create_temp_file(&self) -> PathBuf {
        self.get_temp_file_path(Uuid::new_v4())
    }

    pub fn get_temp_file_path(&self, id: Uuid) -> PathBuf {
        let mut target = PathBuf::new();
        target.push(&self.temp_path);
        target.push(id.to_string());

        target
    }

    pub fn get_media_path<P: AsRef<Path>>(&self, path: P) -> PathBuf {
        let mut target = PathBuf::new();
        target.push(&self.media_path);
        target.push(path.as_ref().file_name().unwrap());
        target.set_extension("mp4");

        target
    }

    pub fn get_thumbnail_path<P: AsRef<Path>>(&self, path: P) -> PathBuf {
        let mut target = PathBuf::new();
        target.push(&self.thumbnail_path);
        target.push(path.as_ref().file_name().unwrap());
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
