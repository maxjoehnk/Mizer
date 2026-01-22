use std::path::PathBuf;
use crate::settings::*;

mod hotkeys;

pub fn get_default_settings() -> Settings {
    Settings {
        general: General {
            language: Languages::English,
            auto_load_last_project: true,
        },
        paths: FilePaths {
            media: Media { storage: PathBuf::from(".storage") },
            device_profiles: DeviceProfiles {
                midi: get_midi_device_profiles()
            },
            fixture_libraries: FixtureLibraryPaths {
                gdtf: get_gdtf_fixture_library_paths(),
                qlcplus: get_qlcplus_fixture_library_paths(),
                mizer: get_mizer_fixture_library_paths(),
                open_fixture_library: get_open_fixture_library_fixture_library_paths(),
            }
        },
        hotkeys: hotkeys::get_hotkeys(),
    }
}

fn get_midi_device_profiles() -> Vec<PathBuf> {
    vec![
        #[cfg(debug_assertions)]
        PathBuf::from("crates/components/connections/protocols/midi/device-profiles/profiles"),
        PathBuf::from("~/Documents/Mizer/Midi Device Profiles"),
    ]
}

fn get_gdtf_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        PathBuf::from("crates/components/fixtures/gdtf/.fixtures"),
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/GDTF"),
    ]
}

fn get_qlcplus_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        PathBuf::from("crates/components/fixtures/qlcplus/.fixtures"),
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/QLC+"),
    ]
}

fn get_mizer_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        PathBuf::from("crates/components/fixtures/mizer-definitions/.fixtures"),
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/Mizer"),
    ]
}

fn get_open_fixture_library_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        PathBuf::from("crates/components/fixtures/open-fixture-library/.fixtures"),
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/Open Fixture Library"),
    ]
}
