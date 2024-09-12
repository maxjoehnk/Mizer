use std::collections::HashMap;
use indexmap::IndexMap;
use mizer_fixtures::channels::{FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel, SubFixtureChannelMode};
use mizer_fixtures::definition::FixtureDefinition;

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
                let fixture_channels = mode
                    .channels
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
                let mut fixture_controls = HashMap::new();

                for ch in mode.channels {
                    let Some((_, channel)) = fixture_channels.get(&ch) else {
                        continue;
                    };
                    match channel.control {
                        MizerFixtureControl::Intensity => {
                            fixture_controls.insert(FixtureChannel::Intensity, ch);
                        }
                        MizerFixtureControl::Shutter => {
                            fixture_controls.insert(FixtureChannel::Shutter, ch);
                        }
                        MizerFixtureControl::ColorRed => {
                            fixture_controls.insert(FixtureChannel::ColorMixer(FixtureColorChannel::Red), ch);
                        }
                        MizerFixtureControl::ColorGreen => {
                            fixture_controls.insert(FixtureChannel::ColorMixer(FixtureColorChannel::Green), ch);
                        }
                        MizerFixtureControl::ColorBlue => {
                            fixture_controls.insert(FixtureChannel::ColorMixer(FixtureColorChannel::Blue), ch);
                        }
                        MizerFixtureControl::Pan => {
                            fixture_controls.insert(FixtureChannel::Pan, ch);
                        }
                        MizerFixtureControl::Tilt => {
                            fixture_controls.insert(FixtureChannel::Tilt, ch);
                        }
                        MizerFixtureControl::Generic => {
                            todo!()
                        }
                    }
                }

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
                
                todo!()
                
                // let channels = fixture_channels
                //     .into_iter()
                //     .chain(sub_fixture_channels)
                //     .map(|(name, (j, c))| FixtureChannelDefinition {
                //         
                //     })
                //     .collect();
                // 
                // let sub_fixtures = mode
                //     .pixels
                //     .into_iter()
                //     .enumerate()
                //     .map(|(i, pixel)| {
                //         let mut fixture_controls = HashMap::new();
                // 
                //         for ch in pixel.channels {
                //             let Some((_, channel)) = fixture_channels.get(&ch) else {
                //                 continue;
                //             };
                //             match channel.control {
                //                 MizerFixtureControl::Intensity => {
                //                     fixture_controls.insert(FixtureChannel::Intensity, ch);
                //                 }
                //                 MizerFixtureControl::Shutter => {
                //                     fixture_controls.insert(FixtureChannel::Shutter, ch);
                //                 }
                //                 MizerFixtureControl::ColorRed => {
                //                     fixture_controls.insert(FixtureChannel::ColorMixer(FixtureColorChannel::Red), ch);
                //                 }
                //                 MizerFixtureControl::ColorGreen => {
                //                     fixture_controls.insert(FixtureChannel::ColorMixer(FixtureColorChannel::Green), ch);
                //                 }
                //                 MizerFixtureControl::ColorBlue => {
                //                     fixture_controls.insert(FixtureChannel::ColorMixer(FixtureColorChannel::Blue), ch);
                //                 }
                //                 MizerFixtureControl::Pan => {
                //                     fixture_controls.insert(FixtureChannel::Pan, ch);
                //                 }
                //                 MizerFixtureControl::Tilt => {
                //                     fixture_controls.insert(FixtureChannel::Tilt, ch);
                //                 }
                //                 MizerFixtureControl::Generic => {
                //                     todo!()
                //                 }
                //             }
                //         }
                //         
                //         
                // 
                //         SubFixtureChannelMode::new(i as u32 + 1, pixel.name, controls);
                //     })
                //     .collect();


                // FixtureChannelMode::new(mode.name, channels, sub_fixtures)
            })
            .collect(),
        tags: definition.metadata.tags,
        physical: Default::default(),
    }
}
