use std::fmt;
use std::fmt::Formatter;
use std::path::PathBuf;
use facet::{Facet};
use serde::{Deserialize, Serialize};
use crate::hotkeys::Hotkeys;

#[derive(Debug, Clone, Deserialize, Serialize, Facet)]
pub struct Settings {
    pub general: General,
    pub connections: Connections,
    pub paths: FilePaths,
    pub hotkeys: Hotkeys,
}

#[derive(Debug, Clone, Deserialize, Serialize, Facet)]
#[facet(pod)]
pub struct General {
    pub language: Languages,
    #[serde(default)]
    pub auto_load_last_project: bool,
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, Copy, PartialEq, Eq, Facet)]
#[repr(C)]
#[facet(rename_all = "kebab-case")]
pub enum Languages {
    #[default]
    #[serde(rename = "en")]
    #[facet(rename = "en")]
    English,
    #[serde(rename = "de")]
    #[facet(rename = "de")]
    German,
}

impl fmt::Display for Languages {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        match self {
            Languages::English => write!(f, "en"),
            Languages::German => write!(f, "de"),
        }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, Facet)]
#[facet(pod)]
pub struct FilePaths {
    pub media: Media,
    pub device_profiles: DeviceProfiles,
    pub fixture_libraries: FixtureLibraryPaths,
}

#[derive(Debug, Clone, Deserialize, Serialize, Facet)]
#[facet(pod)]
pub struct DeviceProfiles {
    pub midi: Vec<PathBuf>,
}

#[derive(Debug, Clone, Deserialize, Serialize, Facet)]
#[facet(pod)]
pub struct Media {
    pub storage: PathBuf,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Facet)]
#[facet(pod)]
pub struct FixtureLibraryPaths {
    pub open_fixture_library: Vec<PathBuf>,
    pub qlcplus: Vec<PathBuf>,
    pub gdtf: Vec<PathBuf>,
    pub mizer: Vec<PathBuf>,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Facet)]
#[facet(pod)]
pub struct Connections {
    pub citp: CitpConnectionSettings,
    pub pro_dj_link: ProDjLinkConnectionSettings,
    pub ether_dream: EtherDreamConnectionSettings,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Facet)]
#[facet(pod)]
pub struct CitpConnectionSettings {
    pub enabled: bool,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Facet)]
#[facet(pod)]
pub struct ProDjLinkConnectionSettings {
    pub enabled: bool,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Facet)]
#[facet(pod)]
pub struct EtherDreamConnectionSettings {
    pub enabled: bool,
}
