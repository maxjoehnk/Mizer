use std::collections::HashMap;
use std::ops::Deref;

use mizer_fixtures::definition::*;
use mizer_util::LerpExt;

use crate::definition::*;
use crate::resource_reader::ResourceReader;

pub fn map_fixture_definition(
    definition: QlcPlusFixtureDefinition,
    resource_reader: &ResourceReader,
) -> FixtureDefinition {
    let channels = definition
        .channels
        .into_iter()
        .map(|channel| (channel.name.to_string(), channel))
        .collect::<HashMap<_, _>>();

    FixtureDefinition {
        id: format!("qlc:{}:{}", definition.manufacturer, definition.model),
        manufacturer: definition.manufacturer,
        name: definition.model,
        provider: "QLC+",
        modes: definition
            .modes
            .into_iter()
            .map(|mode| {
                let controls = create_controls(&mode, &channels, resource_reader);
                let sub_fixtures = create_sub_fixtures(&mode, &channels, resource_reader);
                let channels = mode
                    .channels
                    .into_iter()
                    .map(|mode_channel| {
                        let channel = &channels[mode_channel.channel.deref()];

                        FixtureChannelDefinition {
                            name: channel.name.to_string(),
                            resolution: ChannelResolution::Coarse(mode_channel.number as u8),
                        }
                    })
                    .collect();

                FixtureMode::new(mode.name, channels, controls, sub_fixtures)
            })
            .collect(),
        tags: vec![definition.fixture_type],
        physical: PhysicalFixtureData::default(),
    }
}

fn create_controls(
    mode: &ModeType,
    channels: &HashMap<String, ChannelType>,
    resource_reader: &ResourceReader<'_>,
) -> FixtureControls<FixtureControlChannel> {
    let channels = mode
        .channels
        .iter()
        .filter(|mode_channel| {
            !mode.heads.iter().any(|head| {
                head.channels
                    .iter()
                    .any(|channel| channel == &mode_channel.number)
            })
        })
        .map(|mode_channel| channels[mode_channel.channel.deref()].clone())
        .collect::<Vec<_>>();

    build_controls(
        channels,
        |channel| FixtureControlChannel::Channel(channel.name.to_string()),
        resource_reader,
    )
}

fn create_sub_fixtures(
    mode: &ModeType,
    channels: &HashMap<String, ChannelType>,
    resource_reader: &ResourceReader<'_>,
) -> Vec<SubFixtureDefinition> {
    mode.heads
        .iter()
        .enumerate()
        .map(|(i, head)| {
            let id = i as u32 + 1;
            let head_channels = head
                .channels
                .iter()
                .filter_map(|channel_number| {
                    mode.channels.iter().find(|c| c.number == *channel_number)
                })
                .map(|channel| channels[channel.channel.deref()].clone())
                .collect();

            let controls = create_sub_fixture_controls(head_channels, resource_reader);
            SubFixtureDefinition::new(id, format!("Head {id}"), controls)
        })
        .collect()
}

fn create_sub_fixture_controls(
    channels: Vec<ChannelType>,
    resource_reader: &ResourceReader<'_>,
) -> FixtureControls<SubFixtureControlChannel> {
    build_controls(
        channels,
        |channel| SubFixtureControlChannel::Channel(channel.name.to_string()),
        resource_reader,
    )
}

fn build_controls<TChannel>(
    channels: Vec<ChannelType>,
    control_channel_builder: impl Fn(&ChannelType) -> TChannel,
    resource_reader: &ResourceReader<'_>,
) -> FixtureControls<TChannel> {
    let mut controls = FixtureControls::default();
    let mut color_builder = ColorGroupBuilder::<TChannel>::new();
    let gobo_channel = get_channel(
        &channels,
        GroupEnumType::Gobo,
        CapabilityPresetType::GoboMacro,
    );
    let color_channel = get_channel(
        &channels,
        GroupEnumType::Colour,
        CapabilityPresetType::ColorMacro,
    );
    for channel in channels {
        let control_channel = control_channel_builder(&channel);
        if let Some(group) = channel.group {
            match group.group {
                GroupEnumType::Intensity => controls.intensity = Some(control_channel),
                GroupEnumType::Shutter => controls.shutter = Some(control_channel),
                GroupEnumType::Prism => controls.prism = Some(control_channel),
                GroupEnumType::Pan => {
                    controls.pan = Some(AxisGroup {
                        channel: control_channel,
                        angle: None,
                    })
                }
                GroupEnumType::Tilt => {
                    controls.tilt = Some(AxisGroup {
                        channel: control_channel,
                        angle: None,
                    })
                }
                GroupEnumType::Colour if color_channel.as_ref() == Some(&channel) => {
                    controls.color_wheel = Some(ColorWheelGroup {
                        channel: control_channel,
                        colors: channel
                            .capabilities
                            .into_iter()
                            .filter(|capability| {
                                capability.preset.is_none()
                                    || capability.preset == Some(CapabilityPresetType::ColorMacro)
                                    || capability.preset
                                        == Some(CapabilityPresetType::ColorDoubleMacro)
                            })
                            .map(|capability| ColorWheelSlot {
                                name: capability.name.to_string(),
                                value: (capability.min as u8)
                                    .linear_extrapolate((0, 255), (0., 1.)),
                                color: vec![capability.resource1, capability.resource2]
                                    .into_iter()
                                    .flatten()
                                    .collect(),
                            })
                            .collect(),
                    })
                }
                GroupEnumType::Gobo if gobo_channel.as_ref() == Some(&channel) => {
                    controls.gobo = Some(GoboGroup {
                        channel: control_channel,
                        gobos: channel
                            .capabilities
                            .into_iter()
                            .map(|capability| Gobo {
                                name: capability.name.to_string(),
                                value: (capability.min as u8)
                                    .linear_extrapolate((0, 255), (0., 1.)),
                                image: capability
                                    .resource1
                                    .and_then(|file_name| resource_reader.read_gobo(&file_name)),
                            })
                            .collect(),
                    })
                }
                _ => controls.generic.push(GenericControl {
                    label: channel.name.to_string(),
                    channel: control_channel,
                }),
            }
        } else if let Some(preset) = channel.preset {
            match preset {
                ChannelPresetType::IntensityRed => color_builder.red(control_channel),
                ChannelPresetType::IntensityGreen => color_builder.green(control_channel),
                ChannelPresetType::IntensityBlue => color_builder.blue(control_channel),
                ChannelPresetType::IntensityWhite => color_builder.white(control_channel),
                ChannelPresetType::IntensityAmber => color_builder.amber(control_channel),
                ChannelPresetType::IntensityDimmer => controls.intensity = Some(control_channel),
                ChannelPresetType::IntensityMasterDimmer => {
                    controls.intensity = Some(control_channel)
                }
                ChannelPresetType::PositionPan => {
                    controls.pan = Some(AxisGroup {
                        channel: control_channel,
                        angle: None,
                    })
                }
                ChannelPresetType::PositionTilt => {
                    controls.tilt = Some(AxisGroup {
                        channel: control_channel,
                        angle: None,
                    })
                }
                ChannelPresetType::BeamFocusFarNear | ChannelPresetType::BeamFocusNearFar => {
                    controls.focus = Some(control_channel)
                }
                _ => {}
            }
        }
    }

    controls.color_mixer = color_builder.build();

    controls
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
