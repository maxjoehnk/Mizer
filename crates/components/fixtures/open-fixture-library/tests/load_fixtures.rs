use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use std::panic::catch_unwind;

#[test]
fn load_fixtures() {
    let mut provider = OpenFixtureLibraryProvider::new(".fixtures".into());

    let result = provider.load();

    assert!(result.is_ok());
}

#[test]
fn should_map_all_definitions() {
    let mut provider = OpenFixtureLibraryProvider::new(".fixtures".into());
    provider.load().unwrap();

    let result = catch_unwind(|| provider.list_definitions());

    assert!(result.is_ok());
}

#[test]
fn should_map_example_fixture() {
    let mut provider = OpenFixtureLibraryProvider::new("tests".into());
    provider.load().unwrap();

    dbg!(provider.list_definitions());
    let result = provider.get_definition("ofl:eurolite:led-bar-3-hcl-bar").unwrap();
    let mode = result.get_mode("10-channel").unwrap();

    assert!(mode.controls.color_mixer.is_some());
}
