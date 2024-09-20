use std::collections::HashMap;
use mizer_fixtures::builder::{FixtureDefinitionBuilder, FixtureModeBuilder, FixtureModeChannelBuilder};
use mizer_fixtures::channels::{FixtureChannel, FixtureColorChannel, FixtureShaperChannel};
use mizer_fixtures::definition::*;
use crate::definition::*;
use crate::PROVIDER_NAME;
use crate::types::*;

pub fn map_fixture_definition(definition: GdtfFixtureDefinition) -> anyhow::Result<FixtureDefinition> {
    let mut definition_builder = FixtureDefinitionBuilder::default();
    definition_builder
        .provider(PROVIDER_NAME)
        .id(format!("gdtf:{}", definition.fixture_type.fixture_type_id))
        .name(definition.fixture_type.name)
        .manufacturer(definition.fixture_type.manufacturer);

    let mut attributes = GdtfAttributes::default();
    let mut features = GdtfFeatures::default();

    for attribute in &definition
        .fixture_type
        .attribute_definitions
        .attributes
        .attributes
    {
        attributes.insert(attribute.name.clone(), attribute.clone());
    }
    for feature_group in &definition
        .fixture_type
        .attribute_definitions
        .feature_groups
        .groups
    {
        for feature in &feature_group.features {
            let feature_ref = FeatureRef {
                group: feature_group.name.clone(),
                feature: feature.name.clone(),
            };
            features.insert(feature_ref, feature.clone());
        }
    }

    for mode in definition.fixture_type.dmx_modes.modes {
        let mut mode_builder = FixtureModeBuilder::new(mode.name);
        
        let mut custom_channel_number = 1u8;

        let mut custom_channel = || -> FixtureChannel {
            let n = custom_channel_number;
            custom_channel_number += 1;

            FixtureChannel::Custom(n)
        };

        for channel in mode.channels.channels {
            if channel.offset.is_virtual() {
                continue;
            }

            let mut channel_builder: FixtureModeChannelBuilder = Default::default();

            if let Some(attribute) = attributes.get(&channel.logical_channel.attribute) {
                // FIXME: This is a hack so the SGM G-1 Beam profile works properly
                // I need to investigate how to handle this case better
                // if attribute.name == "Macro" {
                //     continue;
                // }
                if let Some(feature) = features.get(&attribute.feature) {
                    let fixture_channel = match feature.name.as_str() {
                        "Dimmer" => FixtureChannel::Intensity,
                        "Focus" => FixtureChannel::Focus(1),
                        "RGB" => match attribute.name.as_str() {
                            "ColorAdd_R" => FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                            "ColorAdd_G" => FixtureChannel::ColorMixer(FixtureColorChannel::Green),
                            "ColorAdd_B" => FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
                            "ColorAdd_RY" => FixtureChannel::ColorMixer(FixtureColorChannel::Amber),
                            "ColorAdd_GY" => FixtureChannel::ColorMixer(FixtureColorChannel::Lime),
                            "ColorAdd_W" => FixtureChannel::ColorMixer(FixtureColorChannel::White),
                            "ColorAdd_C" => FixtureChannel::ColorMixer(FixtureColorChannel::Cyan),
                            "ColorAdd_M" => FixtureChannel::ColorMixer(FixtureColorChannel::Magenta),
                            "ColorAdd_Y" => FixtureChannel::ColorMixer(FixtureColorChannel::Yellow),
                            // TODO: Do I need to separate these into different channels?
                            "ColorSub_C" => FixtureChannel::ColorMixer(FixtureColorChannel::Cyan),
                            "ColorSub_M" => FixtureChannel::ColorMixer(FixtureColorChannel::Magenta),
                            "ColorSub_Y" => FixtureChannel::ColorMixer(FixtureColorChannel::Yellow),
                            "ColorMacro1" => FixtureChannel::ColorWheel,
                            _ => custom_channel(),
                        },
                        "Color" => FixtureChannel::ColorWheel,
                        "PanTilt" => match attribute.name.as_str() {
                            "Pan" => FixtureChannel::Pan,
                            "Tilt" => FixtureChannel::Tilt,
                            "PanRotate" => FixtureChannel::PanSpeed,
                            "TiltRotate" => FixtureChannel::TiltSpeed,
                            _ => custom_channel(),
                        },
                        "Control" => match attribute.name.as_str() {
                            "PositionMSpeed" => FixtureChannel::PanTiltSpeed,
                            _ => custom_channel(),
                        },
                        // "Control" => {
                        //     geometry.controls.generic.push(GenericControl {
                        //         channel,
                        //         label: attribute.pretty.clone(),
                        //     });
                        // }
                        "Beam" => match attribute.name.as_str() {
                            "Shutter1" => FixtureChannel::Shutter(1),
                            "Iris" => FixtureChannel::Iris,
                            "Iris1" => FixtureChannel::Iris,
                            "Frost1" => FixtureChannel::Frost(1),
                            "Frost2" => FixtureChannel::Frost(2),
                            "Prism1" => FixtureChannel::Prism(1),
                            "Prism2" => FixtureChannel::Prism(2),
                            "Prism1PosRotate" => FixtureChannel::PrismRotation(1),
                            "Prism2PosRotate" => FixtureChannel::PrismRotation(2),
                            "Zoom1" => FixtureChannel::Zoom(1),
                            "Zoom2" => FixtureChannel::Zoom(2),
                            _ => custom_channel(),
                        },
                        "Gobo" => {
                            if attribute.name.as_str() == "Gobo1" {
                                FixtureChannel::GoboWheel(1)
                            } else if attribute.name.as_str() == "Gobo2" {
                                FixtureChannel::GoboWheel(2)
                            } else {
                                custom_channel()
                            }
                        }
                        "Shapers" => match attribute.name.as_str() {
                            "Blade1A" => FixtureChannel::Shaper(FixtureShaperChannel::Blade1a),
                            "Blade1B" => FixtureChannel::Shaper(FixtureShaperChannel::Blade1b),
                            "Blade2A" => FixtureChannel::Shaper(FixtureShaperChannel::Blade2a),
                            "Blade2B" => FixtureChannel::Shaper(FixtureShaperChannel::Blade2b),
                            "Blade3A" => FixtureChannel::Shaper(FixtureShaperChannel::Blade3a),
                            "Blade3B" => FixtureChannel::Shaper(FixtureShaperChannel::Blade3b),
                            "Blade4A" => FixtureChannel::Shaper(FixtureShaperChannel::Blade4a),
                            "Blade4B" => FixtureChannel::Shaper(FixtureShaperChannel::Blade4b),
                            "ShaperRot" => FixtureChannel::ShaperRotation,
                            _ => custom_channel(),
                        }
                        _ => custom_channel(),
                    };
                    
                    channel_builder.channel(fixture_channel)
                        .label(attribute.pretty.clone());

                    for dmx_channel in channel.offset.into_channels() {
                        channel_builder.dmx_channel(dmx_channel);
                    }
                    
                    if let Some(value) = channel.default.to_fixture_value() {
                        channel_builder.default(value);
                    }
                    if let Some(value) = channel.highlight.to_fixture_value() {
                        channel_builder.highlight(value);
                    }

                    mode_builder.add_channel(fixture_channel, channel_builder);
                }
            }
        }

        definition_builder.mode(mode_builder);
    }

    definition_builder.build()
}

type GdtfAttributes = HashMap<String, Attribute>;
type GdtfFeatures = HashMap<FeatureRef, Feature>;
type GdtfGeometries = HashMap<String, Geometry>;

// #[derive(Debug, Default)]
// struct GeometryState {
//     channels: Vec<FixtureChannelDefinition>,
// }
// 
// struct GdtfState {
//     attributes: GdtfAttributes,
//     features: GdtfFeatures,
//     geometries: Geometries,
// }
// 
// impl GdtfState {
//     fn build_state(definition: &GdtfFixtureDefinition) -> Self {
//         let mut attributes = GdtfAttributes::default();
//         let mut features = GdtfFeatures::default();
// 
//         for attribute in &definition
//             .fixture_type
//             .attribute_definitions
//             .attributes
//             .attributes
//         {
//             attributes.insert(attribute.name.clone(), attribute.clone());
//         }
//         for feature_group in &definition
//             .fixture_type
//             .attribute_definitions
//             .feature_groups
//             .groups
//         {
//             for feature in &feature_group.features {
//                 let feature_ref = FeatureRef {
//                     group: feature_group.name.clone(),
//                     feature: feature.name.clone(),
//                 };
//                 features.insert(feature_ref, feature.clone());
//             }
//         }
// 
//         Self {
//             attributes,
//             features,
//             geometries: definition.fixture_type.geometries.clone(),
//         }
//     }
// 
//     fn build_fixture_mode(&self, mode: DmxMode) -> FixtureChannelMode {
//         let mut geometries: HashMap<String, GeometryState> = Default::default();
// 
//         for channel in mode.channels.channels.iter() {
//             let geometry = geometries.entry(channel.geometry.clone()).or_default();
// 
// 
//             if let Some(attribute) = self.attributes.get(&channel.logical_channel.attribute) {
//                 // FIXME: This is a hack so the SGM G-1 Beam profile works properly
//                 // I need to investigate how to handle this case better
//                 if attribute.name == "Macro" {
//                     continue;
//                 }
//                 if let Some(feature) = self.features.get(&attribute.feature) {
//                     let fixture_channel = match feature.name.as_str() {
//                         "Dimmer" => FixtureChannel::Intensity,
//                         "Focus" => FixtureChannel::Focus,
//                         "RGB" => match attribute.name.as_str() {
//                             "ColorAdd_R" => FixtureChannel::ColorMixer(FixtureColorChannel::Red),
//                             "ColorAdd_G" => FixtureChannel::ColorMixer(FixtureColorChannel::Green),
//                             "ColorAdd_B" => FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
//                             "ColorAdd_RY" => FixtureChannel::ColorMixer(FixtureColorChannel::Amber),
//                             "ColorAdd_W" => FixtureChannel::ColorMixer(FixtureColorChannel::White),
//                             _ => todo!("Currently unsupported color attribute: {}", attribute.name),
//                         },
//                         "Color" => {
//                             FixtureChannel::ColorWheel
//                         }
//                         "PanTilt" => match attribute.name.as_str() {
//                             "Pan" => {
//                                 FixtureChannel::Pan
//                             }
//                             "Tilt" => {
//                                 FixtureChannel::Tilt
//                             }
//                             _ => todo!("Currently unsupported PanTilt attribute: {}", attribute.name),
//                         },
//                         // "Control" => {
//                         //     geometry.controls.generic.push(GenericControl {
//                         //         channel,
//                         //         label: attribute.pretty.clone(),
//                         //     });
//                         // }
//                         "Beam" => match attribute.name.as_str() {
//                             "Shutter1" => FixtureChannel::Shutter,
//                             "Iris1" => FixtureChannel::Iris,
//                             "Frost1" => FixtureChannel::Frost,
//                             "Prism1" => FixtureChannel::Prism,
//                             "Zoom1" => FixtureChannel::Zoom,
//                             _ => todo!("Currently unsupported Beam attribute: {}", attribute.name),
//                         },
//                         "Gobo" => {
//                             if attribute.name.as_str() == "Gobo1" {
//                                 FixtureChannel::GoboWheel
//                             } else {
//                                 todo!("Currently unsupported Gobo attribute: {}", attribute.name)
//                             }
//                         }
//                         _ => todo!("Currently unsupported feature: {}", feature.name),
//                     };
// 
//                     let channel_definition = FixtureChannelDefinition::builder()
//                         // TODO: Remove this clone
//                         .channels(channel.offset.clone().into())
//                         .label(format!("{}_{}", channel.geometry, attribute.name).into())
//                         .channel(fixture_channel)
//                         .build()
//                         .unwrap();
// 
//                     geometry.channels.push(channel_definition);
//                 }
//             }
//         }
// 
//         let beam_count = self
//             .geometries
//             .count_beams(|name| geometries.contains_key(name));
// 
//         let (channels, sub_fixtures) = if beam_count > 1 {
//             // TODO: this fails when a fixture has no "primary" beam as might be the case for the Roxx Blinders
//             let parent_beam = self.geometries.first_beam().unwrap();
//             let child_beams = parent_beam.child_beams();
// 
//             let mut parent_controls: Vec<FixtureChannelDefinition> = Default::default();
//             let mut parent_geometry = geometries.remove(&parent_beam.name).unwrap_or_default();
//             parent_controls.append(&mut parent_geometry.channels);
// 
//             let sub_fixtures = child_beams
//                 .into_iter()
//                 .enumerate()
//                 .map(|(i, beam)| {
//                     let mut channels: Vec<FixtureChannelDefinition> = Default::default();
//                     let mut geometry = geometries.remove(&beam.name).unwrap_or_default();
//                     channels.append(&mut geometry.channels);
//                     for mut geometry in beam
//                         .child_names()
//                         .into_iter()
//                         .map(|name| geometries.remove(name).unwrap_or_default())
//                     {
//                         channels.append(&mut geometry.channels);
//                     }
// 
//                     SubFixtureChannelMode::new(i as u32 + 1, beam.name.clone(), channels)
//                 })
//                 .collect();
// 
//             (parent_controls, sub_fixtures)
//         } else {
//             let mut controls: Vec<FixtureChannelDefinition> = Default::default();
//             for (_, mut geometry) in geometries {
//                 controls.append(&mut geometry.channels);
//             }
// 
//             (controls, Default::default())
//         };
// 
//         FixtureChannelMode::new(mode.name, channels, sub_fixtures)
//     }
// }
