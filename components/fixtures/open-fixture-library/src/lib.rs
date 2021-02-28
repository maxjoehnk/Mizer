use mizer_fixtures::fixture::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

pub struct OpenFixtureLibraryProvider {
    definitions: HashMap<String, Vec<OpenFixtureLibraryFixtureDefinition>>,
}

impl OpenFixtureLibraryProvider {
    pub fn new() -> Self {
        OpenFixtureLibraryProvider {
            definitions: Default::default(),
        }
    }

    pub fn load(&mut self, path: &str) -> anyhow::Result<()> {
        let mut ag_library_file = std::fs::File::open(path)?;
        let ag_library: AgLibraryFile = serde_json::from_reader(&mut ag_library_file)?;

        for fixture in ag_library.fixtures {
            let manufacturer = fixture.manufacturer.name.to_lowercase().replace(" ", "-");
            self.add_fixture_definition(&manufacturer, fixture);
        }

        Ok(())
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
    fn get_definition(&self, id: &str) -> Option<FixtureDefinition> {
        if !id.starts_with("ofl:") {
            return None;
        }
        let id_parts = id.split(':').collect::<Vec<_>>();
        if let Some(definitions) = self.definitions.get(id_parts[1]) {
            definitions
                .iter()
                .find(|definition| normalize_model(&definition.name) == id_parts[2])
                .cloned()
                .map(FixtureDefinition::from)
        } else {
            None
        }
    }
}

fn normalize_model(model: &str) -> String {
    model.replace("*", "-")
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct AgLibraryFile {
    pub fixtures: Vec<OpenFixtureLibraryFixtureDefinition>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct OpenFixtureLibraryFixtureDefinition {
    pub name: String,
    pub short_name: Option<String>,
    #[serde(default)]
    pub categories: Vec<String>,
    #[serde(default)]
    pub available_channels: HashMap<String, Channel>,
    #[serde(default)]
    pub modes: Vec<Mode>,
    pub fixture_key: String,
    pub manufacturer: FixtureManufacturer,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FixtureManufacturer {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Channel {}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Mode {
    pub name: String,
    pub short_name: Option<String>,
    pub channels: Vec<Option<String>>,
}

impl From<OpenFixtureLibraryFixtureDefinition> for FixtureDefinition {
    fn from(def: OpenFixtureLibraryFixtureDefinition) -> Self {
        FixtureDefinition {
            name: def.name,
            manufacturer: def.manufacturer.name,
            modes: def
                .modes
                .into_iter()
                .map(|mode| FixtureMode {
                    name: mode.name,
                    channels: mode
                        .channels
                        .into_iter()
                        .filter_map(|channel| channel)
                        .enumerate()
                        .map(|(i, channel)| FixtureChannelDefinition {
                            name: channel,
                            resolution: ChannelResolution::Coarse(i as u8),
                        })
                        .collect(),
                })
                .collect(),
        }
    }
}
