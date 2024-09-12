use std::collections::HashMap;
use std::ops::Deref;
use mizer_fixtures::channels::{DmxChannel, DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel, FixtureValue, SubFixtureChannelMode};
use mizer_fixtures::definition::*;
use mizer_fixtures::FixtureId::Fixture;
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
                let channel_definitions = create_fixture(&mode, &channels, resource_reader);
                let sub_fixtures = create_sub_fixtures(&mode, &channels, resource_reader);
                
                FixtureChannelMode::new(mode.name, channel_definitions, sub_fixtures)
            })
            .collect(),
        tags: vec![definition.fixture_type],
        physical: PhysicalFixtureData::default(),
    }
}

fn create_fixture(
    mode: &ModeType,
    channels: &HashMap<String, ChannelType>,
    resource_reader: &ResourceReader<'_>,
) -> Vec<FixtureChannelDefinition> {
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
        .map(|mode_channel| (mode_channel, &channels[mode_channel.channel.deref()]))
        .collect::<Vec<_>>();

    build_channels(channels, resource_reader)
}

fn create_sub_fixtures(
    mode: &ModeType,
    channels: &HashMap<String, ChannelType>,
    resource_reader: &ResourceReader<'_>,
) -> Vec<SubFixtureChannelMode> {
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
                .map(|mode_channel| (mode_channel, &channels[mode_channel.channel.deref()]))
                .collect();

            let channel_definitions = build_channels(head_channels, resource_reader);
            SubFixtureChannelMode::new(id, format!("Head {id}"), channel_definitions)
        })
        .collect()
}

fn build_channels(
    channels: Vec<(&ModeChannelType, &ChannelType)>,
    resource_reader: &ResourceReader<'_>,
) -> Vec<FixtureChannelDefinition> {
    let mut channel_definitions = Vec::new();
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
    for (mode_channel, channel_type) in channels {
        let channel = if let Some(group) = channel_type.group {
            match group.group {
                GroupEnumType::Intensity => FixtureChannel::Intensity,
                GroupEnumType::Shutter => FixtureChannel::Shutter,
                GroupEnumType::Prism => FixtureChannel::Prism,
                GroupEnumType::Pan => FixtureChannel::Pan,
                GroupEnumType::Tilt => FixtureChannel::Tilt,
                GroupEnumType::Colour if color_channel.as_ref() == Some(&channel_type) => {
                    FixtureChannel::ColorWheel
                    // controls.color_wheel = Some(ColorWheelGroup {
                    //     channel: control_channel,
                    //     colors: channel_type
                    //         .capabilities
                    //         .into_iter()
                    //         .filter(|capability| {
                    //             capability.preset.is_none()
                    //                 || capability.preset == Some(CapabilityPresetType::ColorMacro)
                    //                 || capability.preset
                    //                 == Some(CapabilityPresetType::ColorDoubleMacro)
                    //         })
                    //         .map(|capability| ColorWheelSlot {
                    //             name: capability.name.to_string(),
                    //             value: (capability.min as u8)
                    //                 .linear_extrapolate((0, 255), (0., 1.)),
                    //             color: vec![capability.resource1, capability.resource2]
                    //                 .into_iter()
                    //                 .flatten()
                    //                 .collect(),
                    //         })
                    //         .collect(),
                    // })
                }
                GroupEnumType::Gobo if gobo_channel.as_ref() == Some(&channel_type) => {
                    FixtureChannel::GoboWheel
                    // controls.gobo = Some(GoboGroup {
                    //     channel: control_channel,
                    //     gobos: channel_type
                    //         .capabilities
                    //         .into_iter()
                    //         .map(|capability| Gobo {
                    //             name: capability.name.to_string(),
                    //             value: (capability.min as u8)
                    //                 .linear_extrapolate((0, 255), (0., 1.)),
                    //             image: capability
                    //                 .resource1
                    //                 .and_then(|file_name| resource_reader.read_gobo(&file_name)),
                    //         })
                    //         .collect(),
                    // })
                }
                _ => todo!(),
            }
        } else if let Some(preset) = channel_type.preset {
            match preset {
                ChannelPresetType::IntensityRed => FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                ChannelPresetType::IntensityGreen => FixtureChannel::ColorMixer(FixtureColorChannel::Green),
                ChannelPresetType::IntensityBlue => FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
                ChannelPresetType::IntensityWhite => FixtureChannel::ColorMixer(FixtureColorChannel::White),
                ChannelPresetType::IntensityAmber => FixtureChannel::ColorMixer(FixtureColorChannel::Amber),
                ChannelPresetType::IntensityCyan => FixtureChannel::ColorMixer(FixtureColorChannel::Cyan),
                ChannelPresetType::IntensityMagenta => FixtureChannel::ColorMixer(FixtureColorChannel::Magenta),
                ChannelPresetType::IntensityYellow => FixtureChannel::ColorMixer(FixtureColorChannel::Yellow),
                ChannelPresetType::IntensityDimmer => FixtureChannel::Intensity,
                ChannelPresetType::IntensityMasterDimmer => FixtureChannel::Intensity,
                ChannelPresetType::PositionPan => FixtureChannel::Pan,
                ChannelPresetType::PositionTilt => FixtureChannel::Tilt,
                ChannelPresetType::BeamFocusFarNear | ChannelPresetType::BeamFocusNearFar => FixtureChannel::Focus,
                ChannelPresetType::BeamZoomBigSmall | ChannelPresetType::BeamZoomSmallBig => FixtureChannel::Zoom,
                _ => todo!()
            }
        }else { 
            todo!()
        };

        let channel_builder = FixtureChannelDefinition::builder()
            .channels(DmxChannels::Resolution8Bit {
                coarse: DmxChannel::new(mode_channel.number),
            })
            .channel(channel)
            .maybe_default(channel_type.default.map(|d| FixtureValue::Percent(d as f64 / u8::MAX as f64)))
            .label(channel_type.name.to_string().into());
        
        channel_definitions.push(channel_builder.build());
    }
    
    channel_definitions
}

fn get_channel<'a>(
    channels: &[(&ModeChannelType, &'a ChannelType)],
    group_type: GroupEnumType,
    preset_type: CapabilityPresetType,
) -> Option<&'a ChannelType> {
    let is_channel = |c: &&&ChannelType| {
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
        .map(|(_, channel)| channel)
        .filter(is_channel)
        .find(|channel| {
            channel
                .capabilities
                .iter()
                .any(|c| c.preset == Some(preset_type))
        })
        .or_else(|| channels.iter()
            .map(|(_, channel)| channel)
            .find(is_channel))
        .cloned()
}
