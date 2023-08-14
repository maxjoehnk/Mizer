use indexmap::IndexMap;

use mizer_fixtures::definition::{
    ChannelResolution, ColorGroupBuilder, FixtureChannelDefinition, FixtureControls,
    FixtureDefinition, FixtureMode, GenericControl, SubFixtureControlChannel, SubFixtureDefinition,
};

use crate::definition::{MizerFixtureControl, MizerFixtureDefinition};

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
                let all_channels = mode
                    .pixels
                    .iter()
                    .flat_map(|pixel| pixel.channels.clone())
                    .filter_map(|channel| {
                        definition
                            .channels
                            .iter()
                            .find(|c| c.name == channel)
                            .cloned()
                    })
                    .map(|c| (c.name.clone(), c))
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
                            let channel = &all_channels[&ch];
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

                let channels = all_channels
                    .into_iter()
                    .enumerate()
                    .map(|(i, (name, _))| FixtureChannelDefinition {
                        name,
                        resolution: ChannelResolution::Coarse(i as u16),
                    })
                    .collect();

                FixtureMode::new(
                    mode.name,
                    channels,
                    FixtureControls::default(),
                    sub_fixtures,
                )
            })
            .collect(),
        tags: definition.metadata.tags,
        physical: Default::default(),
    }
}
