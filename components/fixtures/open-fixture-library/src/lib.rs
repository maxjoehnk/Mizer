use std::collections::HashMap;
use std::path::Path;
use std::str::FromStr;

use serde::{Deserialize, Serialize};

use mizer_fixtures::definition::*;
use mizer_fixtures::library::FixtureLibraryProvider;
use mizer_util::LerpExt;

const COLOR_RED: &str = "#ff0000";
const COLOR_GREEN: &str = "#00ff00";
const COLOR_BLUE: &str = "#0000ff";
const COLOR_WHITE: &str = "#ffffff";
const COLOR_AMBER: &str = "#ffbf00";

#[derive(Default)]
pub struct OpenFixtureLibraryProvider {
    file_path: String,
    definitions: HashMap<String, Vec<OpenFixtureLibraryFixtureDefinition>>,
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
        log::info!("Loading open fixture library...");
        if !Path::new(&self.file_path).exists() {
            return Ok(());
        }
        let files = std::fs::read_dir(&self.file_path)?;
        for file in files {
            let file = file?;
            if file.metadata()?.is_file() {
                log::trace!("Loading ofl library from '{:?}'...", file);
                let mut ag_library_file = std::fs::File::open(&file.path())?;
                let ag_library: AgLibraryFile =
                    simd_json::serde::from_reader(&mut ag_library_file)?;

                for fixture in ag_library.fixtures {
                    let manufacturer = fixture.manufacturer.name.to_slug();
                    self.add_fixture_definition(&manufacturer, fixture);
                }
                log::debug!("Loaded ofl library from '{:?}'.", file);
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
        #[serde(rename = "dmxRange")]
        dmx_range: (u8, u8),
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
) -> FixtureMode {
    let all_channels = mode.channels.into_iter().flatten().collect::<Vec<_>>();

    let (pixels, channels): (Vec<_>, Vec<_>) = all_channels
        .clone()
        .into_iter()
        .partition(|name| is_pixel_channel(name, available_channels));
    let controls: FixtureControls<FixtureControlChannel> =
        group_controls(available_channels, &channels, wheels).into();
    let sub_fixtures = group_sub_fixtures(available_channels, pixels, wheels);

    FixtureMode::new(
        mode.name,
        map_channels(available_channels, all_channels),
        controls,
        sub_fixtures,
    )
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
                    let finest_channel = channels_2.iter().position(|c| c == finest);
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
    wheels: &HashMap<String, WheelDefinition>,
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
        .map(|(key, channels)| build_sub_fixture(key, available_channels, channels, wheels))
        .collect();

    sub_fixtures.sort_by_key(|f| f.id);

    sub_fixtures
}

fn build_sub_fixture(
    key: String,
    available_channels: &HashMap<String, Channel>,
    channels: Vec<String>,
    wheels: &HashMap<String, WheelDefinition>,
) -> SubFixtureDefinition {
    let id = key
        .parse::<u32>()
        .expect(&format!("'{}' is not a number", key));
    let definition = SubFixtureDefinition::new(
        id,
        format!("Pixel {}", key),
        group_controls(available_channels, &channels, wheels).into(),
    );

    definition
}

fn group_controls(
    available_channels: &HashMap<String, Channel>,
    enabled_channels: &[String],
    wheels: &HashMap<String, WheelDefinition>,
) -> FixtureControls<String> {
    let channels = enabled_channels
        .iter()
        .filter_map(|name| {
            available_channels
                .get(name)
                .map(|channel| (name.clone(), channel))
        })
        .collect::<Vec<_>>();

    let mut color_group = ColorGroupBuilder::<String>::new();
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
                    controls.gobo = Some(GoboGroup {
                        channel: name,
                        gobos: used_slots
                            .filter_map(|(slot_index, dmx_range)| {
                                let value =
                                    dmx_range.0.linear_extrapolate((u8::MIN, u8::MAX), (0., 1.));
                                if let WheelSlotDefinition::Gobo { name, resource } =
                                    &wheel.slots[(*slot_index as usize) - 1]
                                {
                                    let name = name
                                        .clone()
                                        .unwrap_or_else(|| format!("Gobo {}", slot_index));

                                    Some(Gobo {
                                        name,
                                        value,
                                        image: resource.clone().map(GoboImage::from),
                                    })
                                } else {
                                    None
                                }
                            })
                            .collect(),
                    });
                    continue;
                }
                if wheel
                    .slots
                    .iter()
                    .any(|s| matches!(s, WheelSlotDefinition::Color { .. }))
                {
                    controls.color_wheel = Some(ColorWheelGroup {
                        channel: name,
                        colors: used_slots
                            .filter_map(|(slot_index, dmx_range)| {
                                let value =
                                    dmx_range.0.linear_extrapolate((u8::MIN, u8::MAX), (0., 1.));
                                if let WheelSlotDefinition::Color { name, colors } =
                                    &wheel.slots[(*slot_index as usize) - 1]
                                {
                                    let name = name
                                        .clone()
                                        .unwrap_or_else(|| format!("Color {}", slot_index));

                                    Some(ColorWheelSlot {
                                        name,
                                        value,
                                        color: colors.clone(),
                                    })
                                } else {
                                    None
                                }
                            })
                            .collect(),
                    });
                    continue;
                }
            }
        }
        match channel
            .capabilities
            .iter()
            .find(|c| !matches!(c, Capability::NoFunction))
        {
            Some(Capability::Intensity) => {
                controls.intensity = Some(name);
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_RED => {
                color_group.red(name);
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_GREEN => {
                color_group.green(name);
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_BLUE => {
                color_group.blue(name);
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_WHITE => {
                color_group.white(name);
            }
            Some(Capability::ColorIntensity { color }) if color == COLOR_AMBER => {
                color_group.amber(name);
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
                    channel: name,
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

    controls.color_mixer = color_group.build();

    controls
}

impl From<Resource> for GoboImage {
    fn from(resource: Resource) -> Self {
        match resource.image.encoding.as_str() {
            "utf8" => GoboImage::Svg(resource.image.data),
            _ => GoboImage::Raster(Box::new(base64::decode(resource.image.data).unwrap())),
        }
    }
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use mizer_fixtures::definition::{ColorGroup, GenericControl};

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
            ColorGroup {
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
            ColorGroup {
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
            ColorGroup {
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
