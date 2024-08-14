use std::collections::HashMap;

use mizer_fixtures::definition::*;

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

#[derive(Default)]
struct GeometryStateBuilder {
    controls: FixtureControls<FixtureControlChannel>,
    color_builder: ColorGroupBuilder<FixtureControlChannel>,
}

impl GeometryStateBuilder {
    fn build(mut self) -> GeometryState {
        self.controls.color_mixer = self.color_builder.build();

        GeometryState {
            controls: self.controls,
        }
    }
}

#[derive(Debug, Default)]
struct GeometryState {
    controls: FixtureControls<FixtureControlChannel>,
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

    fn build_fixture_mode(&self, mode: DmxMode) -> FixtureMode {
        let mut geometries: HashMap<String, GeometryStateBuilder> = Default::default();

        for channel in mode.channels.channels.iter() {
            let geometry = geometries.entry(channel.geometry.clone()).or_default();
            if let Some(attribute) = self.attributes.get(&channel.logical_channel.attribute) {
                // FIXME: This is a hack so the SGM G-1 Beam profile works properly
                // I need to investigate how to handle this case better
                if attribute.name == "Macro" {
                    continue;
                }
                if let Some(feature) = self.features.get(&attribute.feature) {
                    let channel = if channel.offset.is_virtual() {
                        // TODO: add FixtureControlChannel::Virtual which delegates to other channels
                        continue;
                    } else {
                        FixtureControlChannel::Channel(format!(
                            "{}_{}",
                            channel.geometry, attribute.name
                        ))
                    };
                    match feature.name.as_str() {
                        "Dimmer" => geometry.controls.intensity = Some(channel),
                        "Focus" => geometry.controls.focus = Some(channel),
                        "RGB" => match attribute.name.as_str() {
                            "ColorAdd_R" => geometry.color_builder.red(channel),
                            "ColorAdd_G" => geometry.color_builder.green(channel),
                            "ColorAdd_B" => geometry.color_builder.blue(channel),
                            "ColorAdd_RY" => geometry.color_builder.amber(channel),
                            "ColorAdd_W" => geometry.color_builder.white(channel),
                            _ => {}
                        },
                        "Color" => {
                            geometry.controls.color_wheel = Some(ColorWheelGroup {
                                channel,
                                colors: Default::default(),
                            })
                        }
                        "PanTilt" => match attribute.name.as_str() {
                            "Pan" => {
                                geometry.controls.pan = Some(AxisGroup {
                                    channel,
                                    angle: None,
                                })
                            }
                            "Tilt" => {
                                geometry.controls.tilt = Some(AxisGroup {
                                    channel,
                                    angle: None,
                                })
                            }
                            _ => {}
                        },
                        "Control" => {
                            geometry.controls.generic.push(GenericControl {
                                channel,
                                label: attribute.pretty.clone(),
                            });
                        }
                        "Beam" => match attribute.name.as_str() {
                            "Shutter1" => geometry.controls.shutter = Some(channel),
                            "Iris1" => geometry.controls.iris = Some(channel),
                            "Frost1" => geometry.controls.frost = Some(channel),
                            "Prism1" => geometry.controls.prism = Some(channel),
                            "Zoom1" => geometry.controls.zoom = Some(channel),
                            _ => {}
                        },
                        "Gobo" => {
                            if attribute.name.as_str() == "Gobo1" {
                                geometry.controls.gobo = Some(GoboGroup {
                                    channel,
                                    gobos: vec![], // TODO: read gobo wheel variants
                                })
                            }
                        }
                        _ => {}
                    }
                }
            }
        }

        let channels = mode
            .channels
            .channels
            .into_iter()
            .filter(|channel| !channel.offset.is_virtual())
            .map(|channel| FixtureChannelDefinition {
                name: format!("{}_{}", channel.geometry, channel.logical_channel.attribute),
                resolution: channel.offset.into(),
            })
            .collect();

        let mut geometries: HashMap<_, _> = geometries
            .into_iter()
            .map(|(name, geometry)| (name, geometry.build()))
            .collect();

        let beam_count = self
            .geometries
            .count_beams(|name| geometries.contains_key(name));

        let (controls, sub_fixtures) = if beam_count > 1 {
            // TODO: this fails when a fixture has no "primary" beam as might be the case for the Roxx Blinders
            let parent_beam = self.geometries.first_beam().unwrap();
            let child_beams = parent_beam.child_beams();

            let mut parent_controls = Default::default();
            let parent_geometry = geometries.remove(&parent_beam.name).unwrap_or_default();
            parent_controls += parent_geometry.controls;

            let sub_fixtures = child_beams
                .into_iter()
                .enumerate()
                .map(|(i, beam)| {
                    let mut controls = Default::default();
                    let geometry = geometries.remove(&beam.name).unwrap_or_default();
                    controls += geometry.controls.into();
                    for geometry in beam
                        .child_names()
                        .into_iter()
                        .map(|name| geometries.remove(name).unwrap_or_default())
                    {
                        controls += geometry.controls.into();
                    }

                    SubFixtureDefinition::new(i as u32 + 1, beam.name.clone(), controls)
                })
                .collect();

            (parent_controls, sub_fixtures)
        } else {
            let mut controls = Default::default();
            for (_, geometry) in geometries {
                controls += geometry.controls;
            }

            (controls, Default::default())
        };

        FixtureMode::new(mode.name, channels, controls, sub_fixtures)
    }
}
