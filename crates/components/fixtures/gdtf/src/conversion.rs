use std::collections::HashMap;
use mizer_fixtures::channels::{FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel, SubFixtureChannelMode};
use mizer_fixtures::definition::*;
use mizer_fixtures::fixture::SubFixtureMut;
use crate::definition::*;
use crate::types::*;

impl From<GdtfFixtureDefinition> for FixtureDefinition {
    fn from(definition: GdtfFixtureDefinition) -> Self {
        let state = GdtfState::build_state(&definition);

        FixtureDefinition {
            id: format!("gdtf:{}", definition.fixture_type.fixture_type_id),
            manufacturer: definition.fixture_type.manufacturer,
            name: definition.fixture_type.name,
            tags: Vec::new(),
            modes: definition
                .fixture_type
                .dmx_modes
                .modes
                .into_iter()
                .map(|mode| state.build_fixture_mode(mode))
                .collect(),
            physical: PhysicalFixtureData::default(),
            provider: "GDTF",
        }
    }
}

type GdtfAttributes = HashMap<String, Attribute>;
type GdtfFeatures = HashMap<FeatureRef, Feature>;
type GdtfGeometries = HashMap<String, Geometry>;

#[derive(Debug, Default)]
struct GeometryState {
    channels: Vec<FixtureChannelDefinition>,
}

struct GdtfState {
    attributes: GdtfAttributes,
    features: GdtfFeatures,
    geometries: Geometries,
}

impl GdtfState {
    fn build_state(definition: &GdtfFixtureDefinition) -> Self {
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

        Self {
            attributes,
            features,
            geometries: definition.fixture_type.geometries.clone(),
        }
    }

    fn build_fixture_mode(&self, mode: DmxMode) -> FixtureChannelMode {
        let mut geometries: HashMap<String, GeometryState> = Default::default();

        for channel in mode.channels.channels.iter() {
            let geometry = geometries.entry(channel.geometry.clone()).or_default();

            if channel.offset.is_virtual() {
                continue;
            }

            if let Some(attribute) = self.attributes.get(&channel.logical_channel.attribute) {
                // FIXME: This is a hack so the SGM G-1 Beam profile works properly
                // I need to investigate how to handle this case better
                if attribute.name == "Macro" {
                    continue;
                }
                if let Some(feature) = self.features.get(&attribute.feature) {
                    let fixture_channel = match feature.name.as_str() {
                        "Dimmer" => FixtureChannel::Intensity,
                        "Focus" => FixtureChannel::Focus,
                        "RGB" => match attribute.name.as_str() {
                            "ColorAdd_R" => FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                            "ColorAdd_G" => FixtureChannel::ColorMixer(FixtureColorChannel::Green),
                            "ColorAdd_B" => FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
                            "ColorAdd_RY" => FixtureChannel::ColorMixer(FixtureColorChannel::Amber),
                            "ColorAdd_W" => FixtureChannel::ColorMixer(FixtureColorChannel::White),
                            _ => todo!("Currently unsupported color attribute: {}", attribute.name),
                        },
                        "Color" => {
                            FixtureChannel::ColorWheel
                        }
                        "PanTilt" => match attribute.name.as_str() {
                            "Pan" => {
                                FixtureChannel::Pan
                            }
                            "Tilt" => {
                                FixtureChannel::Tilt
                            }
                            _ => todo!("Currently unsupported PanTilt attribute: {}", attribute.name),
                        },
                        // "Control" => {
                        //     geometry.controls.generic.push(GenericControl {
                        //         channel,
                        //         label: attribute.pretty.clone(),
                        //     });
                        // }
                        "Beam" => match attribute.name.as_str() {
                            "Shutter1" => FixtureChannel::Shutter,
                            "Iris1" => FixtureChannel::Iris,
                            "Frost1" => FixtureChannel::Frost,
                            "Prism1" => FixtureChannel::Prism,
                            "Zoom1" => FixtureChannel::Zoom,
                            _ => todo!("Currently unsupported Beam attribute: {}", attribute.name),
                        },
                        "Gobo" => {
                            if attribute.name.as_str() == "Gobo1" {
                                FixtureChannel::GoboWheel
                            } else {
                                todo!("Currently unsupported Gobo attribute: {}", attribute.name)
                            }
                        }
                        _ => todo!("Currently unsupported feature: {}", feature.name),
                    };

                    let channel_definition = FixtureChannelDefinition::builder()
                        // TODO: Remove this clone
                        .channels(channel.offset.clone().into())
                        .label(format!("{}_{}", channel.geometry, attribute.name).into())
                        .channel(fixture_channel)
                        .build();

                    geometry.channels.push(channel_definition);
                }
            }
        }

        let beam_count = self
            .geometries
            .count_beams(|name| geometries.contains_key(name));

        let (channels, sub_fixtures) = if beam_count > 1 {
            // TODO: this fails when a fixture has no "primary" beam as might be the case for the Roxx Blinders
            let parent_beam = self.geometries.first_beam().unwrap();
            let child_beams = parent_beam.child_beams();

            let mut parent_controls: Vec<FixtureChannelDefinition> = Default::default();
            let mut parent_geometry = geometries.remove(&parent_beam.name).unwrap_or_default();
            parent_controls.append(&mut parent_geometry.channels);

            let sub_fixtures = child_beams
                .into_iter()
                .enumerate()
                .map(|(i, beam)| {
                    let mut channels: Vec<FixtureChannelDefinition> = Default::default();
                    let mut geometry = geometries.remove(&beam.name).unwrap_or_default();
                    channels.append(&mut geometry.channels);
                    for mut geometry in beam
                        .child_names()
                        .into_iter()
                        .map(|name| geometries.remove(name).unwrap_or_default())
                    {
                        channels.append(&mut geometry.channels);
                    }

                    SubFixtureChannelMode::new(i as u32 + 1, beam.name.clone(), channels)
                })
                .collect();

            (parent_controls, sub_fixtures)
        } else {
            let mut controls: Vec<FixtureChannelDefinition> = Default::default();
            for (_, mut geometry) in geometries {
                controls.append(&mut geometry.channels);
            }

            (controls, Default::default())
        };

        FixtureChannelMode::new(mode.name, channels, sub_fixtures)
    }
}
