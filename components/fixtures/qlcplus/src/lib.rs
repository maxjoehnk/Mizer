// This is required because of the EnumFromStr macro from the enum_derive crate
#![recursion_limit = "256"]
use rayon::prelude::*;
use std::collections::HashMap;
use std::fs::{DirEntry, File};
use std::io::Read;
use std::path::Path;
use strong_xml::XmlRead;

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;
pub use self::definition::QlcPlusFixtureDefinition;

mod conversion;
mod definition;

#[derive(Default)]
pub struct QlcPlusProvider {
    file_path: String,
    definitions: HashMap<String, QlcPlusFixtureDefinition>,
}

impl QlcPlusProvider {
    pub fn new(file_path: String) -> Self {
        Self {
            file_path,
            definitions: Default::default(),
        }
    }
}

impl FixtureLibraryProvider for QlcPlusProvider {
    fn load(&mut self) -> anyhow::Result<()> {
        if !Path::new(&self.file_path).exists() {
            return Ok(());
        }
        let files = std::fs::read_dir(&self.file_path)?;
        let definitions = files
            .par_bridge()
            .filter_map(|file| file.ok())
            .filter(|file| file.metadata().is_ok())
            .filter(|file| file.metadata().unwrap().is_dir())
            .filter_map(|file| std::fs::read_dir(file.path()).ok())
            .flat_map(|file| file.par_bridge())
            .filter_map(|file: std::io::Result<DirEntry>| file.ok())
            .filter(|file| file.metadata().is_ok())
            .filter(|file| file.metadata().unwrap().is_file())
            .filter(|file| file.file_name().to_string_lossy().to_string().ends_with(".qxf"))
            .filter_map(|file| {
                let path = file.path();
                log::trace!("Loading QLC+ Fixture from '{:?}'...", path.file_name().unwrap());
                match read_definition(&path) {
                    Ok(definition) => Some((format!("{}:{}", definition.manufacturer, definition.model), definition)),
                    Err(err) => {
                        log::error!("Could not load QLC+ Fixture from '{:?}': {:?}", path.file_name().unwrap(), err);
                        None
                    }
                }
            })
            .collect::<HashMap<_, _>>();

        log::info!("Loaded {} QLC+ Fixture Definitions", definitions.len());
        self.definitions = definitions;

        Ok(())
    }

    fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        if !id.starts_with("qlc:") {
            return None;
        }
        self.definitions
            .get(&id["qlc:".len()..])
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

fn read_definition(path: &Path) -> anyhow::Result<QlcPlusFixtureDefinition> {
    let mut file = File::open(&path)?;
    let mut content = String::new();
    file.read_to_string(&mut content)?;

    let definition = QlcPlusFixtureDefinition::from_str(&content)?;
    log::debug!("Loaded QLC+ Fixture from '{:?}'.", path.file_name().unwrap());

    Ok(definition)
}
