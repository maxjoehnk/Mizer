use mizer_fixtures::fixture::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Default)]
pub struct OpenFixtureLibraryProvider {
    definitions: HashMap<String, Vec<OpenFixtureLibraryFixtureDefinition>>,
}

impl OpenFixtureLibraryProvider {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn load(&mut self, path: &str) -> anyhow::Result<()> {
        let files = std::fs::read_dir(path)?;
        for file in files {
            let file = file?;
            if file.metadata()?.is_file() {
                let mut ag_library_file = std::fs::File::open(&file.path())?;
                let ag_library: AgLibraryFile = serde_json::from_reader(&mut ag_library_file)?;

                for fixture in ag_library.fixtures {
                    let manufacturer = fixture.manufacturer.name.to_slug();
                    self.add_fixture_definition(&manufacturer, fixture);
                }
            }
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
                .find(|definition| definition.name.to_slug() == id_parts[2])
                .cloned()
                .map(FixtureDefinition::from)
        } else {
            None
        }
    }

    fn list_definitions(&self) -> Vec<FixtureDefinition> {
        self.definitions
            .values()
            .flatten()
            .cloned()
            .map(FixtureDefinition::from)
            .collect()
    }
}

trait SlugConverter {
    fn to_slug(&self) -> String;
}

impl SlugConverter for String {
    fn to_slug(&self) -> String {
        self.to_lowercase().replace(" ", "-").replace("*", "-")
    }
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
    #[serde(default)]
    pub physical: Physical,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FixtureManufacturer {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Channel {
    pub default_value: Option<Value>,
    pub capabilities: Vec<Capability>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum Value {
    Dmx(u32),
    Percentage(String),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum CapabilityChannel {
    Single(SingleCapabilityChannel),
    Multi(MultiCapabilityChannel),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SingleCapabilityChannel {
    #[serde(flatten)]
    pub capability: Capability,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct MultiCapabilityChannel {
    pub dmx_range: (u8, u8),
    #[serde(flatten)]
    pub capability: Capability,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "type")]
pub enum Capability {
    Generic,
    Fog,
    FogOutput,
    FogType,
    Intensity,
    NoFunction,
    Maintenance,
    ColorIntensity {
        color: String,
    },
    ColorPreset {
        #[serde(default)]
        colors: Vec<String>,
    },
    ColorTemperature,
    Effect,
    EffectSpeed,
    EffectParameter,
    EffectDuration,
    ShutterStrobe {
        #[serde(rename = "shutterEffect")]
        shutter_effect: String,
        // #[serde(rename = "speedStart")]
        // speed_start: Option<u8>,
        // #[serde(rename = "speedEnd")]
        // speed_end: Option<u8>,
    },
    StrobeDuration,
    StrobeSpeed,
    SoundSensitivity,
    Pan {
        #[serde(rename = "angleStart")]
        angle_start: f32,
        #[serde(rename = "angleEnd")]
        angle_end: f32,
    },
    PanContinuous,
    Tilt {
        #[serde(rename = "angleStart")]
        angle_start: f32,
        #[serde(rename = "angleEnd")]
        angle_end: f32,
    },
    TiltContinuous,
    PanTiltSpeed,
    Rotation,
    WheelSlot(WheelSlot),
    WheelRotation,
    WheelSlotRotation,
    WheelShake,
    Prism,
    PrismRotation,
    Focus,
    Zoom,
    Iris,
    IrisEffect,
    Frost,
    FrostEffect,
    BladeRotation,
    BladeInsertion,
    BladeSystemRotation,
    Speed,
    Time,
    BeamPosition,
    BeamAngle,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(untagged)]
pub enum WheelSlot {
    Single {
        #[serde(rename = "slotNumber")]
        slot_number: f32,
    },
    Range {
        #[serde(rename = "slotNumberStart")]
        slot_number_start: f32,
        #[serde(rename = "slotNumberEnd")]
        slot_number_end: f32,
    },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Mode {
    pub name: String,
    pub short_name: Option<String>,
    pub channels: Vec<Option<String>>,
}

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct Physical {
    #[serde(default)]
    pub dimensions: Vec<f32>,
    #[serde(default)]
    pub weight: Option<f32>,
    pub power: Option<f32>,
    #[serde(rename = "DMXconnector", default)]
    pub dmx_connector: Option<String>,
}

impl From<OpenFixtureLibraryFixtureDefinition> for FixtureDefinition {
    fn from(def: OpenFixtureLibraryFixtureDefinition) -> Self {
        let available_channels = def.available_channels;
        FixtureDefinition {
            id: format!(
                "ofl:{}:{}",
                def.manufacturer.name.to_slug(),
                def.name.to_slug()
            ),
            name: def.name,
            manufacturer: def.manufacturer.name,
            modes: def
                .modes
                .into_iter()
                .map(|mode| {
                    let channels = mode.channels.into_iter().flatten().collect::<Vec<_>>();
                    FixtureMode {
                        name: mode.name,
                        groups: group_channels(&available_channels, &channels),
                        channels: channels
                            .into_iter()
                            .enumerate()
                            .map(|(i, channel)| FixtureChannelDefinition {
                                name: channel,
                                resolution: ChannelResolution::Coarse(i as u8),
                            })
                            .collect(),
                    }
                })
                .collect(),
            tags: def.categories,
            physical: PhysicalFixtureData {
                weight: def.physical.weight,
                dimensions: convert_dimensions(def.physical.dimensions),
            },
        }
    }
}

fn convert_dimensions(dimensions: Vec<f32>) -> Option<FixtureDimensions> {
    match dimensions.as_slice() {
        [width, height, depth] => Some(FixtureDimensions {
            width: *width,
            height: *height,
            depth: *depth,
        }),
        _ => None,
    }
}

fn group_channels(
    available_channels: &HashMap<String, Channel>,
    enabled_channels: &[String],
) -> Vec<FixtureChannelGroup> {
    let channels = enabled_channels
        .iter()
        .filter_map(|name| {
            available_channels
                .get(name)
                .map(|channel| (name.clone(), channel))
        })
        .collect::<Vec<_>>();

    log::debug!("{:?}", channels);

    let mut color_group = ColorGroupBuilder::new();
    let mut groups = Vec::new();

    for (name, channel) in channels {
        match channel.capabilities.first() {
            // TODO: reenable when color support in ui is working properly
            // Some(Capability::ColorIntensity { color }) if color == "#ff0000" => {
            //     color_group.red(name.clone());
            // },
            // Some(Capability::ColorIntensity { color }) if color == "#00ff00" => {
            //     color_group.green(name.clone());
            // },
            // Some(Capability::ColorIntensity { color }) if color == "#0000ff" => {
            //     color_group.blue(name.clone());
            // },
            Some(_) => groups.push(FixtureChannelGroup {
                name: name.clone(),
                group_type: FixtureChannelGroupType::Generic(name.clone()),
            }),
            _ => {}
        }
    }

    if let Some(color_group) = color_group.build() {
        groups.push(FixtureChannelGroup {
            name: "Color".into(),
            group_type: FixtureChannelGroupType::Color(color_group),
        });
    }

    log::debug!("in: {:?}, out: {:?}", enabled_channels, groups);

    groups
}

#[derive(Default)]
struct ColorGroupBuilder {
    red: Option<String>,
    green: Option<String>,
    blue: Option<String>,
}

impl ColorGroupBuilder {
    fn new() -> Self {
        Default::default()
    }

    fn red(&mut self, channel: String) {
        self.red = channel.into();
    }

    fn green(&mut self, channel: String) {
        self.green = channel.into();
    }

    fn blue(&mut self, channel: String) {
        self.blue = channel.into();
    }

    fn build(self) -> Option<ColorGroup> {
        match (self.red, self.green, self.blue) {
            (Some(red), Some(green), Some(blue)) => ColorGroup { red, green, blue }.into(),
            _ => None,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::group_channels;
    use crate::{Capability, Channel};
    use mizer_fixtures::fixture::{ColorGroup, FixtureChannelGroup, FixtureChannelGroupType};
    use std::collections::HashMap;

    // TODO: reenable when color support in ui is working properly
    #[test]
    #[ignore]
    fn group_channels_should_group_color_channels() {
        let enabled_channels: Vec<String> = vec!["Red".into(), "Green".into(), "Blue".into()];
        let mut available_channels = HashMap::new();
        available_channels.insert(
            "Red".into(),
            Channel {
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#ff0000".into(),
                }],
            },
        );
        available_channels.insert(
            "Green".into(),
            Channel {
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#00ff00".into(),
                }],
            },
        );
        available_channels.insert(
            "Blue".into(),
            Channel {
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#0000ff".into(),
                }],
            },
        );

        let groups = group_channels(&available_channels, &enabled_channels);

        assert_eq!(
            groups,
            vec![FixtureChannelGroup {
                name: "Color".into(),
                group_type: FixtureChannelGroupType::Color(ColorGroup {
                    red: "Red".into(),
                    green: "Green".into(),
                    blue: "Blue".into(),
                })
            }]
        );
    }

    #[test]
    fn group_channels_should_return_empty_list_for_fixture_without_channels() {
        let enabled_channels = Vec::new();
        let available_channels = HashMap::new();

        let groups = group_channels(&available_channels, &enabled_channels);

        assert!(groups.is_empty());
    }

    #[test]
    fn group_channels_should_map_generic_channels() {
        let enabled_channels = vec!["Channel".into()];
        let mut available_channels = HashMap::new();
        available_channels.insert(
            "Channel".into(),
            Channel {
                default_value: None,
                capabilities: vec![Capability::Generic],
            },
        );

        let groups = group_channels(&available_channels, &enabled_channels);

        assert_eq!(
            groups,
            vec![FixtureChannelGroup {
                name: "Channel".into(),
                group_type: FixtureChannelGroupType::Generic("Channel".into()),
            }]
        );
    }
}
