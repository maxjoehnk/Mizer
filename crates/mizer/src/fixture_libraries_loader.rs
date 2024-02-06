use mizer_fixture_definition_provider::MizerDefinitionsProvider;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_fixtures::FixtureLibraryLoader;
use mizer_gdtf_provider::GdtfProvider;
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use mizer_qlcplus_provider::QlcPlusProvider;
use mizer_settings::FixtureLibraryPaths;

#[derive(Default)]
pub struct MizerFixtureLoader;

impl FixtureLibraryLoader for MizerFixtureLoader {
    fn get_providers(&self, paths: &FixtureLibraryPaths) -> Vec<Box<dyn FixtureLibraryProvider>> {
        [
            load_ofl_provider,
            load_gdtf_provider,
            load_qlcplus_provider,
            load_mizer_provider,
        ]
        .into_iter()
        .filter_map(|loader| loader(paths))
        .collect()
    }
}

fn load_ofl_provider(paths: &FixtureLibraryPaths) -> Option<Box<dyn FixtureLibraryProvider>> {
    paths.open_fixture_library.as_ref().map(|path| {
        let ofl_provider = OpenFixtureLibraryProvider::new(path.to_string_lossy().to_string());

        Box::new(ofl_provider) as Box<dyn FixtureLibraryProvider>
    })
}

fn load_gdtf_provider(paths: &FixtureLibraryPaths) -> Option<Box<dyn FixtureLibraryProvider>> {
    paths.gdtf.as_ref().map(|path| {
        let gdtf_provider = GdtfProvider::new(path.to_string_lossy().to_string());

        Box::new(gdtf_provider) as Box<dyn FixtureLibraryProvider>
    })
}

fn load_qlcplus_provider(paths: &FixtureLibraryPaths) -> Option<Box<dyn FixtureLibraryProvider>> {
    paths.qlcplus.as_ref().map(|path| {
        let qlcplus_provider = QlcPlusProvider::new(path.to_string_lossy().to_string());

        Box::new(qlcplus_provider) as Box<dyn FixtureLibraryProvider>
    })
}

fn load_mizer_provider(paths: &FixtureLibraryPaths) -> Option<Box<dyn FixtureLibraryProvider>> {
    paths.mizer.as_ref().map(|path| {
        let mizer_provider = MizerDefinitionsProvider::new(path.to_string_lossy().to_string());

        Box::new(mizer_provider) as Box<dyn FixtureLibraryProvider>
    })
}
