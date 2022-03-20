use std::fs::File;
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
            let mut file = File::open(file)?;
            let history = serde_json::from_reader(&mut file)?;

            Ok(history)
        }
    }

    pub fn add_project(&self, project_path: impl AsRef<Path>) -> anyhow::Result<()> {
        let project_path = project_path.as_ref();
        let mut history = self.load()?;
        let history_path = self.folder()?.join("history.json");
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
        std::fs::create_dir_all(history_path.parent().unwrap())?;
        let mut file = File::create(history_path)?;
        serde_json::to_writer(&mut file, &history)?;

        Ok(())
    }
}

#[derive(Serialize, Deserialize)]
pub struct ProjectHistoryItem {
    pub path: PathBuf,
    load_count: u32,
    last_loaded_at: SystemTime,
}
