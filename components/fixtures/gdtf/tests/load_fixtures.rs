use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_gdtf_provider::GdtfProvider;
use std::panic::catch_unwind;

#[test]
fn load_fixtures() {
    let mut provider = GdtfProvider::new(".fixtures".into());

    let result = provider.load();

    assert!(result.is_ok());
}

#[test]
fn should_map_all_definitions() {
    let mut provider = GdtfProvider::new(".fixtures".into());
    provider.load().unwrap();

    let result = catch_unwind(|| provider.list_definitions());

    assert!(result.is_ok());
}
