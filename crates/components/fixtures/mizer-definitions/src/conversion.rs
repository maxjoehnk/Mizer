use indexmap::IndexMap;

use mizer_fixtures::definition::{AxisGroup, ChannelResolution, ColorGroupBuilder, FixtureChannelDefinition, FixtureControlChannel, FixtureControls, FixtureDefinition, FixtureMode, GenericControl, SubFixtureControlChannel, SubFixtureDefinition};

use crate::definition::{MizerFixtureControl, MizerFixtureDefinition, MizerFixtureResolution};

pub fn map_fixture_definition(definition: MizerFixtureDefinition) -> FixtureDefinition {
    FixtureDefinition {
        id: format!(
            "mizer:{}:{}",
            definition.metadata.manufacturer, definition.metadata.name
        ),
        name: definition.metadata.name,
        manufacturer: definition.metadata.manufacturer,
        provider: "Mizer",
        modes: definition
            .modes
            .into_iter()
            .map(|mode| {
                let mut dmx_channel = 0;
                let fixture_channels = mode.channels
                    .iter()
                    .enumerate()
                    .flat_map(|(i, channel)| {
                        definition
                            .channels
                            .iter()
                            .find(|c| &c.name == channel)
                            .cloned()
                            .map(|c| {
                                let fixture_channel = dmx_channel;
                                
                                dmx_channel += c.channels();

                                (fixture_channel, c)
                            })
                    })
                    .map(|(i, c)| (c.name.clone(), (i, c)))
                    .collect::<IndexMap<_, _>>();
                let mut fixture_controls = FixtureControls::default();
                let mut fixture_color_builder = ColorGroupBuilder::new();

                for ch in mode.channels {
                    let Some((_, channel)) = fixture_channels.get(&ch) else {
                        continue;
                    };
                    match channel.control {
                        MizerFixtureControl::Intensity => {
                            fixture_controls.intensity = Some(FixtureControlChannel::Channel(ch))
                        }
                        MizerFixtureControl::Shutter => {
                            fixture_controls.shutter = Some(FixtureControlChannel::Channel(ch))
                        }
                        MizerFixtureControl::ColorRed => {
                            fixture_color_builder.red(FixtureControlChannel::Channel(ch))
                        }
                        MizerFixtureControl::ColorGreen => {
                            fixture_color_builder.green(FixtureControlChannel::Channel(ch))
                        }
                        MizerFixtureControl::ColorBlue => {
                            fixture_color_builder.blue(FixtureControlChannel::Channel(ch))
                        }
                        MizerFixtureControl::Pan => {
                            fixture_controls.pan = Some(AxisGroup {
                                channel: FixtureControlChannel::Channel(ch),
                                angle: None,
                            })
                        }
                        MizerFixtureControl::Tilt => {
                            fixture_controls.tilt = Some(AxisGroup {
                                channel: FixtureControlChannel::Channel(ch),
                                angle: None,
                            })
                        }
                        MizerFixtureControl::Generic => {
                            fixture_controls.generic.push(GenericControl {
                                channel: FixtureControlChannel::Channel(ch),
                                label: channel.name.clone(),
                            })
                        }
                    }
                }

                fixture_controls.color_mixer = fixture_color_builder.build();

                let sub_fixture_channels = mode
                    .pixels
                    .iter()
                    .flat_map(|pixel| pixel.channels.clone())
                    .enumerate()
                    .filter_map(|(i, channel)| {
                        definition
                            .channels
                            .iter()
                            .find(|c| c.name == channel)
                            .cloned()
                            .map(|c| {
                                let fixture_channel = dmx_channel;

                                dmx_channel += c.channels();

                                (fixture_channel, c)
                            })
                    })
                    .map(|(i, c)| (c.name.clone(), (i, c)))
                    .collect::<IndexMap<_, _>>();
                let sub_fixtures = mode
                    .pixels
                    .into_iter()
                    .enumerate()
                    .map(|(i, pixel)| {
                        let mut controls = FixtureControls {
                            ..Default::default()
                        };

                        let mut color_builder = ColorGroupBuilder::new();

                        for ch in pixel.channels {
                            let Some((_, channel)) = sub_fixture_channels.get(&ch) else {
                                continue;
                            };
                            match channel.control {
                                MizerFixtureControl::Intensity => {
                                    controls.intensity = Some(SubFixtureControlChannel::Channel(ch))
                                }
                                MizerFixtureControl::Shutter => {
                                    controls.shutter = Some(SubFixtureControlChannel::Channel(ch))
                                }
                                MizerFixtureControl::ColorRed => {
                                    color_builder.red(SubFixtureControlChannel::Channel(ch))
                                }
                                MizerFixtureControl::ColorGreen => {
                                    color_builder.green(SubFixtureControlChannel::Channel(ch))
                                }
                                MizerFixtureControl::ColorBlue => {
                                    color_builder.blue(SubFixtureControlChannel::Channel(ch))
                                }
                                MizerFixtureControl::Pan => {
                                    controls.pan = Some(AxisGroup {
                                        channel: SubFixtureControlChannel::Channel(ch),
                                        angle: None,
                                    })
                                }
                                MizerFixtureControl::Tilt => {
                                    controls.tilt = Some(AxisGroup {
                                        channel: SubFixtureControlChannel::Channel(ch),
                                        angle: None,
                                    })
                                }
                                MizerFixtureControl::Generic => {
                                    controls.generic.push(GenericControl {
                                        channel: SubFixtureControlChannel::Channel(ch),
                                        label: channel.name.clone(),
                                    })
                                }
                            }
                        }

                        controls.color_mixer = color_builder.build();

                        SubFixtureDefinition::new(i as u32 + 1, pixel.name, controls)
                    })
                    .collect();

                let channels = fixture_channels.into_iter()
                    .chain(sub_fixture_channels)
                    .map(|(name, (j, c))| FixtureChannelDefinition {
                        name,
                        resolution: match c.resolution {
                            MizerFixtureResolution::Coarse => ChannelResolution::Coarse(j),
                            MizerFixtureResolution::Fine => ChannelResolution::Fine(j, j + 1),
                        }
                    })
                    .collect();

                FixtureMode::new(
                    mode.name,
                    channels,
                    fixture_controls,
                    sub_fixtures,
                )
            })
            .collect(),
        tags: definition.metadata.tags,
        physical: Default::default(),
    }
}
