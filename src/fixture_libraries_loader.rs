use mizer_fixtures::library::{FixtureLibrary, FixtureLibraryProvider};
use mizer_gdtf_provider::GdtfProvider;
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use mizer_qlcplus_provider::QlcPlusProvider;
use mizer_settings::FixtureLibraryPaths;

pub struct FixtureLibrariesLoader(pub(crate) FixtureLibrary);

impl FixtureLibrariesLoader {
    pub fn queue_load(self) {
        std::thread::spawn(move || {
            self.load();
        });
    }

    pub fn reload(&self, paths: FixtureLibraryPaths) -> anyhow::Result<()> {
        let providers = Self::get_providers(&paths);
        self.0.replace_providers(providers);
        self.load();

        Ok(())
    }

    fn load(&self) {
        log::info!("Loading fixture libraries...");
        if let Err(err) = self.0.load_libraries() {
            log::error!("Loading of fixture libraries failed: {:?}", err);
        } else {
            log::info!("Loaded fixture libraries successfully.");
        }
    }

    pub fn get_providers(paths: &FixtureLibraryPaths) -> Vec<Box<dyn FixtureLibraryProvider>> {
        [load_ofl_provider, load_gdtf_provider, load_qlcplus_provider]
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
