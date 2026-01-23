use crate::settings::*;
use std::path::PathBuf;
use crate::system_locale::get_system_language;

mod hotkeys;

pub fn get_default_settings() -> Settings {
    Settings {
        general: General {
            language: get_system_language().unwrap_or_default(),
            auto_load_last_project: true,
        },
        paths: FilePaths {
            media: Media {
                #[cfg(debug_assertions)]
                storage: PathBuf::from(".storage"),
                #[cfg(not(any(debug_assertions, target_os = "windows")))]
                storage: PathBuf::from("~\\.mizer-media"),
                #[cfg(all(not(debug_assertions), not(target_os = "windows")))]
                storage: PathBuf::from("~/.mizer-media"),
            },
            device_profiles: DeviceProfiles {
                midi: get_midi_device_profiles(),
            },
            fixture_libraries: FixtureLibraryPaths {
                gdtf: get_gdtf_fixture_library_paths(),
                qlcplus: get_qlcplus_fixture_library_paths(),
                mizer: get_mizer_fixture_library_paths(),
                open_fixture_library: get_open_fixture_library_fixture_library_paths(),
            },
        },
        hotkeys: hotkeys::get_hotkeys(),
    }
}

fn get_midi_device_profiles() -> Vec<PathBuf> {
    vec![
        #[cfg(debug_assertions)]
        PathBuf::from("crates/components/connections/protocols/midi/device-profiles/profiles"),
        #[cfg(all(not(debug_assertions), target_os = "macos"))]
        PathBuf::from("../Resources/device-profiles/midi"),
        #[cfg(all(not(debug_assertions), target_os = "linux"))]
        PathBuf::from("device-profiles/midi"),
        #[cfg(all(not(debug_assertions), target_os = "windows"))]
        PathBuf::from("device-profiles\\midi"),
        #[cfg(not(target_os = "windows"))]
        PathBuf::from("~/Documents/Mizer/Midi Device Profiles"),
        #[cfg(target_os = "windows")]
        PathBuf::from("~\\Documents\\Mizer\\Midi Device Profiles"),
    ]
}

fn get_gdtf_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        #[cfg(debug_assertions)]
        PathBuf::from("crates/components/fixtures/gdtf/.fixtures"),
        #[cfg(all(not(debug_assertions), target_os = "macos"))]
        PathBuf::from("../Resources/fixtures/gdtf"),
        #[cfg(all(not(debug_assertions), target_os = "linux"))]
        PathBuf::from("fixtures/gdtf"),
        #[cfg(all(not(debug_assertions), target_os = "windows"))]
        PathBuf::from("fixtures\\gdtf"),
        #[cfg(not(target_os = "windows"))]
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/GDTF"),
        #[cfg(target_os = "windows")]
        PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\GDTF"),
    ]
}

fn get_qlcplus_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        #[cfg(debug_assertions)]
        PathBuf::from("crates/components/fixtures/qlcplus/.fixtures"),
        #[cfg(all(not(debug_assertions), target_os = "macos"))]
        PathBuf::from("../Resources/fixtures/qlcplus"),
        #[cfg(all(not(debug_assertions), target_os = "linux"))]
        PathBuf::from("fixtures/qlcplus"),
        #[cfg(all(not(debug_assertions), target_os = "windows"))]
        PathBuf::from("fixtures\\qlcplus"),
        #[cfg(not(target_os = "windows"))]
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/QLC+"),
        #[cfg(target_os = "windows")]
        PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\QLC+"),
    ]
}

fn get_mizer_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        #[cfg(debug_assertions)]
        PathBuf::from("crates/components/fixtures/mizer-definitions/.fixtures"),
        #[cfg(all(not(debug_assertions), target_os = "macos"))]
        PathBuf::from("../Resources/fixtures/mizer"),
        #[cfg(all(not(debug_assertions), target_os = "linux"))]
        PathBuf::from("fixtures/mizer"),
        #[cfg(all(not(debug_assertions), target_os = "windows"))]
        PathBuf::from("fixtures\\mizer"),
        #[cfg(not(target_os = "windows"))]
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/Mizer"),
        #[cfg(target_os = "windows")]
        PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\Mizer"),
    ]
}

fn get_open_fixture_library_fixture_library_paths() -> Vec<PathBuf> {
    vec![
        #[cfg(debug_assertions)]
        PathBuf::from("crates/components/fixtures/open-fixture-library/.fixtures"),
        #[cfg(all(not(debug_assertions), target_os = "macos"))]
        PathBuf::from("../Resources/fixtures/open-fixture-library"),
        #[cfg(all(not(debug_assertions), target_os = "linux"))]
        PathBuf::from("fixtures/open-fixture-library"),
        #[cfg(all(not(debug_assertions), target_os = "windows"))]
        PathBuf::from("fixtures\\open-fixture-library"),
        #[cfg(not(target_os = "windows"))]
        PathBuf::from("~/Documents/Mizer/Fixture Definitions/Open Fixture Library"),
        #[cfg(target_os = "windows")]
        PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\Open Fixture Library"),
    ]
}
