use std::collections::HashMap;
use std::io::Read;
use std::path::Path;
use rayon::prelude::*;
use strong_xml::XmlRead;
use zip::ZipArchive;

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;

mod conversion;
mod definition;
mod types;

pub use self::definition::GdtfFixtureDefinition;

#[derive(Default)]
pub struct GdtfProvider {
    file_path: String,
    definitions: HashMap<String, GdtfFixtureDefinition>,
}

impl GdtfProvider {
    pub fn new(file_path: String) -> Self {
        Self {
            file_path,
            definitions: Default::default(),
        }
    }
}

impl FixtureLibraryProvider for GdtfProvider {
    fn load(&mut self) -> anyhow::Result<()> {
        if !Path::new(&self.file_path).exists() {
            return Ok(());
        }
        let files = std::fs::read_dir(&self.file_path)?;
        let definitions = files.par_bridge()
            .map(|file| {
                let file = file?;
                if file.metadata()?.is_file() && file.file_name().to_string_lossy().to_string().ends_with(".gdtf") {
                    log::trace!("Loading GDTF Fixture from '{:?}'...", file);
                    let gdtf_archive = GdtfArchive::read(&file.path())?;
                    log::debug!("Loaded GDTF Fixture from '{:?}'.", file);

                    Ok(Some(gdtf_archive))
                }else {
                    Ok(None)
                }
            })
            .filter_map(|archive: anyhow::Result<_>| match archive {
                Ok(Some(archive)) => Some(Ok((archive.definition.fixture_type.fixture_type_id.clone(), archive.definition))),
                Ok(None) => None,
                Err(err) => Some(Err(err)),
            })
            .filter_map(|archive| match archive {
                Ok(archive) => Some(archive),
                Err(err) => {
                    log::error!("Error parsing gdtf definition {err:?}");
                    None
                }
            })
            .collect::<HashMap<String, GdtfFixtureDefinition>>();
        self.definitions = definitions;

        Ok(())
    }

    fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        if !id.starts_with("gdtf:") {
            return None;
        }
        let id_parts = id.split(':').collect::<Vec<_>>();
        self.definitions.get(id_parts[1]).cloned().map(FixtureDefinition::from)
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        self.definitions
            .values()
            .cloned()
            .map(FixtureDefinition::from)
            .collect()
    }
}

struct GdtfArchive {
    definition: GdtfFixtureDefinition,
}

impl GdtfArchive {
    fn read(path: &Path) -> anyhow::Result<Self> {
        let file = std::fs::File::open(path)?;
        let mut reader = ZipArchive::new(file)?;

        let mut description = String::new();
        let mut description_file = reader.by_name("description.xml")?;

        description_file.read_to_string(&mut description)?;
        let definition = GdtfFixtureDefinition::from_str(&description)?;

        Ok(Self {
            definition
        })
    }
}
