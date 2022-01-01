use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::io::Read;
use std::path::Path;

const DEFAULT_SETTINGS: &str = include_str!("../settings.toml");

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Settings {
    pub hotkeys: Hotkeys,
}

impl Settings {
    pub fn load() -> anyhow::Result<Self> {
        let mut buffer = String::from(DEFAULT_SETTINGS);
        if Path::new("settings.toml").exists() {
            let mut file = std::fs::File::open("settings.toml")?;
            file.read_to_string(&mut buffer)?;
        }
        let settings = toml::from_str(&buffer)?;

        Ok(settings)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Hotkeys {
    pub global: HotkeyGroup,
    pub layouts: HotkeyGroup,
    pub programmer: HotkeyGroup,
    pub nodes: HotkeyGroup,
    pub patch: HotkeyGroup,
}

pub type HotkeyGroup = HashMap<String, String>;
