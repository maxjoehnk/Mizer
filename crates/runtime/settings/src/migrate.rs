use std::collections::HashMap;
use std::io::Read;
use std::ops::Deref;
use std::path::{Path, PathBuf};
use facet::Facet;
use serde::Deserialize;
use crate::UpdateSettingValue;
use crate::user_settings::UserSettings;

pub fn migrate_settings(path: &Path, user_settings: &mut UserSettings) -> anyhow::Result<()> {
    tracing::info!("Trying to migrate settings from {path:?}");
    let mut file = std::fs::File::open(path)?;
    let mut buffer = String::new();
    file.read_to_string(&mut buffer)?;
    let settings: OldSettings = toml::from_str(&buffer)?;

    user_settings.set("general.language".into(), UpdateSettingValue::Select(settings.general.language));
    user_settings.set("general.auto_load_last_project".into(), UpdateSettingValue::Bool(settings.general.auto_load_last_project));
    user_settings.set("paths.media.storage".into(), UpdateSettingValue::Path(settings.paths.media_storage));
    user_settings.set("paths.device_profiles.midi".into(), UpdateSettingValue::PathList(settings.paths.midi_device_profiles.0));
    user_settings.set("paths.fixture_libraries.open_fixture_library".into(), UpdateSettingValue::PathList(settings.paths.fixture_libraries.open_fixture_library.0));
    user_settings.set("paths.fixture_libraries.qlcplus".into(), UpdateSettingValue::PathList(settings.paths.fixture_libraries.qlcplus.0));
    user_settings.set("paths.fixture_libraries.gdtf".into(), UpdateSettingValue::PathList(settings.paths.fixture_libraries.gdtf.0));
    user_settings.set("paths.fixture_libraries.mizer".into(), UpdateSettingValue::PathList(settings.paths.fixture_libraries.mizer.0));
    for (group, hotkeys) in settings.hotkeys {
        for (key, value) in hotkeys {
            user_settings.set(format!("hotkeys.{group}.{key}"), UpdateSettingValue::Hotkey(value));
        }
    }

    Ok(())
}

#[derive(Debug, Clone, Deserialize)]
struct OldSettings {
    general: OldGeneral,
    paths: OldPaths,
    hotkeys: HashMap<String, HashMap<String, String>>
}

#[derive(Debug, Clone, Deserialize)]
struct OldGeneral {
    language: String,
    auto_load_last_project: bool,
}

#[derive(Debug, Clone, Deserialize)]
struct OldPaths {
    media_storage: PathBuf,
    midi_device_profiles: PathList,
    fixture_libraries: OldFixtureLibraries,
}

#[derive(Debug, Clone, Deserialize)]
struct OldFixtureLibraries {
    open_fixture_library: PathList,
    qlcplus: PathList,
    gdtf: PathList,
    mizer: PathList,
}

#[derive(Default, Debug, Clone, Deserialize, PartialEq, Eq, Facet)]
#[serde(from = "BackwardCompatibility")]
#[repr(transparent)]
#[facet(transparent)]
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

#[derive(Debug, Clone, Deserialize)]
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
