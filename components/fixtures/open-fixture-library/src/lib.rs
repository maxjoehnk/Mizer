use std::collections::HashMap;
use std::str::FromStr;

use serde::{Deserialize, Serialize};

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;

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
    #[serde(default)]
    pub matrix: Option<Matrix>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FixtureManufacturer {
    pub name: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Channel {
    #[serde(default)]
    pub fine_channel_aliases: Vec<String>,
    pub default_value: Option<Value>,
    pub capabilities: Vec<Capability>,
    #[serde(default)]
    pub pixel_key: Option<String>,
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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Matrix {
    #[serde(flatten)]
    pub pixels: MatrixPixels,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum MatrixPixels {
    PixelKeys(Vec<Vec<Vec<Option<String>>>>),
    PixelCount([u32; 3]),
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
                .map(|mode| build_fixture_mode(mode, &available_channels))
                .collect(),
            tags: def.categories,
            physical: PhysicalFixtureData {
                weight: def.physical.weight,
                dimensions: convert_dimensions(def.physical.dimensions),
            },
        }
    }
}

fn build_fixture_mode(mode: Mode, available_channels: &HashMap<String, Channel>) -> FixtureMode {
    let all_channels = mode.channels.into_iter().flatten().collect::<Vec<_>>();

    let (pixels, channels): (Vec<_>, Vec<_>) = all_channels
        .clone()
        .into_iter()
        .partition(|name| is_pixel_channel(name, available_channels));

    FixtureMode {
        name: mode.name,
        controls: group_controls(available_channels, &channels),
        channels: map_channels(available_channels, all_channels),
        sub_fixtures: group_sub_fixtures(available_channels, pixels),
    }
}

fn map_channels(
    available_channels: &HashMap<String, Channel>,
    channels: Vec<String>,
) -> Vec<FixtureChannelDefinition> {
    let channels_2 = channels.clone();

    channels
        .into_iter()
        .enumerate()
        .map(|(i, channel)| {
            let fine_channels = available_channels
                .get(&channel)
                .map(|c| &c.fine_channel_aliases[..]);
            match fine_channels {
                Some(&[ref fine]) => {
                    let fine_channel = channels_2.iter().position(|c| c == fine);
                    if let Some(fine_channel) = fine_channel {
                        FixtureChannelDefinition {
                            name: channel,
                            resolution: ChannelResolution::Fine(i as u8, fine_channel as u8),
                        }
                    } else {
                        FixtureChannelDefinition {
                            name: channel,
                            resolution: ChannelResolution::Coarse(i as u8),
                        }
                    }
                }
                Some(&[ref fine, ref finest]) => {
                    let fine_channel = channels_2.iter().position(|c| c == fine);
                    let finest_channel = channels_2.iter().position(|c| c == fine);
                    if let Some(fine_channel) = fine_channel {
                        if let Some(finest_channel) = finest_channel {
                            FixtureChannelDefinition {
                                name: channel,
                                resolution: ChannelResolution::Finest(
                                    i as u8,
                                    fine_channel as u8,
                                    finest_channel as u8,
                                ),
                            }
                        } else {
                            FixtureChannelDefinition {
                                name: channel,
                                resolution: ChannelResolution::Fine(i as u8, fine_channel as u8),
                            }
                        }
                    } else {
                        FixtureChannelDefinition {
                            name: channel,
                            resolution: ChannelResolution::Coarse(i as u8),
                        }
                    }
                }
                _ => FixtureChannelDefinition {
                    name: channel,
                    resolution: ChannelResolution::Coarse(i as u8),
                },
            }
        })
        .collect()
}

fn is_pixel_channel(channel_name: &str, available_channels: &HashMap<String, Channel>) -> bool {
    if let Some(channel) = available_channels.get(channel_name) {
        // TODO: this excludes certain fixtures because of the way the pixelKeys are called.
        if let Some(ref key) = channel.pixel_key {
            if u32::from_str(key).is_ok() {
                return true;
            }
        }
    }
    false
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

fn group_sub_fixtures(
    available_channels: &HashMap<String, Channel>,
    pixels: Vec<String>,
) -> Vec<SubFixtureDefinition> {
    let mut pixel_groups = HashMap::<String, Vec<String>>::new();

    for name in pixels {
        let channel = &available_channels[&name];
        let pixel_key = channel.pixel_key.clone().unwrap();
        let group = pixel_groups.entry(pixel_key).or_default();

        group.push(name);
    }

    let mut sub_fixtures: Vec<_> = pixel_groups
        .into_iter()
        .map(|(key, channels)| build_sub_fixture(key, available_channels, channels))
        .collect();

    sub_fixtures.sort_by_key(|f| f.id);

    sub_fixtures
}

fn build_sub_fixture(
    key: String,
    available_channels: &HashMap<String, Channel>,
    channels: Vec<String>,
) -> SubFixtureDefinition {
    let definition = SubFixtureDefinition {
        id: u32::from_str_radix(&key, 10).expect(&format!("'{}' is not a number", key)),
        name: format!("Pixel {}", key),
        controls: group_controls(available_channels, &channels),
    };

    definition
}

fn group_controls(
    available_channels: &HashMap<String, Channel>,
    enabled_channels: &[String],
) -> FixtureControls {
    let channels = enabled_channels
        .iter()
        .filter_map(|name| {
            available_channels
                .get(name)
                .map(|channel| (name.clone(), channel))
        })
        .collect::<Vec<_>>();

    let mut color_group = ColorGroupBuilder::new();
    let mut controls = FixtureControls::default();

    for (name, channel) in channels {
        if channel
            .capabilities
            .iter()
            .all(|c| matches!(c, Capability::NoFunction))
        {
            log::trace!("skipping capability {} as it has no functions", name);
            continue;
        }
        match channel
            .capabilities
            .iter()
            .find(|c| !matches!(c, Capability::NoFunction))
        {
            Some(Capability::Intensity) => {
                controls.intensity = Some(name);
            }
            Some(Capability::ColorIntensity { color }) if color == "#ff0000" => {
                color_group.red(name.clone());
            }
            Some(Capability::ColorIntensity { color }) if color == "#00ff00" => {
                color_group.green(name.clone());
            }
            Some(Capability::ColorIntensity { color }) if color == "#0000ff" => {
                color_group.blue(name.clone());
            }
            Some(Capability::Pan {
                angle_start,
                angle_end,
            }) => {
                controls.pan = Some(AxisGroup {
                    channel: name,
                    angle: Some(Angle {
                        from: *angle_start,
                        to: *angle_end,
                    }),
                })
            }
            Some(Capability::Tilt {
                angle_start,
                angle_end,
            }) => {
                controls.tilt = Some(AxisGroup {
                    channel: name.clone(),
                    angle: Some(Angle {
                        from: *angle_start,
                        to: *angle_end,
                    }),
                })
            }
            Some(Capability::Focus) => {
                controls.focus = Some(name);
            }
            Some(Capability::Zoom) => {
                controls.zoom = Some(name);
            }
            Some(Capability::Prism) => {
                controls.prism = Some(name);
            }
            Some(Capability::Iris) => {
                controls.iris = Some(name);
            }
            Some(Capability::Frost) => {
                controls.frost = Some(name);
            }
            Some(Capability::ShutterStrobe { .. }) => {
                controls.shutter = Some(name);
            }
            Some(_) => controls.generic.push(GenericControl {
                label: name.clone(),
                channel: name,
            }),
            _ => {}
        }
    }

    controls.color = color_group.build();

    controls
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
    use std::collections::HashMap;

    use mizer_fixtures::definition::{ColorGroup, FixtureChannelGroupType, GenericControl};

    use crate::{Capability, Channel};

    use super::group_controls;

    #[test]
    fn group_controls_should_group_color_channels() {
        let enabled_channels: Vec<String> = vec!["Red".into(), "Green".into(), "Blue".into()];
        let mut available_channels = HashMap::new();
        available_channels.insert(
            "Red".into(),
            Channel {
                fine_channel_aliases: Vec::default(),
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#ff0000".into(),
                }],
                pixel_key: None,
            },
        );
        available_channels.insert(
            "Green".into(),
            Channel {
                fine_channel_aliases: Vec::default(),
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#00ff00".into(),
                }],
                pixel_key: None,
            },
        );
        available_channels.insert(
            "Blue".into(),
            Channel {
                fine_channel_aliases: Vec::default(),
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#0000ff".into(),
                }],
                pixel_key: None,
            },
        );

        let controls = group_controls(&available_channels, &enabled_channels);

        assert!(controls.color.is_some());
        assert_eq!(
            controls.color.unwrap(),
            ColorGroup {
                red: "Red".into(),
                green: "Green".into(),
                blue: "Blue".into(),
            }
        );
    }

    #[test]
    fn group_controls_should_map_generic_channels() {
        let enabled_channels = vec!["Channel".into()];
        let mut available_channels = HashMap::new();
        available_channels.insert(
            "Channel".into(),
            Channel {
                fine_channel_aliases: Vec::default(),
                default_value: None,
                capabilities: vec![Capability::Generic],
                pixel_key: None,
            },
        );

        let groups = group_controls(&available_channels, &enabled_channels);

        assert_eq!(groups.generic.len(), 1);
        assert_eq!(
            groups.generic[0],
            GenericControl {
                label: "Channel".into(),
                channel: "Channel".into()
            }
        );
    }
}
