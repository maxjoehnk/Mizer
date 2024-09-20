// This is required because of the EnumFromStr macro from the enum_derive crate
#![recursion_limit = "256"]

use std::collections::HashMap;
use std::fmt::{Display, Formatter};
use std::fs::{DirEntry, File};
use std::io::Read;
use std::path::Path;

use hard_xml::XmlRead;
use rayon::prelude::*;

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_util::find_path;

use crate::conversion::map_fixture_definition;
use crate::resource_reader::ResourceReader;

pub use self::definition::QlcPlusFixtureDefinition;

mod conversion;
mod definition;
mod resource_reader;

pub(crate) const PROVIDER_NAME: &str = "QLC+";

#[derive(Default)]
pub struct QlcPlusProvider {
    file_path: String,
    definitions: HashMap<String, QlcPlusFixtureDefinition>,
}

impl Display for QlcPlusProvider {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "QlcPlusProvider({})", self.file_path)
    }
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
    fn name(&self) -> &'static str {
        PROVIDER_NAME
    }

    fn load(&mut self) -> anyhow::Result<()> {
        tracing::info!("Loading QLC+ fixture library...");
        if let Some(path) = find_path(&self.file_path) {
            let files = std::fs::read_dir(path.join("fixtures"))?;
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
                    tracing::trace!(
                        "Loading QLC+ Fixture from '{:?}'...",
                        path.file_name().unwrap()
                    );
                    match read_definition(&path) {
                        Ok(definition) => Some((
                            format!("{}:{}", definition.manufacturer, definition.model),
                            definition,
                        )),
                        Err(err) => {
                            tracing::error!(
                                "Could not load QLC+ Fixture from '{:?}': {:?}",
                                path.file_name().unwrap(),
                                err
                            );
                            None
                        }
                    }
                })
                .collect::<HashMap<_, _>>();

            tracing::info!("Loaded {} QLC+ Fixture Definitions", definitions.len());
            self.definitions = definitions;
        }

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
            .and_then(|def| {
                match map_fixture_definition(def, &resource_reader) {
                    Ok(def) => Some(def),
                    Err(err) => {
                        tracing::error!("Unable to map fixture definition: {err:?}");

                        None
                    }
                }
            })
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        let resource_reader = ResourceReader::new(Path::new(&self.file_path));

        self.definitions
            .values()
            .cloned()
            .flat_map(|def| {
                let name = def.model.clone();
                match map_fixture_definition(def, &resource_reader) {
                    Ok(def) => Some(def),
                    Err(err) => {
                        tracing::warn!("Unable to map fixture definition {name}: {err:?}");

                        None
                    }
                }
            })
            .collect()
    }
}

fn read_definition(path: &Path) -> anyhow::Result<QlcPlusFixtureDefinition> {
    let mut file = File::open(path)?;
    let mut content = String::new();
    file.read_to_string(&mut content)?;

    let definition = QlcPlusFixtureDefinition::from_str(&content)?;
    tracing::debug!(
        "Loaded QLC+ Fixture from '{:?}'.",
        path.file_name().unwrap()
    );

    Ok(definition)
}

#[cfg(test)]
mod tests {
    use std::path::Path;

    use hard_xml::XmlRead;
    use spectral::prelude::*;
    use mizer_fixtures::channels::{DmxChannel, DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel};

    use mizer_fixtures::definition::*;

    use super::{conversion::map_fixture_definition, QlcPlusFixtureDefinition, ResourceReader};

    const GENERIC_RGB_DEFINITION: &str = include_str!("../tests/Generic-Generic-RGB.qxf");
    const GENERIC_RGBW_DEFINITION: &str = include_str!("../tests/Generic-Generic-RGBW.qxf");
    const GENERIC_CMY_DEFINITION: &str = include_str!("../tests/Generic-Generic-CMY.qxf");
    const GENERIC_SMOKE_DEFINITION: &str = include_str!("../tests/Generic-Generic-Smoke.qxf");
    const CAMEO_ZENIT_B60_DEFINITION: &str = include_str!("../tests/Cameo-Zenit-B60.qxf");

    #[test]
    fn should_convert_generic_rgb() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("Generic RGB");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Generic");
        assert_that!(definition.modes.len()).is_equal_to(5);
    }

    #[test]
    fn should_convert_generic_rgb_mode_rgb() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "RGB");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
    }

    #[test]
    fn should_convert_generic_rgb_mode_grb() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "GRB");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
    }

    #[test]
    fn should_convert_generic_rgb_mode_bgr() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "BGR");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
    }

    #[test]
    fn should_convert_generic_rgb_mode_rgb_dimmer() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "RGB Dimmer");
        assert_that!(mode.channels).has_length(4);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::Intensity);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(3) });
    }

    #[test]
    fn should_convert_generic_rgb_mode_dimmer_rgb() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "Dimmer RGB");
        assert_that!(mode.channels).has_length(4);
        let channel = assert_channel(mode, FixtureChannel::Intensity);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(3) });
    }

    #[test]
    fn should_convert_generic_rgbw() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGBW_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("Generic RGBW");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Generic");
        assert_that!(definition.modes.len()).is_equal_to(6);
    }

    #[test]
    fn should_convert_generic_rgbw_mode_rgbw() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGBW_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "RGBW");
        assert_that!(mode.channels).has_length(4);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::White));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(3) });
    }

    #[test]
    fn should_convert_generic_rgbw_mode_wrgb() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGBW_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "WRGB");
        assert_that!(mode.channels).has_length(4);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::White));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(3) });
    }

    #[test]
    fn should_convert_generic_rgbw_mode_rgbw_dimmer() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGBW_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        let mode = assert_mode(&definition, "RGBW Dimmer");
        assert_that!(mode.channels).has_length(5);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::White));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(3) });
        let channel = assert_channel(mode, FixtureChannel::Intensity);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(4) });
    }

    #[test]
    fn should_convert_generic_cmy() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_CMY_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("Generic CMY");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Generic");
        assert_that!(definition.modes).has_length(1);
        let mode = assert_mode(&definition, "CMY");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Cyan));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Magenta));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Yellow));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
    }

    #[test]
    fn should_convert_generic_smoke() {
        let file = QlcPlusFixtureDefinition::from_str(GENERIC_SMOKE_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("Generic Smoke");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Generic");
        assert_that!(definition.modes).has_length(2);
        let mode = assert_mode(&definition, "Normal");
        assert_that!(mode.channels).has_length(2);
        println!("{:?}", mode.channels);
        let channel = assert_channel(mode, FixtureChannel::Intensity);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let mode = assert_mode(&definition, "Amount");
        assert_that!(mode.channels).has_length(1);
        let channel = assert_channel(mode, FixtureChannel::Intensity);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
    }

    #[test]
    fn should_convert_16bit_color_channels() {
        let file = QlcPlusFixtureDefinition::from_str(CAMEO_ZENIT_B60_DEFINITION).unwrap();
        let resource_reader = ResourceReader::new(Path::new("."));

        let definition = map_fixture_definition(file, &resource_reader).unwrap();
        
        let mode = assert_mode(&definition, "8 Channel Mode 1");
        assert_that!(mode.channels).has_length(4);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(0), fine: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(2), fine: DmxChannel::new(3) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(4), fine: DmxChannel::new(5) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::White));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(6), fine: DmxChannel::new(7) });
    }
    
    fn assert_mode<'a>(definition: &'a FixtureDefinition, name: &str) -> &'a FixtureChannelMode {
        assert_that!(definition.modes.iter().any(|m| m.name.as_str() == name)).named(&format!("Mode {name} not found"));
        definition.get_mode(name).unwrap()
    }

    fn assert_channel(mode: &FixtureChannelMode, channel: FixtureChannel) -> &FixtureChannelDefinition {
        assert_that!(mode.channels).contains_key(channel);
        mode.channels.get(&channel).unwrap()
    }
}
