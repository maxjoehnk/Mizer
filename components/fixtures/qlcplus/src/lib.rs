// This is required because of the EnumFromStr macro from the enum_derive crate
#![recursion_limit = "256"]
use rayon::prelude::*;
use std::collections::HashMap;
use std::fs::{DirEntry, File};
use std::io::Read;
use std::path::Path;
use strong_xml::XmlRead;

pub use self::definition::QlcPlusFixtureDefinition;
use crate::conversion::map_fixture_definition;
use crate::resource_reader::ResourceReader;
use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;

mod conversion;
mod definition;
mod resource_reader;

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
        log::info!("Loading QLC+ fixture library...");
        if !Path::new(&self.file_path).exists() {
            return Ok(());
        }
        let files = std::fs::read_dir(Path::new(&self.file_path).join("fixtures"))?;
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
            .filter(|file| {
                file.file_name()
                    .to_string_lossy()
                    .to_string()
                    .ends_with(".qxf")
            })
            .filter_map(|file| {
                let path = file.path();
                log::trace!(
                    "Loading QLC+ Fixture from '{:?}'...",
                    path.file_name().unwrap()
                );
                match read_definition(&path) {
                    Ok(definition) => Some((
                        format!("{}:{}", definition.manufacturer, definition.model),
                        definition,
                    )),
                    Err(err) => {
                        log::error!(
                            "Could not load QLC+ Fixture from '{:?}': {:?}",
                            path.file_name().unwrap(),
                            err
                        );
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
        let resource_reader = ResourceReader::new(Path::new(&self.file_path));

        self.definitions
            .get(&id["qlc:".len()..])
            .cloned()
            .map(|definition| map_fixture_definition(definition, &resource_reader))
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        let resource_reader = ResourceReader::new(Path::new(&self.file_path));

        self.definitions
            .values()
            .cloned()
            .map(|definition| map_fixture_definition(definition, &resource_reader))
            .collect()
    }
}

fn read_definition(path: &Path) -> anyhow::Result<QlcPlusFixtureDefinition> {
    let mut file = File::open(path)?;
    let mut content = String::new();
    file.read_to_string(&mut content)?;

    let definition = QlcPlusFixtureDefinition::from_str(&content)?;
    log::debug!(
        "Loaded QLC+ Fixture from '{:?}'.",
        path.file_name().unwrap()
    );

    Ok(definition)
}

#[cfg(test)]
mod tests {
    use super::{conversion::map_fixture_definition, QlcPlusFixtureDefinition, ResourceReader};
    use mizer_fixtures::definition::*;
    use std::path::Path;
    use strong_xml::XmlRead;

    const GENERIC_RGB_DEFINITION: &str = include_str!("../tests/Generic-Generic-RGB.qxf");
    const GENERIC_RGBW_DEFINITION: &str = include_str!("../tests/Generic-Generic-RGBW.qxf");
    const GENERIC_SMOKE_DEFINITION: &str = include_str!("../tests/Generic-Generic-Smoke.qxf");

    #[test]
    fn generic_rgb() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));
        let definition = map_fixture_definition(file, &resource_reader);

        assert_eq!(definition.name, "Generic RGB");
        assert_eq!(definition.modes.len(), 5);
        assert_eq!(definition.modes[0].name, "RGB");
        assert_eq!(definition.modes[0].channels.len(), 3);
        assert_eq!(definition.modes[1].name, "GRB");
        assert_eq!(definition.modes[1].channels.len(), 3);
        assert_eq!(definition.modes[2].name, "BGR");
        assert_eq!(definition.modes[2].channels.len(), 3);
        assert_eq!(definition.modes[3].name, "RGB Dimmer");
        assert_eq!(definition.modes[3].channels.len(), 4);
        assert_eq!(definition.modes[4].name, "Dimmer RGB");
        assert_eq!(definition.modes[4].channels.len(), 4);
        for mode in &definition.modes {
            assert_eq!(
                mode.controls.color_mixer,
                Some(ColorGroup {
                    red: FixtureControlChannel::Channel("Red".into()),
                    green: FixtureControlChannel::Channel("Green".into()),
                    blue: FixtureControlChannel::Channel("Blue".into()),
                    amber: None,
                    white: None,
                })
            );
        }
        assert_eq!(
            definition.modes[3].controls.intensity,
            Some(FixtureControlChannel::Channel("Dimmer".into()))
        );
        assert_eq!(
            definition.modes[4].controls.intensity,
            Some(FixtureControlChannel::Channel("Dimmer".into()))
        );
    }

    #[test]
    fn generic_rgbw() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGBW_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));
        let definition = map_fixture_definition(file, &resource_reader);

        assert_eq!(definition.name, "Generic RGBW");
        assert_eq!(definition.modes.len(), 6);
        assert_eq!(definition.modes[0].name, "RGBW");
        assert_eq!(definition.modes[0].channels.len(), 4);
        assert_eq!(definition.modes[1].name, "WRGB");
        assert_eq!(definition.modes[1].channels.len(), 4);
        assert_eq!(definition.modes[2].name, "RGBW Dimmer");
        assert_eq!(definition.modes[2].channels.len(), 5);
        assert_eq!(definition.modes[3].name, "WRGB Dimmer");
        assert_eq!(definition.modes[3].channels.len(), 5);
        assert_eq!(definition.modes[4].name, "Dimmer RGBW");
        assert_eq!(definition.modes[4].channels.len(), 5);
        assert_eq!(definition.modes[5].name, "Dimmer WRGB");
        assert_eq!(definition.modes[5].channels.len(), 5);
        for mode in &definition.modes {
            assert_eq!(
                mode.controls.color_mixer,
                Some(ColorGroup {
                    red: FixtureControlChannel::Channel("Red".into()),
                    green: FixtureControlChannel::Channel("Green".into()),
                    blue: FixtureControlChannel::Channel("Blue".into()),
                    amber: None,
                    white: Some(FixtureControlChannel::Channel("White".into())),
                })
            );
        }
        assert_eq!(
            definition.modes[2].controls.intensity,
            Some(FixtureControlChannel::Channel("Dimmer".into()))
        );
        assert_eq!(
            definition.modes[3].controls.intensity,
            Some(FixtureControlChannel::Channel("Dimmer".into()))
        );
        assert_eq!(
            definition.modes[4].controls.intensity,
            Some(FixtureControlChannel::Channel("Dimmer".into()))
        );
        assert_eq!(
            definition.modes[5].controls.intensity,
            Some(FixtureControlChannel::Channel("Dimmer".into()))
        );
    }

    #[test]
    fn generic_smoke() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_SMOKE_DEFINITION);

        println!("{:#?}", file);
        assert!(file.is_ok());
    }
}
