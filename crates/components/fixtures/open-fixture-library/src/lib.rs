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

const COLOR_RED: &str = "#ff0000";
const COLOR_GREEN: &str = "#00ff00";
const COLOR_BLUE: &str = "#0000ff";
const COLOR_WHITE: &str = "#ffffff";
const COLOR_AMBER: &str = "#ffbf00";
const COLOR_CYAN: &str = "#0ff0fe";
const COLOR_MAGENTA: &str = "#ff00ff";
const COLOR_YELLOW: &str = "#ffff00";

const DMX_CHANNEL_RANGE: (u16, u16) = (0, 511);

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
        self.to_lowercase().replace([' ', '*'], "-")
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
    #[serde(default)]
    pub wheels: HashMap<String, WheelDefinition>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WheelDefinition {
    pub slots: Vec<WheelSlotDefinition>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "type")]
pub enum WheelSlotDefinition {
    Open,
    Closed,
    Color {
        #[serde(default)]
        name: Option<String>,
        #[serde(default)]
        colors: Vec<String>,
    },
    Gobo {
        #[serde(default)]
        name: Option<String>,
        #[serde(default)]
        resource: Option<Resource>,
    },
    Prism,
    Iris,
    Frost,
    AnimationGoboStart,
    AnimationGoboEnd,
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
    pub dmx_range: (u16, u16),
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
        #[serde(rename = "dmxRange")]
        dmx_range: (u16, u16),
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

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Resource {
    pub name: String,
    pub key: String,
    #[serde(rename = "type")]
    pub resource_type: String,
    pub image: ResourceImage,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ResourceImage {
    pub mime_type: String,
    pub extension: String,
    pub data: String,
    pub encoding: String,
}

impl From<OpenFixtureLibraryFixtureDefinition> for FixtureDefinition {
    fn from(def: OpenFixtureLibraryFixtureDefinition) -> Self {
        let available_channels = def.available_channels;
        let wheels = def.wheels;
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
                .map(|mode| build_fixture_mode(mode, &available_channels, &wheels))
                .collect(),
            tags: def.categories,
            physical: PhysicalFixtureData {
                weight: def.physical.weight,
                dimensions: convert_dimensions(def.physical.dimensions),
            },
            provider: "Open Fixture Library",
        }
    }
}

fn build_fixture_mode(
    mode: Mode,
    available_channels: &HashMap<String, Channel>,
    wheels: &HashMap<String, WheelDefinition>,
) -> FixtureChannelMode {
    let all_channels = mode.channels.into_iter().flatten().collect::<Vec<_>>();

    let (pixels, channels): (Vec<_>, Vec<_>) = all_channels
        .clone()
        .into_iter()
        .partition(|name| is_pixel_channel(name, available_channels));
    let sub_fixtures = group_sub_fixtures(available_channels, pixels, wheels, &all_channels);

    FixtureChannelMode::new(
        mode.name,
        build_channel_definitions(available_channels, &channels, wheels, &all_channels),
        sub_fixtures,
    )
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
    wheels: &HashMap<String, WheelDefinition>,
    all_channels: &[String],
) -> Vec<SubFixtureChannelMode> {
    let mut pixel_groups = HashMap::<String, Vec<String>>::new();

    for name in pixels {
        let channel = &available_channels[&name];
        let pixel_key = channel.pixel_key.clone().unwrap();
        let group = pixel_groups.entry(pixel_key).or_default();

        group.push(name);
    }

    let mut sub_fixtures: Vec<_> = pixel_groups
        .into_iter()
        .map(|(key, channels)| build_sub_fixture(key, available_channels, channels, wheels, all_channels))
        .collect();

    sub_fixtures.sort_by_key(|f| f.id);

    sub_fixtures
}

fn build_sub_fixture(
    key: String,
    available_channels: &HashMap<String, Channel>,
    channels: Vec<String>,
    wheels: &HashMap<String, WheelDefinition>,
    all_channels: &[String],
) -> SubFixtureChannelMode {
    let id = key
        .parse::<u32>()
        .unwrap_or_else(|_| panic!("'{}' is not a number", key));

    SubFixtureChannelMode::new(
        id,
        format!("Pixel {}", key),
        build_channel_definitions(available_channels, &channels, wheels, all_channels).into(),
    )
}

fn build_channel_definitions(
    available_channels: &HashMap<String, Channel>,
    enabled_channels: &[String],
    wheels: &HashMap<String, WheelDefinition>,
    all_channels: &[String],
) -> Vec<FixtureChannelDefinition> {
    let channels = all_channels
        .iter()
        .enumerate()
        .filter(|(_, name)| enabled_channels.contains(name))
        .filter_map(|(index, name)| {
            available_channels
                .get(name)
                .map(|channel| (index as u16, name.clone(), channel))
        })
        .collect::<Vec<_>>();

    let mut channel_definitions = Vec::new();

    let mut channels_to_omit = Vec::new();

    for (i, name, channel) in channels {
        if channels_to_omit.contains(&name) {
            continue;
        }
        let fine_channel_aliases = channel.fine_channel_aliases.iter()
            .map(|name| {
                if let Some(fine_channel) = all_channels.iter().position(|c| c == name) {
                    Some((name.clone(), fine_channel as u16))
                }else {
                    None
                }
            }).collect::<Vec<_>>();
        let dmx_channels = match fine_channel_aliases[..] {
            [Some((fine_name, fine_channel))] => {
                channels_to_omit.push(fine_name.to_string());
                DmxChannels::Resolution16Bit {
                    coarse: DmxChannel::new(i as u16),
                    fine: DmxChannel::new(fine_channel),
                }
            }
            [Some((fine_name, fine_channel)), Some((finest_name, finest_channel))] => {
                channels_to_omit.push(fine_name.to_string());
                channels_to_omit.push(finest_name.to_string());
                DmxChannels::Resolution24Bit {
                    coarse: DmxChannel::new(i as u16),
                    fine: DmxChannel::new(fine_channel),
                    finest: DmxChannel::new(finest_channel),
                }
            }
            [Some((fine_name, fine_channel)), Some((finest_name, finest_channel)), Some((ultra_name, ultra_channel))] => {
                channels_to_omit.push(fine_name.to_string());
                channels_to_omit.push(finest_name.to_string());
                channels_to_omit.push(ultra_name.to_string());
                DmxChannels::Resolution32Bit {
                    coarse: DmxChannel::new(i as u16),
                    fine: DmxChannel::new(fine_channel),
                    finest: DmxChannel::new(finest_channel),
                    ultra: DmxChannel::new(ultra_channel),
                }
            }
            _ => DmxChannels::Resolution8Bit {
                coarse: DmxChannel::new(i as u16),
            }
        };

        let channel_builder = FixtureChannelDefinition::builder()
            .label(name.clone().into())
            .channels(dmx_channels);
        
        if channel
            .capabilities
            .iter()
            .all(|c| matches!(c, Capability::NoFunction))
        {
            tracing::trace!("skipping capability {} as it has no functions", name);
            continue;
        }
        if channel
            .capabilities
            .iter()
            .any(|c| matches!(c, Capability::WheelSlot(_)))
        {
            if let Some(wheel) = wheels.get(&name) {
                let used_slots = channel.capabilities.iter().filter_map(|c| {
                    if let Capability::WheelSlot(WheelSlot::Single {
                                                     slot_number,
                                                     dmx_range,
                                                 }) = c
                    {
                        Some((slot_number, dmx_range))
                    } else {
                        None
                    }
                });
                if wheel
                    .slots
                    .iter()
                    .any(|s| matches!(s, WheelSlotDefinition::Gobo { .. }))
                {
                    let channel_builder = channel_builder.channel(FixtureChannel::GoboWheel)
                        .presets(
                            used_slots
                                .filter_map(|(slot_index, dmx_range)| {
                                    let value =
                                        dmx_range.0.linear_extrapolate(DMX_CHANNEL_RANGE, (0., 1.));
                                    if let WheelSlotDefinition::Gobo { name, resource } =
                                        &wheel.slots[(*slot_index as usize) - 1]
                                    {
                                        let name = name
                                            .clone()
                                            .unwrap_or_else(|| format!("Gobo {}", slot_index));

                                        Some(FixtureChannelPreset {
                                            name,
                                            value: FixtureValue::Percent(value),
                                            image: resource.clone().map(FixtureImage::from),
                                            color: Default::default(),
                                        })
                                    } else {
                                        None
                                    }
                                })
                                .collect()
                        );

                    channel_definitions.push(channel_builder.build());
                    continue;
                }
                if wheel
                    .slots
                    .iter()
                    .any(|s| matches!(s, WheelSlotDefinition::Color { .. }))
                {
                    let channel_builder = channel_builder.channel(FixtureChannel::GoboWheel)
                        .presets(
                            used_slots
                                .filter_map(|(slot_index, dmx_range)| {
                                    let value =
                                        dmx_range.0.linear_extrapolate(DMX_CHANNEL_RANGE, (0., 1.));
                                    if let WheelSlotDefinition::Color { name, colors } =
                                        &wheel.slots[(*slot_index as usize) - 1]
                                    {
                                        let name = name
                                            .clone()
                                            .unwrap_or_else(|| format!("Color {}", slot_index));

                                        Some(FixtureChannelPreset {
                                            name,
                                            value: FixtureValue::Percent(value),
                                            image: None,
                                            color: colors.clone(),
                                        })
                                    } else {
                                        None
                                    }
                                })
                                .collect()
                        );

                    channel_definitions.push(channel_builder.build());
                    continue;
                }
            }
        }
        let channel = match channel
            .capabilities
            .iter()
            .find(|c| !matches!(c, Capability::NoFunction))
        {
            Some(Capability::Intensity) => FixtureChannel::Intensity,
            Some(Capability::ColorIntensity { color }) if color == COLOR_RED => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Red)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_GREEN => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Green)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_BLUE => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Blue)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_WHITE => {
                FixtureChannel::ColorMixer(FixtureColorChannel::White)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_AMBER => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Amber)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_CYAN => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Cyan)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_MAGENTA => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Magenta)
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_YELLOW => {
                FixtureChannel::ColorMixer(FixtureColorChannel::Yellow)
            }
            Some(Capability::Pan { .. }) => FixtureChannel::Pan,
            Some(Capability::Tilt { .. }) => FixtureChannel::Tilt,
            Some(Capability::Focus) => FixtureChannel::Focus,
            Some(Capability::Zoom) => FixtureChannel::Zoom,
            Some(Capability::Prism) => FixtureChannel::Prism,
            Some(Capability::Iris) => FixtureChannel::Iris,
            Some(Capability::Frost) => FixtureChannel::Frost,
            Some(Capability::ShutterStrobe { .. }) => FixtureChannel::Shutter,
            Some(Capability::PanContinuous) => FixtureChannel::PanEndless,
            Some(Capability::TiltContinuous) => FixtureChannel::TiltEndless,
            capability => {
                tracing::warn!("Unsupported capability: {:?}", capability);

                continue
            }
        };
        
        let channel_builder = channel_builder.channel(channel);

        channel_definitions.push(channel_builder.build());
    }

    channel_definitions
}

impl From<Resource> for FixtureImage {
    fn from(resource: Resource) -> Self {
        match resource.image.encoding.as_str() {
            "utf8" => FixtureImage::Svg(Arc::new(resource.image.data)),
            _ => FixtureImage::Raster(Arc::new(
                BASE64_STANDARD.decode(resource.image.data).unwrap(),
            )),
        }
    }
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    

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

        let controls = group_controls(&available_channels, &enabled_channels, &Default::default());

        assert!(controls.color_mixer.is_some());
        assert_eq!(
            controls.color_mixer.unwrap(),
            ColorGroup::Rgb {
                red: "Red".into(),
                green: "Green".into(),
                blue: "Blue".into(),
                amber: None,
                white: None,
            }
        );
    }

    #[test]
    fn group_controls_should_group_white_color_channel() {
        let enabled_channels: Vec<String> =
            vec!["Red".into(), "Green".into(), "Blue".into(), "White".into()];
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
        available_channels.insert(
            "White".into(),
            Channel {
                fine_channel_aliases: Vec::default(),
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#ffffff".into(),
                }],
                pixel_key: None,
            },
        );

        let controls = group_controls(&available_channels, &enabled_channels, &Default::default());

        assert!(controls.color_mixer.is_some());
        assert_eq!(
            controls.color_mixer.unwrap(),
            ColorGroup::Rgb {
                red: "Red".into(),
                green: "Green".into(),
                blue: "Blue".into(),
                amber: None,
                white: Some("White".into()),
            }
        );
    }

    #[test]
    fn group_controls_should_group_amber_color_channel() {
        let enabled_channels: Vec<String> =
            vec!["Red".into(), "Green".into(), "Blue".into(), "Amber".into()];
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
        available_channels.insert(
            "Amber".into(),
            Channel {
                fine_channel_aliases: Vec::default(),
                default_value: None,
                capabilities: vec![Capability::ColorIntensity {
                    color: "#ffbf00".into(),
                }],
                pixel_key: None,
            },
        );

        let controls = group_controls(&available_channels, &enabled_channels, &Default::default());

        assert!(controls.color_mixer.is_some());
        assert_eq!(
            controls.color_mixer.unwrap(),
            ColorGroup::Rgb {
                red: "Red".into(),
                green: "Green".into(),
                blue: "Blue".into(),
                white: None,
                amber: Some("Amber".into()),
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

        let groups = group_controls(&available_channels, &enabled_channels, &Default::default());

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
