use mizer_fixture_patch_exporter::export_to_pdf;
use mizer_fixtures::fixture::Fixture;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;

fn main() {
    let mut provider = OpenFixtureLibraryProvider::new(
        "crates/components/fixtures/open-fixture-library/.fixtures".into(),
    );
    provider.load().unwrap();
    let definition = provider
        .get_definition("ofl:american-dj:7p-hex-ip")
        .unwrap();
    let fixture = Fixture::new(
        1,
        "Spot 1".into(),
        definition,
        None,
        None,
        1,
        Some(1),
        Default::default(),
    );

    println!("Creating pdf patch...");
    let pdf = PatchExporter::new().export(vec![fixture]).unwrap();
    println!("Writing pdf patch...");

    std::fs::write("patch.pdf", pdf).unwrap();
    println!("Done");
}
