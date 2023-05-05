use anyhow::Context;
use fs2::FileExt;
use std::fs::File;
use std::io::SeekFrom;
use std::io::{self, Seek};
use std::path::{Path, PathBuf};
use std::time::SystemTime;

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy)]
pub struct ProjectHistory;

impl ProjectHistory {
    fn folder(&self) -> anyhow::Result<PathBuf> {
        let project_dirs = directories_next::ProjectDirs::from("live.mizer", "Max Jöhnk", "Mizer")
            .ok_or_else(|| anyhow::anyhow!("Unknown data dir"))?;
        let data_dir = project_dirs.data_local_dir().to_path_buf();

        Ok(data_dir)
    }

    pub fn load(&self) -> anyhow::Result<Vec<ProjectHistoryItem>> {
        let file = self.folder()?.join("history.json");
        if !file.exists() {
            Ok(Default::default())
        } else {
            let mut file = HistoryFile::open(file)?;
            let history = self.read_file(&mut file)?;

            Ok(history)
        }
    }

    fn read_file(&self, file: &mut impl io::Read) -> anyhow::Result<Vec<ProjectHistoryItem>> {
        let history = serde_json::from_reader(file)?;

        Ok(history)
    }

    pub fn add_project(&self, project_path: impl AsRef<Path>) -> anyhow::Result<()> {
        let project_path = project_path.as_ref();
        let folder = self.folder()?;
        std::fs::create_dir_all(&folder)?;
        let history_path = folder.join("history.json");
        let history_path_exists = history_path.exists();
        let mut file = HistoryFile::create(history_path).context("opening file")?;
        let mut history = if history_path_exists {
            let history = self
                .read_file(&mut file)
                .context("reading existing history")?;
            file.seek(SeekFrom::Start(0))
                .context("seeking back to start of file")?;

            history
        } else {
            Default::default()
        };
        if let Some(history_item) = history.iter_mut().find(|i| i.path == project_path) {
            history_item.load_count += 1;
            history_item.last_loaded_at = SystemTime::now();
        } else {
            history.push(ProjectHistoryItem {
                path: project_path.to_path_buf(),
                load_count: 1,
                last_loaded_at: SystemTime::now(),
            });
        }
        history.sort_by_key(|i| i.last_loaded_at);
        history.reverse();
        history.truncate(10);
        file.truncate()?;
        serde_json::to_writer(&mut file, &history).context("writing to file")?;

        Ok(())
    }
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ProjectHistoryItem {
    pub path: PathBuf,
    load_count: u32,
    last_loaded_at: SystemTime,
}

struct HistoryFile(File);

impl HistoryFile {
    pub fn open(path: impl AsRef<Path>) -> anyhow::Result<Self> {
        let file = File::open(path)?;
        file.lock_shared()?;

        Ok(Self(file))
    }

    pub fn create(path: impl AsRef<Path>) -> anyhow::Result<Self> {
        let file = File::options()
            .read(true)
            .write(true)
            .create(true)
            .open(path)?;
        file.lock_exclusive()?;

        Ok(Self(file))
    }

    pub fn truncate(&mut self) -> anyhow::Result<()> {
        self.0.set_len(0)?;

        Ok(())
    }
}

impl io::Write for HistoryFile {
    fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
        self.0.write(buf)
    }

    fn flush(&mut self) -> io::Result<()> {
        self.0.flush()
    }
}

impl io::Read for HistoryFile {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        self.0.read(buf)
    }
}

impl io::Seek for HistoryFile {
    fn seek(&mut self, pos: SeekFrom) -> io::Result<u64> {
        self.0.seek(pos)
    }
}

impl Drop for HistoryFile {
    fn drop(&mut self) {
        self.0.unlock().unwrap();
    }
}
