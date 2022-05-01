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

struct GdtfState {
    attributes: GdtfAttributes,
    features: GdtfFeatures,
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
        }
    }

    fn build_fixture_mode(&self, mode: DmxMode) -> FixtureMode {
        let mut controls = FixtureControls::default();

        let mut color_builder = ColorGroup::<Option<FixtureControlChannel>> {
            green: None,
            blue: None,
            red: None,
        };

        for channel in mode.channels.channels.iter() {
            if let Some(attribute) = self.attributes.get(&channel.logical_channel.attribute) {
                if let Some(feature) = self.features.get(&attribute.feature) {
                    let channel = if channel.offset.is_virtual() {
                        // TODO: add FixtureControlChannel::Virtual which delegates to other channels
                        continue;
                    } else {
                        FixtureControlChannel::Channel(attribute.name.clone())
                    };
                    match feature.name.as_str() {
                        "Dimmer" => controls.intensity = Some(channel),
                        "Focus" => controls.focus = Some(channel),
                        "RGB" => match attribute.name.as_str() {
                            "ColorAdd_R" => color_builder.red = Some(channel),
                            "ColorAdd_G" => color_builder.green = Some(channel),
                            "ColorAdd_B" => color_builder.blue = Some(channel),
                            _ => {}
                        },
                        "PanTilt" => match attribute.name.as_str() {
                            "Pan" => {
                                controls.pan = Some(AxisGroup {
                                    channel,
                                    angle: None,
                                })
                            }
                            "Tilt" => {
                                controls.tilt = Some(AxisGroup {
                                    channel,
                                    angle: None,
                                })
                            }
                            _ => {}
                        },
                        "Control" => {
                            controls.generic.push(GenericControl {
                                channel,
                                label: attribute.pretty.clone(),
                            });
                        }
                        "Beam" => match attribute.name.as_str() {
                            "Shutter1" => controls.shutter = Some(channel),
                            "Iris1" => controls.iris = Some(channel),
                            "Frost1" => controls.frost = Some(channel),
                            "Prism1" => controls.prism = Some(channel),
                            "Zoom1" => controls.zoom = Some(channel),
                            _ => {}
                        },
                        "Gobo" => {
                            if attribute.name.as_str() == "Gobo1" {
                                controls.gobo = Some(GoboGroup {
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

        if let (Some(red), Some(green), Some(blue)) =
            (color_builder.red, color_builder.green, color_builder.blue)
        {
            controls.color_mixer = Some(ColorGroup { red, green, blue });
        }

        FixtureMode {
            name: mode.name,
            sub_fixtures: Vec::new(),
            channels: mode
                .channels
                .channels
                .into_iter()
                .filter(|channel| !channel.offset.is_virtual())
                .map(|channel| FixtureChannelDefinition {
                    name: channel.logical_channel.attribute,
                    resolution: channel.offset.into(),
                })
                .collect(),
            controls,
        }
    }
}
