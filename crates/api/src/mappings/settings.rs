use std::path::PathBuf;
use mizer_connections::midi_device_profile;

use mizer_settings as settings;

use crate::proto::settings as model;

impl From<settings::Settings> for model::Settings {
    fn from(settings: settings::Settings) -> Self {
        Self {
            general: Some(settings.general.into()),
            hotkeys: Some(settings.hotkeys.into()),
            paths: Some(settings.paths.into()),
            ..Default::default()
        }
    }
}

impl From<settings::General> for model::General {
    fn from(general: settings::General) -> Self {
        Self {
            language: general.language,
            auto_load_last_project: general.auto_load_last_project,
        }
    }
}

impl From<settings::Hotkeys> for model::Hotkeys {
    fn from(hotkeys: settings::Hotkeys) -> Self {
        Self {
            global: hotkeys.global,
            programmer: hotkeys.programmer,
            nodes: hotkeys.nodes,
            layouts: hotkeys.layouts,
            patch: hotkeys.patch,
            sequencer: hotkeys.sequencer,
            plan: hotkeys.plan,
            effects: hotkeys.effects,
            media: hotkeys.media,
        }
    }
}

impl From<settings::FilePaths> for model::PathSettings {
    fn from(paths: settings::FilePaths) -> Self {
        Self {
            media_storage: paths.media_storage.to_string_lossy().to_string(),
            midi_device_profiles: paths.midi_device_profiles.into_iter().map(|p| p.to_string_lossy().to_string()).collect(),
            open_fixture_library: paths
                .fixture_libraries
                .open_fixture_library
                .map(path_to_string),
            qlcplus: paths.fixture_libraries.qlcplus.map(path_to_string),
            gdtf: paths.fixture_libraries.gdtf.map(path_to_string),
            mizer: paths.fixture_libraries.mizer.map(path_to_string),
        }
    }
}

impl From<model::Settings> for settings::Settings {
    fn from(settings: model::Settings) -> Self {
        Self {
            general: settings.general.unwrap().into(),
            hotkeys: settings.hotkeys.unwrap().into(),
            paths: settings.paths.unwrap().into(),
        }
    }
}

impl From<model::General> for settings::General {
    fn from(general: model::General) -> Self {
        Self {
            language: general.language,
            auto_load_last_project: general.auto_load_last_project,
        }
    }
}

impl From<model::Hotkeys> for settings::Hotkeys {
    fn from(hotkeys: model::Hotkeys) -> Self {
        Self {
            global: hotkeys.global,
            programmer: hotkeys.programmer,
            nodes: hotkeys.nodes,
            layouts: hotkeys.layouts,
            patch: hotkeys.patch,
            sequencer: hotkeys.sequencer,
            plan: hotkeys.plan,
            effects: hotkeys.effects,
            media: hotkeys.media,
        }
    }
}

impl From<model::PathSettings> for settings::FilePaths {
    fn from(paths: model::PathSettings) -> Self {
        Self {
            media_storage: PathBuf::from(paths.media_storage),
            fixture_libraries: settings::FixtureLibraryPaths {
                gdtf: paths.gdtf.map(PathBuf::from),
                open_fixture_library: paths.open_fixture_library.map(PathBuf::from),
                qlcplus: paths.qlcplus.map(PathBuf::from),
                mizer: paths.mizer.map(PathBuf::from),
            },
            midi_device_profiles: paths.midi_device_profiles.into_iter().map(PathBuf::from).collect(),
        }
    }
}

fn path_to_string(path: PathBuf) -> String {
    path.to_string_lossy().to_string()
}

impl From<Vec<midi_device_profile::DeviceProfile>> for model::MidiDeviceProfiles {
    fn from(profiles: Vec<midi_device_profile::DeviceProfile>) -> Self {
        Self {
            profiles: profiles.into_iter().map(|p| p.into()).collect(),
        }
    }
}

impl From<midi_device_profile::DeviceProfile> for model::MidiDeviceProfile {
    fn from(profile: midi_device_profile::DeviceProfile) -> Self {
        Self {
            id: profile.id,
            manufacturer: profile.manufacturer,
            name: profile.name,
            file_path: profile.file_path.to_string_lossy().to_string(),
            errors: profile.errors.errors().into_iter()
                .map(|err| model::Error {
                    timestamp: err.timestamp.to_string(),
                    message: err.error.to_string(),
                })
                .collect(),
        }
    }
}
