use mizer_fixtures::builder::{DmxChannelBuilder, FixtureModeBuilder, FixtureDefinitionBuilder};
use mizer_fixtures::channels::{DmxChannel,FixtureChannel, FixtureChannelPreset, FixtureColorChannel, FixtureValue};
use mizer_fixtures::definition::*;

use crate::definition::*;
use crate::PROVIDER_NAME;
use crate::resource_reader::ResourceReader;

pub fn map_fixture_definition(definition: QlcPlusFixtureDefinition, resource_reader: &ResourceReader) -> anyhow::Result<FixtureDefinition> {
    let mut builder = FixtureDefinitionBuilder::default();
    builder.id(format!("qlc:{}:{}", definition.manufacturer, definition.model))
        .name(definition.model)
        .manufacturer(definition.manufacturer)
        .provider(PROVIDER_NAME);
    builder.tag(definition.fixture_type);
    
    let gobo_channel = get_channel(
        &definition.channels,
        GroupEnumType::Gobo,
        CapabilityPresetType::GoboMacro,
    );
    let color_channel = get_channel(
        &definition.channels,
        GroupEnumType::Colour,
        CapabilityPresetType::ColorMacro,
    );

    let mut custom_channel_number = 1u8;

    let mut custom_channel = || -> FixtureChannel {
        let n = custom_channel_number;
        custom_channel_number += 1;

        FixtureChannel::Custom(n)
    };

    for channel_type in definition.channels {
        let channel_builder = builder.channel(channel_type.name.to_string());
        if let Some(default) = channel_type.default {
            let value = FixtureValue::Percent(default as f64 / u8::MAX as f64);
            channel_builder.default(value);
        }
        if let Some(group) = channel_type.group {
            match group.group {
                GroupEnumType::Intensity => {
                    channel_builder.channel(FixtureChannel::Intensity);
                },
                GroupEnumType::Shutter => {
                    channel_builder.channel(FixtureChannel::Shutter(1));
                },
                GroupEnumType::Prism => {
                    channel_builder.channel(FixtureChannel::Prism(1));  
                },
                GroupEnumType::Pan => {
                    channel_builder.channel(FixtureChannel::Pan);
                },
                GroupEnumType::Tilt => {
                    channel_builder.channel(FixtureChannel::Tilt);
                },
                GroupEnumType::Colour if color_channel.as_ref() == Some(&channel_type) => {
                    channel_builder.channel(FixtureChannel::ColorWheel);
                    let presets = channel_type
                            .capabilities
                            .into_iter()
                            .filter(|capability| {
                                capability.preset.is_none()
                                    || capability.preset == Some(CapabilityPresetType::ColorMacro)
                                    || capability.preset
                                    == Some(CapabilityPresetType::ColorDoubleMacro)
                            })
                            .map(|capability| FixtureChannelPreset {
                                name: capability.name.to_string(),
                                value: FixtureValue::Percent(capability.min as f64 / 255.),
                                color: vec![capability.resource1, capability.resource2]
                                    .into_iter()
                                    .flatten()
                                    .collect(),
                                image: Default::default(),
                            })
                            .collect();
                    channel_builder.presets(presets);
                }
                GroupEnumType::Gobo if gobo_channel.as_ref() == Some(&channel_type) => {
                    channel_builder.channel(FixtureChannel::GoboWheel(1));
                    let presets = channel_type
                            .capabilities
                            .into_iter()
                            .map(|capability| FixtureChannelPreset {
                                name: capability.name.to_string(),
                                value: FixtureValue::Percent(capability.min as f64 / 255.),
                                image: capability
                                    .resource1
                                    .and_then(|file_name| resource_reader.read_gobo(&file_name)),
                                color: Default::default(),
                            })
                            .collect();
                    channel_builder.presets(presets);
                }
                _ => {
                    channel_builder.channel(custom_channel()).dmx_channel(DmxChannelBuilder::coarse());
                },
            }
            channel_builder.dmx_channel(DmxChannelBuilder::coarse());
        } else if let Some(preset) = channel_type.preset {
            match preset {
                ChannelPresetType::IntensityRed => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Red));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityRedFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Red));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityGreen => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Green));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityGreenFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Green));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityBlue => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityBlueFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Blue));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityWhite => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::White));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityWhiteFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::White));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                }
                ChannelPresetType::IntensityAmber => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Amber));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityAmberFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Amber));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityCyan => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Cyan));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityCyanFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Cyan));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityMagenta => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Magenta));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityMagentaFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Magenta));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityYellow => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Yellow));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityYellowFine => {
                    channel_builder.channel(FixtureChannel::ColorMixer(FixtureColorChannel::Yellow));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityDimmer => {
                    channel_builder.channel(FixtureChannel::Intensity);
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityDimmerFine => {
                    channel_builder.channel(FixtureChannel::Intensity);
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::IntensityMasterDimmer => {
                    channel_builder.channel(FixtureChannel::Intensity);
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::IntensityMasterDimmerFine => {
                    channel_builder.channel(FixtureChannel::Intensity);
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::PositionPan => {
                    channel_builder.channel(FixtureChannel::Pan);
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::PositionPanFine => {
                    channel_builder.channel(FixtureChannel::Pan);
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::PositionTilt => {
                    channel_builder.channel(FixtureChannel::Tilt);
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::PositionTiltFine => {
                    channel_builder.channel(FixtureChannel::Tilt);
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::BeamFocusFarNear | ChannelPresetType::BeamFocusNearFar => {
                    channel_builder.channel(FixtureChannel::Focus(1));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::BeamFocusFine => {
                    channel_builder.channel(FixtureChannel::Focus(1));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::BeamZoomBigSmall | ChannelPresetType::BeamZoomSmallBig => {
                    channel_builder.channel(FixtureChannel::Zoom(1));
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                },
                ChannelPresetType::BeamZoomFine => {
                    channel_builder.channel(FixtureChannel::Zoom(1));
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                },
                ChannelPresetType::ShutterIrisMinToMax | ChannelPresetType::ShutterIrisMaxToMin => {
                    channel_builder.channel(FixtureChannel::Iris);
                    channel_builder.dmx_channel(DmxChannelBuilder::coarse());
                }
                ChannelPresetType::ShutterIrisFine => {
                    channel_builder.channel(FixtureChannel::Iris);
                    channel_builder.dmx_channel(DmxChannelBuilder::fine());
                }
                _ => {
                    channel_builder.channel(custom_channel()).dmx_channel(DmxChannelBuilder::coarse());
                },
            }
        }else {
            channel_builder.channel(custom_channel()).dmx_channel(DmxChannelBuilder::coarse());
        };
        
        channel_builder.label(channel_type.name.to_string());
    }

    for mode in definition.modes {
        let mut mode_builder = FixtureModeBuilder::new(mode.name);

        let head_channels = mode.heads.iter().flat_map(|head| head.channels.clone()).collect::<Vec<_>>();

        for channel in mode.channels.iter() {
            if head_channels.contains(&channel.number) {
                continue
            }
            if let Err(err) = mode_builder.use_prebuilt_channel(&builder, channel.channel.as_str(), Some(DmxChannel::new(channel.number))) {
                tracing::warn!("Unable to setup channel {}: {err:?}", channel.channel);
                continue;
            }
        }


        builder.mode(mode_builder);
    }

    builder.build()
}

fn get_channel(
    channels: &[ChannelType],
    group_type: GroupEnumType,
    preset_type: CapabilityPresetType,
) -> Option<ChannelType> {
    let is_channel = |c: &&ChannelType| {
        matches!(
            c.group,
            Some(GroupType {
                group,
                ..
            }) if group == group_type
        )
    };
    channels
        .iter()
        .filter(is_channel)
        .find(|channel| {
            channel
                .capabilities
                .iter()
                .any(|c| c.preset == Some(preset_type))
        })
        .or_else(|| channels.iter().find(is_channel))
        .cloned()
}
