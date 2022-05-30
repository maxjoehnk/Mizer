use std::collections::HashMap;
use std::io::{Read, Write};
use std::path::{Path, PathBuf};

use directories_next::ProjectDirs;
use serde::{Deserialize, Serialize};

const DEFAULT_SETTINGS: &str = include_str!("../settings.toml");

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Settings {
    pub general: General,
    pub hotkeys: Hotkeys,
    pub paths: FilePaths,
}

#[derive(Debug, Clone)]
pub struct SettingsManager {
    pub settings: Settings,
    pub file_path: Option<PathBuf>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct General {
    pub language: String,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct FilePaths {
    pub midi_device_profiles: PathBuf,
    pub fixture_libraries: FixtureLibraryPaths,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct FixtureLibraryPaths {
    pub open_fixture_library: Option<PathBuf>,
    pub qlcplus: Option<PathBuf>,
    pub gdtf: Option<PathBuf>,
}

impl Settings {
    pub fn load() -> anyhow::Result<Self> {
        let mut buffer = String::new();
        if Path::new("settings.toml").exists() {
            let mut file = std::fs::File::open("settings.toml")?;
            file.read_to_string(&mut buffer)?;
        } else {
            buffer = DEFAULT_SETTINGS.to_string();
        }
        let settings = toml::from_str(&buffer)?;

        Ok(settings)
    }

    pub fn save_to<P: AsRef<Path>>(&self, path: P) -> anyhow::Result<()> {
        std::fs::create_dir_all(path.as_ref().parent().ok_or_else(|| anyhow::anyhow!("Invalid config path"))?)?;
        let mut file = std::fs::File::create(path)?;
        let file_contents = toml::to_vec(self)?;
        file.write_all(&file_contents)?;

        Ok(())
    }
}

impl SettingsManager {
    pub fn new() -> anyhow::Result<Self> {
        let settings = toml::from_str(DEFAULT_SETTINGS)?;

        Ok(Self {
            settings,
            file_path: None,
        })
    }

    pub fn load(&mut self) -> anyhow::Result<()> {
        let mut paths = vec![PathBuf::from("settings.toml")];
        if let Some(dir) = ProjectDirs::from("me", "maxjoehnk", "Mizer")
            .map(|dirs| dirs.config_dir().join("settings.toml"))
        {
            paths.push(dir);
        }
        if let Some(path) = paths.iter().find(|path| path.exists()) {
            let mut file = std::fs::File::open(path)?;
            let mut buffer = String::new();
            file.read_to_string(&mut buffer)?;

            self.settings = toml::from_str(&buffer)?;
            self.file_path = Some(path.to_path_buf());
        }

        Ok(())
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let file_path = if let Some(ref path) = self.file_path {
            path.clone()
        } else if let Some(path) = ProjectDirs::from("me", "maxjoehnk", "Mizer")
            .map(|dirs| dirs.config_dir().join("settings.toml"))
        {
            path
        } else {
            PathBuf::from("settings.toml")
        };

        self.settings.save_to(file_path)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Hotkeys {
    pub global: HotkeyGroup,
    pub layouts: HotkeyGroup,
    pub plan: HotkeyGroup,
    pub programmer: HotkeyGroup,
    pub nodes: HotkeyGroup,
    pub patch: HotkeyGroup,
    pub sequencer: HotkeyGroup,
}

pub type HotkeyGroup = HashMap<String, String>;
