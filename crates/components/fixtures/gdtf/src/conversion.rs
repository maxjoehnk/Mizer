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
                .filter_map(|mode| state.build_fixture_mode(mode))
                .collect(),
            physical: PhysicalFixtureData::default(),
            provider: "GDTF",
        }
    }
}

type GdtfAttributes = HashMap<String, Attribute>;
type GdtfFeatures = HashMap<FeatureRef, Feature>;

#[derive(Default)]
struct GeometryStateBuilder {
    controls: FixtureControls<FixtureControlChannel>,
    color_builder: ColorGroupBuilder<FixtureControlChannel>,
    channels: Vec<FixtureChannelDefinition>,
}

impl GeometryStateBuilder {
    fn add_channel(&mut self, features: &GdtfFeatures, attributes: &GdtfAttributes, name: String, channel: &DmxChannel, dmx_breaks: &[ReferenceDmxBreak]) {
        if !channel.offset.is_virtual() {
            let channel_definition = FixtureChannelDefinition {
                name: name.clone(),
                resolution: channel.with_offsets(dmx_breaks).into(),
            };
            self.channels.push(channel_definition);
        }

        if let Some(attribute) = attributes.get(&channel.logical_channel.attribute) {
            // FIXME: This is a hack so the SGM G-1 Beam profile works properly
            // I need to investigate how to handle this case better
            if attribute.name == "Macro" {
                return;
            }
            if let Some(feature) = features.get(&attribute.feature) {
                let channel = if channel.offset.is_virtual() {
                    // TODO: add FixtureControlChannel::Virtual which delegates to other channels
                    return;
                } else {
                    FixtureControlChannel::Channel(name)
                };
                match feature.name.as_str() {
                    "Dimmer" => self.controls.intensity = Some(channel),
                    "Focus" => self.controls.focus = Some(channel),
                    "RGB" => match attribute.name.as_str() {
                        "ColorAdd_R" => self.color_builder.red(channel),
                        "ColorAdd_G" => self.color_builder.green(channel),
                        "ColorAdd_B" => self.color_builder.blue(channel),
                        "ColorAdd_GY" => self.color_builder.lime(channel),
                        "ColorAdd_RY" => self.color_builder.amber(channel),
                        "ColorAdd_W" => self.color_builder.white(channel),
                        _ => {}
                    },
                    "Color" => {
                        self.controls.color_wheel = Some(ColorWheelGroup {
                            channel,
                            colors: Default::default(),
                        })
                    }
                    "PanTilt" => match attribute.name.as_str() {
                        "Pan" => {
                            self.controls.pan = Some(AxisGroup {
                                channel,
                                angle: None,
                            })
                        }
                        "Tilt" => {
                            self.controls.tilt = Some(AxisGroup {
                                channel,
                                angle: None,
                            })
                        }
                        _ => {}
                    },
                    "Control" => {
                        self.controls.generic.push(GenericControl {
                            channel,
                            label: attribute.pretty.clone(),
                        });
                    }
                    "Beam" => match attribute.name.as_str() {
                        "Shutter1" => self.controls.shutter = Some(channel),
                        "Iris1" => self.controls.iris = Some(channel),
                        "Frost1" => self.controls.frost = Some(channel),
                        "Prism1" => self.controls.prism = Some(channel),
                        "Zoom1" => self.controls.zoom = Some(channel),
                        _ => {}
                    },
                    "Gobo" => {
                        if attribute.name.as_str() == "Gobo1" {
                            self.controls.gobo = Some(GoboGroup {
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

    fn build(mut self) -> GeometryState {
        self.controls.color_mixer = self.color_builder.build();

        GeometryState {
            controls: self.controls,
            channels: self.channels,
        }
    }
}

#[derive(Clone, Debug, Default)]
struct GeometryState {
    controls: FixtureControls<FixtureControlChannel>,
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

    fn build_fixture_mode(&self, mode: DmxMode) -> Option<FixtureMode> {
        let Some(mode_geometry) = self.geometries.get_root(&mode.geometry) else {
            tracing::warn!("Geometry {} not found in fixture mode {}", mode.geometry, mode.name);
            return None;
        };

        let mut channels_per_geometry: HashMap<String, Vec<DmxChannel>> = Default::default();

        for channel in mode.channels.channels.iter() {
            let channel_geometry = channels_per_geometry.entry(channel.geometry.clone()).or_default();
            channel_geometry.push(channel.clone());
        }

        let mut channels = Vec::default();

        let root_geometry = mode_geometry.root_features();
        let mut controls = Default::default();
        for geometry in root_geometry.features() {
            let geometry_channels = channels_per_geometry.remove(&geometry.name).unwrap_or_default();
            let mut builder = GeometryStateBuilder::default();
            for channel in &geometry_channels {
                builder.add_channel(
                    &self.features,
                    &self.attributes,
                    format!("{}_{}", channel.geometry, channel.logical_channel.attribute),
                    channel,
                    &geometry.dmx_breaks,
                );
            }
            let geometry_definition = builder.build();
            controls += geometry_definition.controls;
            channels.extend(geometry_definition.channels);
        }

        let mut sub_fixtures = Vec::default();

        if let Some(parent) = mode_geometry.lowest_parent() {
            let parent_name = String::default();

            let children = self.visit_children(&parent_name, parent, &channels_per_geometry);

            for (i, (name, controls, dmx_channels)) in children.into_iter().enumerate() {
                let sub_fixture = SubFixtureDefinition::new(
                    i as u32 + 1,
                    name,
                    controls
                );
                sub_fixtures.push(sub_fixture);
                channels.extend(dmx_channels);
            }
        }

        Some(FixtureMode::new(mode.name, channels, controls, sub_fixtures))
    }

    fn visit_children(&self, prefix: &str, parent: &dyn IGeometry, channels_per_geometry: &HashMap<String, Vec<DmxChannel>>) -> Vec<(String, FixtureControls<SubFixtureControlChannel>, Vec<FixtureChannelDefinition>)> {
        let mut sub_fixtures = Vec::default();
        for child in parent.children() {
            if let Some(child_definition) = self.visit_child(prefix, child, channels_per_geometry) {
                sub_fixtures.push(child_definition);
            }

            let grand_children = self.visit_children(
                &format!("{prefix}{}_", child.name()),
                child,
                channels_per_geometry,
            );

            sub_fixtures.extend(grand_children);
        }

        sub_fixtures
    }

    fn visit_child(&self, prefix: &str, child: &dyn IGeometry, channels_per_geometry: &HashMap<String, Vec<DmxChannel>>) -> Option<(String, FixtureControls<SubFixtureControlChannel>, Vec<FixtureChannelDefinition>)> {
        tracing::trace!("Visiting child: {}", child.name());
        let geometry = channels_per_geometry.get(child.name())?;
        if geometry.is_empty() {
            return None;
        }
        let mut builder = GeometryStateBuilder::default();
        for channel in geometry {
            builder.add_channel(
                &self.features,
                &self.attributes,
                format!("{prefix}{}_{}", channel.geometry, channel.logical_channel.attribute),
                channel,
                &child.feature().dmx_breaks,
            );
        }
        let geometry_channels = builder.build();
        let sub_fixture_controls = geometry_channels.controls.into();

        Some((
            format!("{}{}", prefix, child.name()),
            sub_fixture_controls,
            geometry_channels.channels
        ))
    }
}
