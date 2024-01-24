use std::collections::HashMap;
use std::fs::File;
use std::io::Read;
use std::path::Path;

use rayon::prelude::*;

use mizer_fixtures::definition::FixtureDefinition;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_util::find_path;

use crate::conversion::map_fixture_definition;
pub use crate::definition::MizerFixtureDefinition;

mod conversion;
mod definition;

#[derive(Default)]
pub struct MizerDefinitionsProvider {
    file_path: String,
    definitions: HashMap<String, MizerFixtureDefinition>,
}

impl MizerDefinitionsProvider {
    pub fn new(file_path: String) -> Self {
        Self {
            file_path,
            definitions: Default::default(),
        }
    }
}

impl FixtureLibraryProvider for MizerDefinitionsProvider {
    fn load(&mut self) -> anyhow::Result<()> {
        log::info!("Loading Mizer fixture library...");
        if let Some(path) = find_path(&self.file_path) {
            let files = std::fs::read_dir(path)?;
            let definitions = files
                .par_bridge()
                .filter_map(|file| file.ok())
                .filter(|file| file.metadata().is_ok())
                .filter(|file| file.metadata().unwrap().is_file())
                .filter(|file| {
                    file.file_name()
                        .to_string_lossy()
                        .to_string()
                        .ends_with(".toml")
                })
                .filter_map(|file| {
                    let path = file.path();
                    log::trace!(
                        "Loading Mizer Fixture from '{:?}'...",
                        path.file_name().unwrap()
                    );
                    match read_definition(&path) {
                        Ok(definition) => Some((
                            format!(
                                "{}:{}",
                                definition.metadata.manufacturer, definition.metadata.name
                            ),
                            definition,
                        )),
                        Err(err) => {
                            log::error!(
                                "Could not load Mizer Fixture from '{:?}': {:?}",
                                path.file_name().unwrap(),
                                err
                            );
                            None
                        }
                    }
                })
                .collect::<HashMap<_, _>>();

            log::info!("Loaded {} Mizer Fixture Definitions", definitions.len());
            self.definitions = definitions;
        }

        Ok(())
    }

    fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        if !id.starts_with("mizer:") {
            return None;
        }

        self.definitions
            .get(&id["mizer:".len()..])
            .cloned()
            .map(map_fixture_definition)
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        self.definitions
            .values()
            .cloned()
            .map(map_fixture_definition)
            .collect()
    }
}

fn read_definition(path: &Path) -> anyhow::Result<MizerFixtureDefinition> {
    let mut file = File::open(path)?;
    let mut content = String::new();
    file.read_to_string(&mut content)?;

    let definition = toml::from_str(&content)?;
    log::debug!(
        "Loaded Mizer Fixture from '{:?}'.",
        path.file_name().unwrap()
    );

    Ok(definition)
}

#[cfg(test)]
mod tests {
    use crate::conversion::map_fixture_definition;
    use crate::definition::MizerFixtureDefinition;

    const LED_TUBE_DEFINITION: &str = include_str!("../.fixtures/led-tube.toml");

    #[test]
    fn led_tube() {
        let file: MizerFixtureDefinition = toml::from_str(LED_TUBE_DEFINITION).unwrap();
        let definition = map_fixture_definition(file);

        assert_eq!(definition.name, "LED Tube");
        assert_eq!(definition.manufacturer, "Max Jöhnk");
        assert_eq!(definition.modes.len(), 3);
        assert_eq!(definition.modes[0].name, "50 Pixels");
        assert_eq!(definition.modes[0].get_channels().len(), 150);
        assert_eq!(definition.modes[0].sub_fixtures.len(), 50);
        assert_eq!(definition.modes[1].name, "145 Pixels");
        assert_eq!(definition.modes[1].get_channels().len(), 435);
        assert_eq!(definition.modes[1].sub_fixtures.len(), 145);
        assert_eq!(definition.modes[2].name, "60 Pixels");
        assert_eq!(definition.modes[2].get_channels().len(), 180);
        assert_eq!(definition.modes[2].sub_fixtures.len(), 60);
    }
}
