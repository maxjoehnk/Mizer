use std::collections::HashMap;
use std::fmt::{Display, Formatter};
use std::str::FromStr;
use std::sync::Arc;
use base64::prelude::*;
use serde::{Deserialize, Serialize};
use mizer_fixtures::channels::{DmxChannel, DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureChannelPreset, FixtureColorChannel, FixtureImage, FixtureValue, SubFixtureChannelMode};
use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_util::{find_path, LerpExt};
use crate::conversion::map_fixture_definition;
use crate::definition::*;

mod conversion;
mod definition;

pub(crate) const PROVIDER_NAME: &str = "Open Fixture Library";

#[derive(Default)]
pub struct OpenFixtureLibraryProvider {
    file_path: String,
    definitions: HashMap<String, Vec<OpenFixtureLibraryFixtureDefinition>>,
}

impl Display for OpenFixtureLibraryProvider {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "OpenFixtureLibraryProvider({})", self.file_path)
    }
}

impl OpenFixtureLibraryProvider {
    pub fn new(file_path: String) -> Self {
        Self {
            file_path,
            definitions: Default::default(),
        }
    }

    fn add_fixture_definition(
        &mut self,
        manufacturer: &str,
        definition: OpenFixtureLibraryFixtureDefinition,
    ) {
        if let Some(definitions) = self.definitions.get_mut(manufacturer) {
            definitions.push(definition);
        } else {
            let definitions = vec![definition];
            self.definitions
                .insert(manufacturer.to_string(), definitions);
        }
    }
}

impl FixtureLibraryProvider for OpenFixtureLibraryProvider {
    fn name(&self) -> &'static str {
        PROVIDER_NAME
    }

    fn load(&mut self) -> anyhow::Result<()> {
        tracing::info!("Loading open fixture library...");
        if let Some(path) = find_path(&self.file_path) {
            let files = std::fs::read_dir(&path)?;
            for file in files {
                let file = file?;
                if file.metadata()?.is_file() {
                    tracing::trace!("Loading ofl library from '{:?}'...", file);
                    let mut ag_library_file = std::fs::File::open(&file.path())?;
                    let ag_library: AgLibraryFile =
                        simd_json::serde::from_reader(&mut ag_library_file)?;

                    for fixture in ag_library.fixtures {
                        let manufacturer = fixture.manufacturer.name.to_slug();
                        self.add_fixture_definition(&manufacturer, fixture);
                    }
                    tracing::debug!("Loaded ofl library from '{:?}'.", file);
                }
            }
        }
        tracing::info!("Loaded {} OFL Fixture Definitions", self.definitions.len());

        Ok(())
    }

    fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        if !id.starts_with("ofl:") {
            return None;
        }
        let id_parts = id.split(':').collect::<Vec<_>>();
        if let Some(definitions) = self.definitions.get(id_parts[1]) {
            definitions
                .iter()
                .find(|definition| definition.name.to_slug() == id_parts[2])
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
        } else {
            None
        }
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        self.definitions
            .values()
            .flatten()
            .cloned()
            .flat_map(|def| {
                let name = def.name.clone();
                match map_fixture_definition(def) {
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

pub(crate) trait SlugConverter {
    fn to_slug(&self) -> String;
}

impl SlugConverter for String {
    fn to_slug(&self) -> String {
        self.to_lowercase().replace([' ', '*'], "-")
    }
}

#[cfg(test)]
mod tests {
    use std::path::Path;

    use spectral::prelude::*;
    use mizer_fixtures::channels::{DmxChannel, DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel};

    use mizer_fixtures::definition::*;
    use crate::definition::AgLibraryFile;

    use super::{conversion::map_fixture_definition, OpenFixtureLibraryFixtureDefinition};

    const GENERIC_RGB_DEFINITION: &str = include_str!("../tests/generic-rgb.json");
    const GENERIC_DRGB_DEFINITION: &str = include_str!("../tests/generic-drgb.json");
    const GENERIC_PAN_TILT_DEFINITION: &str = include_str!("../tests/generic-pan-tilt.json");
    const GENERIC_CMY_DEFINITION: &str = include_str!("../tests/generic-cmy.json");
    const GENERIC_COLOR_TEMPERATURE_DEFINITION: &str = include_str!("../tests/generic-color-temperature.json");

    #[test]
    fn should_convert_generic_rgb() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("RGB Fader");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Generic");
        assert_that!(definition.modes.len()).is_equal_to(3);
    }

    #[test]
    fn should_convert_generic_rgb_mode_8bit() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        let mode = assert_mode(&definition, "8 bit");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
    }

    #[test]
    fn should_convert_generic_rgb_mode_16bit() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        let mode = assert_mode(&definition, "16 bit");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(0), fine: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(2), fine: DmxChannel::new(3) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(4), fine: DmxChannel::new(5) });
    }

    #[test]
    fn should_convert_generic_rgb_mode_24bit() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_RGB_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        let mode = assert_mode(&definition, "24 bit");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Red));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution24Bit { coarse: DmxChannel::new(0), fine: DmxChannel::new(1), finest: DmxChannel::new(2) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Green));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution24Bit { coarse: DmxChannel::new(3), fine: DmxChannel::new(4), finest: DmxChannel::new(5) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution24Bit { coarse: DmxChannel::new(6), fine: DmxChannel::new(7), finest: DmxChannel::new(8) });
    }

    #[test]
    fn should_convert_generic_cmy() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_CMY_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        assert_that!(definition.name.as_str()).is_equal_to("CMY Fader");
        assert_that!(definition.manufacturer.as_str()).is_equal_to("Generic");
        assert_that!(definition.modes).has_length(3);
    }

    #[test]
    fn should_convert_generic_cmy_mode_8bit() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_CMY_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        let mode = assert_mode(&definition, "8 bit");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Cyan));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(0) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Magenta));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Yellow));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution8Bit { coarse: DmxChannel::new(2) });
    }

    #[test]
    fn should_convert_generic_cmy_mode_16bit() {
        let ag_file: AgLibraryFile = serde_json::from_str(GENERIC_CMY_DEFINITION).unwrap();
        let definition = ag_file.fixtures.into_iter().next().unwrap();

        let definition = map_fixture_definition(definition).unwrap();

        let mode = assert_mode(&definition, "16 bit");
        assert_that!(mode.channels).has_length(3);
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Cyan));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(0), fine: DmxChannel::new(1) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Magenta));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(2), fine: DmxChannel::new(3) });
        let channel = assert_channel(mode, FixtureChannel::ColorMixer(FixtureColorChannel::Yellow));
        assert_that!(channel.channels).is_equal_to(DmxChannels::Resolution16Bit { coarse: DmxChannel::new(4), fine: DmxChannel::new(5) });
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
