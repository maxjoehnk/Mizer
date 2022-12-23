use protobuf::MessageField;
use std::path::PathBuf;

use mizer_settings as settings;

use crate::models::settings as model;

impl From<settings::Settings> for model::Settings {
    fn from(settings: settings::Settings) -> Self {
        Self {
            general: MessageField::some(settings.general.into()),
            hotkeys: MessageField::some(settings.hotkeys.into()),
            paths: MessageField::some(settings.paths.into()),
            ..Default::default()
        }
    }
}

impl From<settings::General> for model::General {
    fn from(general: settings::General) -> Self {
        Self {
            language: general.language,
            ..Default::default()
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
            ..Default::default()
        }
    }
}

impl From<settings::FilePaths> for model::PathSettings {
    fn from(paths: settings::FilePaths) -> Self {
        Self {
            midi_device_profiles: paths.midi_device_profiles.to_string_lossy().to_string(),
            open_fixture_library: paths
                .fixture_libraries
                .open_fixture_library
                .map(path_to_string),
            qlcplus: paths.fixture_libraries.qlcplus.map(path_to_string),
            gdtf: paths.fixture_libraries.gdtf.map(path_to_string),
            ..Default::default()
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
        }
    }
}

impl From<model::PathSettings> for settings::FilePaths {
    fn from(paths: model::PathSettings) -> Self {
        Self {
            fixture_libraries: settings::FixtureLibraryPaths {
                gdtf: paths.gdtf.map(PathBuf::from),
                open_fixture_library: paths.open_fixture_library.map(PathBuf::from),
                qlcplus: paths.qlcplus.map(PathBuf::from),
            },
            midi_device_profiles: PathBuf::from(paths.midi_device_profiles),
        }
    }
}

fn path_to_string(path: PathBuf) -> String {
    path.to_string_lossy().to_string()
}
