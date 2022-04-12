use std::path::PathBuf;

use protobuf::SingularPtrField;

use mizer_settings as settings;

use crate::models::settings as model;

impl From<settings::Settings> for model::Settings {
    fn from(settings: settings::Settings) -> Self {
        Self {
            hotkeys: SingularPtrField::some(settings.hotkeys.into()),
            paths: SingularPtrField::some(settings.paths.into()),
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
            ..Default::default()
        }
    }
}

impl From<settings::FilePaths> for model::PathSettings {
    fn from(paths: settings::FilePaths) -> Self {
        Self {
            midi_device_profiles: paths.midi_device_profiles.to_string_lossy().to_string(),
            _open_fixture_library: paths
                .fixture_libraries
                .open_fixture_library
                .map(path_to_string)
                .map(model::PathSettings_oneof__open_fixture_library::open_fixture_library),
            _qlcplus: paths
                .fixture_libraries
                .qlcplus
                .map(path_to_string)
                .map(model::PathSettings_oneof__qlcplus::qlcplus),
            _gdtf: paths
                .fixture_libraries
                .gdtf
                .map(path_to_string)
                .map(model::PathSettings_oneof__gdtf::gdtf),
            ..Default::default()
        }
    }
}

impl From<model::Settings> for settings::Settings {
    fn from(settings: model::Settings) -> Self {
        Self {
            hotkeys: settings.hotkeys.unwrap().into(),
            paths: settings.paths.unwrap().into(),
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
        }
    }
}

impl From<model::PathSettings> for settings::FilePaths {
    fn from(paths: model::PathSettings) -> Self {
        Self {
            fixture_libraries: settings::FixtureLibraryPaths {
                gdtf: paths._gdtf.map(|path| {
                    let model::PathSettings_oneof__gdtf::gdtf(path) = path;
                    PathBuf::from(path)
                }),
                open_fixture_library:
                    paths._open_fixture_library.map(|path| {
                        let model::PathSettings_oneof__open_fixture_library::open_fixture_library(
                            path,
                        ) = path;
                        PathBuf::from(path)
                    }),
                qlcplus: paths._qlcplus.map(|path| {
                    let model::PathSettings_oneof__qlcplus::qlcplus(path) = path;
                    PathBuf::from(path)
                }),
            },
            midi_device_profiles: PathBuf::from(paths.midi_device_profiles),
        }
    }
}

fn path_to_string(path: PathBuf) -> String {
    path.to_string_lossy().to_string()
}
