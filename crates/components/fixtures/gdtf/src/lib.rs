use std::collections::HashMap;
use std::fmt::{Display, Formatter};
use std::io::Read;
use std::path::Path;

use hard_xml::XmlRead;
use rayon::prelude::*;
use zip::ZipArchive;

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_util::find_path;

pub use self::definition::GdtfFixtureDefinition;

mod conversion;
mod definition;
mod types;

#[derive(Default)]
pub struct GdtfProvider {
    file_path: String,
    definitions: HashMap<String, GdtfFixtureDefinition>,
}

impl Display for GdtfProvider {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "GdtfProvider({})", self.file_path)
    }
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
        tracing::info!("Loading GDTF fixture library...");
        if let Some(path) = find_path(&self.file_path) {
            let files = std::fs::read_dir(path)?;
            let definitions = files
                .par_bridge()
                .map(|file| {
                    let file = file?;
                    if file.metadata()?.is_file()
                        && file
                            .file_name()
                            .to_string_lossy()
                            .to_string()
                            .ends_with(".gdtf")
                    {
                        tracing::trace!("Loading GDTF Fixture from '{:?}'...", file);
                        let gdtf_archive = GdtfArchive::read(&file.path())?;
                        tracing::debug!("Loaded GDTF Fixture from '{:?}'.", file);

                        Ok(Some(gdtf_archive))
                    } else {
                        Ok(None)
                    }
                })
                .filter_map(|archive: anyhow::Result<_>| match archive {
                    Ok(Some(archive)) => Some(Ok((
                        archive.definition.fixture_type.fixture_type_id.clone(),
                        archive.definition,
                    ))),
                    Ok(None) => None,
                    Err(err) => Some(Err(err)),
                })
                .filter_map(|archive| match archive {
                    Ok(archive) => Some(archive),
                    Err(err) => {
                        tracing::error!("Error parsing gdtf definition {err:?}");
                        None
                    }
                })
                .collect::<HashMap<String, GdtfFixtureDefinition>>();
            self.definitions = definitions;
        }

        Ok(())
    }

    fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        if !id.starts_with("gdtf:") {
            return None;
        }
        let id_parts = id.split(':').collect::<Vec<_>>();
        self.definitions
            .get(id_parts[1])
            .cloned()
            .map(FixtureDefinition::from)
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

        Ok(Self { definition })
    }
}
