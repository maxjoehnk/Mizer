use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::io::{Read, Write};
use std::path::{Path, PathBuf};

const DEFAULT_SETTINGS: &str = include_str!("../settings.toml");

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Settings {
    pub hotkeys: Hotkeys,
    pub paths: FilePaths,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct FilePaths {
    pub midi_device_profiles: PathBuf,
    pub fixture_libraries: FixtureLibraryPaths,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
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
        }else {
            buffer = DEFAULT_SETTINGS.to_string();
        }
        let settings = toml::from_str(&buffer)?;

        Ok(settings)
    }

    pub fn save_to<P: AsRef<Path>>(&self, path: P) -> anyhow::Result<()> {
        let mut file = std::fs::File::create(path)?;
        let file_contents = toml::to_vec(self)?;
        file.write_all(&file_contents)?;

        Ok(())
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
