use std::collections::HashMap;
use std::fmt::{Display, Formatter};
use std::io::{Cursor, Read, Seek};
use std::path::Path;

use hard_xml::XmlRead;
use rayon::prelude::*;
use zip::ZipArchive;

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_util::find_path;
use crate::conversion::map_fixture_definition;

pub use self::definition::GdtfFixtureDefinition;

mod conversion;
mod definition;
mod types;

pub(crate) const PROVIDER_NAME: &str = "GDTF";

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
    fn name(&self) -> &'static str {
        PROVIDER_NAME
    }

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
            .and_then(|def| {
                match map_fixture_definition(def) {
                    Ok(def) => Some(def),
                    Err(err) => {
                        tracing::error!("Unable to map fixture definition: {err:?}");

                        None
                    }
                }
            })
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        self.definitions
            .values()
            .cloned()
            .flat_map(|def| {
                match map_fixture_definition(def) {
                    Ok(def) => Some(def),
                    Err(err) => {
                        tracing::error!("Unable to map fixture definition: {err:?}");

                        None
                    }
                }
            })
            .collect()
    }
}

struct GdtfArchive {
    definition: GdtfFixtureDefinition,
}

impl GdtfArchive {
    fn read(path: &Path) -> anyhow::Result<Self> {
        let file = std::fs::File::open(path)?;
        
        Self::read_archive(file)
    }
    
    fn read_slice(buffer: &[u8]) -> anyhow::Result<Self> {
        let cursor = Cursor::new(buffer);
        
        Self::read_archive(cursor)
    }
    
    fn read_archive<T: Read + Seek>(reader: T) -> anyhow::Result<Self> {
        let mut reader = ZipArchive::new(reader)?;

        let mut description = String::new();
        let mut description_file = reader.by_name("description.xml")?;

        description_file.read_to_string(&mut description)?;
        let definition = GdtfFixtureDefinition::from_str(&description)?;

        Ok(Self { definition })
    }
}

#[cfg(test)]
mod tests {
    use spectral::prelude::*;
    use mizer_fixtures::channels::{DmxChannel, DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel, FixtureValue};

    use mizer_fixtures::definition::*;

    use super::{conversion::map_fixture_definition, GdtfArchive};

    const CAMEO_ZENIT_W600_DEFINITION: &[u8] = include_bytes!("../tests/Cameo@ZENIT_W600@First_Data_without_DMX_Library.gdtf");
    const ELATION_FUZE_MAX_PROFILE_DEFINITION: &[u8] = include_bytes!("../tests/Elation@Fuze_Max_Profile@Release_2024-17-05.gdtf");
    const ELATION_FUZE_MAX_SPOT_DEFINITION: &[u8] = include_bytes!("../tests/Elation@Fuze_Max_Spot@2023-04-04_First_Release.gdtf");

    #[test]
    fn should_convert_cameo_zenit_w600() {
        let file = GdtfArchive::read_slice(CAMEO_ZENIT_W600_DEFINITION).unwrap();
        let definition = file.definition;

        let definition = map_fixture_definition(definition).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("ZENIT W600");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Cameo");
        assert_that!(definition.modes.len()).is_equal_to(1);
        let mode = assert_mode(&definition, "Default");
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.default).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.highlight).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.default).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.highlight).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.default).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.highlight).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Amber));
        assert_that!(channel.default).is_equal_to(Some(FixtureValue::Percent(0.)));
        assert_that!(channel.highlight).is_equal_to(None);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(3) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::White));
        assert_that!(channel.default).is_equal_to(Some(FixtureValue::Percent(0.)));
        assert_that!(channel.highlight).is_equal_to(None);
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(4) });
        let channel = assert_channel(mode, FixtureChannel::Intensity);
        assert_that!(channel.default).is_equal_to(Some(FixtureValue::Percent(0.)));
        assert_that!(channel.highlight).is_equal_to(Some(FixtureValue::Percent(1.)));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(5) });
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