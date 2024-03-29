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
