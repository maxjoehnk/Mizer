use std::collections::HashMap;
use std::io::{Read, Write};
use std::ops::Deref;
use std::path::{Path, PathBuf};

use directories_next::ProjectDirs;
use serde::{Deserialize, Serialize};

const DEFAULT_SETTINGS: &str = include_str!("../settings.toml");
#[cfg(target_os = "linux")]
const DEFAULT_HOTKEYS: &str = include_str!("../hotkeys-linux.toml");
#[cfg(target_os = "macos")]
const DEFAULT_HOTKEYS: &str = include_str!("../hotkeys-macos.toml");
#[cfg(target_os = "windows")]
const DEFAULT_HOTKEYS: &str = include_str!("../hotkeys-windows.toml");

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Settings {
    pub general: General,
    pub hotkeys: Hotkeys,
    pub paths: FilePaths,
}

#[derive(Debug, Clone)]
pub struct SettingsManager {
    pub settings: Settings,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct General {
    pub language: String,
    #[serde(default)]
    pub auto_load_last_project: bool,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct FilePaths {
    pub midi_device_profiles: PathList,
    pub fixture_libraries: FixtureLibraryPaths,
    #[serde(default = "default_media_storage")]
    pub media_storage: PathBuf,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
#[serde(from = "BackwardCompatibility")]
#[repr(transparent)]
pub struct PathList(Vec<PathBuf>);

impl FromIterator<PathBuf> for PathList {
    fn from_iter<T: IntoIterator<Item = PathBuf>>(iter: T) -> Self {
        PathList(iter.into_iter().collect())
    }
}

impl From<Vec<PathBuf>> for PathList {
    fn from(value: Vec<PathBuf>) -> Self {
        PathList(value)
    }
}

impl IntoIterator for PathList {
    type Item = PathBuf;
    type IntoIter = std::vec::IntoIter<PathBuf>;

    fn into_iter(self) -> Self::IntoIter {
        self.0.into_iter()
    }
}

impl Deref for PathList {
    type Target = Vec<PathBuf>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(untagged)]
pub enum BackwardCompatibility {
    SinglePath(PathBuf),
    MultiplePaths(Vec<PathBuf>),
}

impl From<BackwardCompatibility> for PathList {
    fn from(value: BackwardCompatibility) -> Self {
        match value {
            BackwardCompatibility::SinglePath(path) => PathList(vec![path]),
            BackwardCompatibility::MultiplePaths(paths) => PathList(paths),
        }
    }
}

fn default_media_storage() -> PathBuf {
    PathBuf::from(".storage")
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct FixtureLibraryPaths {
    pub open_fixture_library: PathList,
    pub qlcplus: PathList,
    pub gdtf: PathList,
    pub mizer: PathList,
}

impl Settings {
    pub fn load() -> anyhow::Result<Self> {
        let mut buffer = String::new();
        if Path::new("settings.toml").exists() {
            let mut file = std::fs::File::open("settings.toml")?;
            file.read_to_string(&mut buffer)?;
        } else {
            buffer = [DEFAULT_SETTINGS, DEFAULT_HOTKEYS].concat();
        }
        let settings = toml::from_str(&buffer)?;

        Ok(settings)
    }

    pub fn save_to<P: AsRef<Path>>(&self, path: P) -> anyhow::Result<()> {
        std::fs::create_dir_all(
            path.as_ref()
                .parent()
                .ok_or_else(|| anyhow::anyhow!("Invalid config path"))?,
        )?;
        let mut file = std::fs::File::create(path)?;
        let file_contents = toml::to_string(self)?;
        file.write_all(file_contents.as_bytes())?;

        Ok(())
    }
}

impl SettingsManager {
    pub fn new() -> anyhow::Result<Self> {
        let settings = toml::from_str(&[DEFAULT_SETTINGS, DEFAULT_HOTKEYS].concat())?;

        Ok(Self { settings })
    }

    pub fn load(&mut self) -> anyhow::Result<()> {
        let mut paths = vec![PathBuf::from("settings.toml")];
        if let Some(path) = std::env::current_exe()
            .ok()
            .and_then(|executable| executable.parent().map(|path| path.to_path_buf()))
            .map(|path| path.join("settings.toml"))
        {
            paths.push(path);
        }
        if let Some(path) = Self::get_config_path() {
            paths.push(path);
        }
        if let Some(path) = paths.iter().find(|path| path.exists()) {
            tracing::trace!("Loading settings from {path:?}");
            let mut file = std::fs::File::open(path)?;
            let mut buffer = String::new();
            file.read_to_string(&mut buffer)?;

            self.settings = toml::from_str(&buffer)?;
        } else {
            tracing::trace!("Loading default settings");
        }

        Ok(())
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let file_path =
            Self::get_config_path().ok_or_else(|| anyhow::anyhow!("No config path found"))?;

        self.settings.save_to(file_path)
    }

    fn get_config_path() -> Option<PathBuf> {
        ProjectDirs::from("live", "mizer", "Mizer")
            .map(|dirs| dirs.config_dir().join("settings.toml"))
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
    pub effects: HotkeyGroup,
    pub media: HotkeyGroup,
}

pub type HotkeyGroup = HashMap<String, String>;
