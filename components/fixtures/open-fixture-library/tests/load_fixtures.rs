use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;

#[test]
fn load_fixtures() {
    let mut provider = OpenFixtureLibraryProvider::new();

    let result = provider.load(".fixtures");

    assert!(result.is_ok());
}
