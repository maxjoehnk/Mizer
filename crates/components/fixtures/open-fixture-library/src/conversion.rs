use std::collections::{HashMap, HashSet};
use std::str::FromStr;
use std::sync::Arc;
use base64::Engine;
use base64::prelude::BASE64_STANDARD;
use mizer_fixtures::builder::{DmxChannelBuilder, FixtureDefinitionBuilder, FixtureModeBuilder};
use mizer_fixtures::channels::{DmxChannel, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureChannelPreset, FixtureColorChannel, FixtureImage, FixtureValue, SubFixtureChannelMode};
use mizer_fixtures::definition::{FixtureDefinition, FixtureDimensions, PhysicalFixtureData};
use mizer_util::LerpExt;
use crate::definition::{Capability, Channel, Mode, OpenFixtureLibraryFixtureDefinition, Resource, Value, WheelDefinition, WheelSlot, WheelSlotDefinition};
use crate::{PROVIDER_NAME, SlugConverter};

const COLOR_RED: &str = "#ff0000";
const COLOR_GREEN: &str = "#00ff00";
const COLOR_BLUE: &str = "#0000ff";
const COLOR_WHITE: &str = "#ffffff";
const COLOR_AMBER: &str = "#ffbf00";
const COLOR_CYAN: &str = "#0ff0fe";
const COLOR_MAGENTA: &str = "#ff00ff";
const COLOR_YELLOW: &str = "#ffff00";

const DMX_CHANNEL_RANGE: (u16, u16) = (0, 511);

pub fn map_fixture_definition(def: OpenFixtureLibraryFixtureDefinition) -> anyhow::Result<FixtureDefinition> {
    let mut builder = FixtureDefinitionBuilder::default();
    builder.id(format!(
        "ofl:{}:{}",
        def.manufacturer.name.to_slug(),
        def.name.to_slug()
    )).name(def.name)
        .manufacturer(def.manufacturer.name)
        .provider(PROVIDER_NAME)
        .tags(def.categories);
    builder.physical.weight = def.physical.weight;
    builder.physical.dimensions = convert_dimensions(def.physical.dimensions);

    let channel_pixels = def.available_channels.iter()
        .flat_map(|(name, channel)| {
            let pixel_key = channel.pixel_key.clone()?;

            Some((name.clone(), pixel_key))
        })
        .collect::<HashMap<_, _>>();

    let mut custom_channel_number = 1u8;

    let mut custom_channel = || -> FixtureChannel {
        let n = custom_channel_number;
        custom_channel_number += 1;

        FixtureChannel::Custom(n)
    };

    for (name, channel) in def.available_channels {
        let wheel = def.wheels.get(&name);
        
        let channel_builder = builder.channel(name.clone())
            .label(name);
        if let Some(value) = channel.default_value.clone() {
            let value = convert_value(value)?;
            channel_builder.default(value);
        }
        if let Some(value) = channel.highlight_value.clone() {
            let value = convert_value(value)?;
            channel_builder.highlight(value);
        }

        if channel
            .capabilities
            .iter()
            .any(|c| matches!(c, Capability::WheelSlot(_)))
        {
            if let Some(wheel) = wheel {
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
                    channel_builder
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

                    continue;
                }
                if wheel
                    .slots
                    .iter()
                    .any(|s| matches!(s, WheelSlotDefinition::Color { .. }))
                {
                    channel_builder
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

                    continue;
                }
            }
        }
        
        let fixture_channel = match channel
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
            Some(Capability::Focus) => FixtureChannel::Focus(1),
            Some(Capability::Zoom) => FixtureChannel::Zoom(1),
            Some(Capability::Prism) => FixtureChannel::Prism(1),
            Some(Capability::Iris) => FixtureChannel::Iris,
            Some(Capability::Frost) => FixtureChannel::Frost(1),
            Some(Capability::ShutterStrobe { .. }) => FixtureChannel::Shutter(1),
            Some(Capability::PanContinuous) => FixtureChannel::PanEndless,
            Some(Capability::TiltContinuous) => FixtureChannel::TiltEndless,
            Some(_) => custom_channel(),
            _ => {
                continue;
            },
        };
        channel_builder.channel(fixture_channel);
        channel_builder.dmx_channel(DmxChannelBuilder::coarse());

        for (endianess, fine_channel_name) in channel.fine_channel_aliases.into_iter().enumerate() {
            let endianess = (endianess + 1) as u8;
            let channel_builder = builder.channel(fine_channel_name);
            channel_builder.dmx_channel(DmxChannelBuilder::from_endianess(endianess));
            channel_builder.channel(fixture_channel);

            if let Some(value) = channel.default_value.clone() {
                let value = convert_value(value)?;
                channel_builder.default(value);
            }
            if let Some(value) = channel.highlight_value.clone() {
                let value = convert_value(value)?;
                channel_builder.highlight(value);
            }
        }
    }
    
    for mode in def.modes {
        let mut mode_builder = FixtureModeBuilder::new(mode.name);

        let mut dmx_channels = mode.channels.iter()
            .enumerate()
            .flat_map(|(index, channel)| channel.as_ref().map(|channel| (index, channel.clone())))
            .map(|(index, channel)| (channel, DmxChannel::new(index as u16)))
            .collect::<HashMap<_, _>>();


        let (pixels, channels): (Vec<_>, Vec<_>) = mode.channels
            .into_iter()
            .flatten()
            .partition(|name| channel_pixels.contains_key(name));

        for channel in channels {
            let dmx_channel = dmx_channels.remove(&channel).unwrap();
            mode_builder.use_prebuilt_channel(&builder, &channel, Some(dmx_channel))?;
        }

        let sub_fixture_names = channel_pixels.values().collect::<HashSet<_>>();
        let mut sub_fixtures = sub_fixture_names.into_iter()
            .map(|pixel| {
                let sub_fixture_builder = FixtureModeBuilder::new(pixel.clone());

                (pixel.clone(), sub_fixture_builder)
            })
            .collect::<HashMap<_, _>>();

        for channel in pixels {
            let Some(pixel_group) = &channel_pixels.get(&channel) else {
                continue;
            };
            let Some(sub_fixture_builder) = sub_fixtures.get_mut(*pixel_group) else {
                continue;
            };
            let dmx_channel = dmx_channels.remove(&channel).unwrap();
            sub_fixture_builder.use_prebuilt_channel(&builder, &channel, Some(dmx_channel))?;
        }

        for (_, sub_fixture) in sub_fixtures {
            mode_builder.sub_fixture(sub_fixture);
        }

        builder.mode(mode_builder);
    }
    
    builder.build()
}

fn convert_value(value: Value) -> anyhow::Result<FixtureValue> {
    match value {
        Value::Dmx(value) => Ok(FixtureValue::Percent((value as f64 / 255.).clamp(0f64, 1f64))),
        Value::Percentage(percentage) => {
            let sign_index = percentage.len() - 1;
            let percentage = percentage[..sign_index].trim();
            let percentage = f64::from_str(percentage)?;

            Ok(FixtureValue::Percent(percentage))
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
