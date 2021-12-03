use std::collections::HashMap;

use protobuf::SingularPtrField;

use mizer_fixtures::definition::{ChannelResolution, PhysicalFixtureData};

use crate::models::fixtures::*;

impl From<mizer_fixtures::definition::FixtureDefinition> for FixtureDefinition {
    fn from(definition: mizer_fixtures::definition::FixtureDefinition) -> Self {
        let physical: FixturePhysicalData = definition.physical.into();
        FixtureDefinition {
            id: definition.id,
            name: definition.name,
            manufacturer: definition.manufacturer,
            modes: definition
                .modes
                .into_iter()
                .map(FixtureMode::from)
                .collect::<Vec<_>>()
                .into(),
            tags: definition.tags.into(),
            physical: SingularPtrField::some(physical),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::PhysicalFixtureData> for FixturePhysicalData {
    fn from(physical_data: PhysicalFixtureData) -> Self {
        let mut data = FixturePhysicalData::new();
        if let Some(dimensions) = physical_data.dimensions {
            data.width = dimensions.width;
            data.height = dimensions.height;
            data.depth = dimensions.depth;
        }
        if let Some(weight) = physical_data.weight {
            data.weight = weight;
        }

        data
    }
}

impl From<mizer_fixtures::definition::FixtureMode> for FixtureMode {
    fn from(mode: mizer_fixtures::definition::FixtureMode) -> Self {
        FixtureMode {
            name: mode.name,
            channels: mode
                .channels
                .into_iter()
                .map(FixtureChannel::from)
                .collect::<Vec<_>>()
                .into(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::FixtureChannelDefinition> for FixtureChannel {
    fn from(channel: mizer_fixtures::definition::FixtureChannelDefinition) -> Self {
        FixtureChannel {
            name: channel.name,
            resolution: Some(channel.resolution.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::ChannelResolution> for FixtureChannel_oneof_resolution {
    fn from(resolution: mizer_fixtures::definition::ChannelResolution) -> Self {
        match resolution {
            ChannelResolution::Coarse(coarse) => {
                FixtureChannel_oneof_resolution::coarse(FixtureChannel_CoarseResolution {
                    channel: coarse.into(),
                    ..Default::default()
                })
            }
            ChannelResolution::Fine(fine, coarse) => {
                FixtureChannel_oneof_resolution::fine(FixtureChannel_FineResolution {
                    fineChannel: fine.into(),
                    coarseChannel: coarse.into(),
                    ..Default::default()
                })
            }
            ChannelResolution::Finest(finest, fine, coarse) => {
                FixtureChannel_oneof_resolution::finest(FixtureChannel_FinestResolution {
                    finestChannel: finest.into(),
                    fineChannel: fine.into(),
                    coarseChannel: coarse.into(),
                    ..Default::default()
                })
            }
        }
    }
}

impl FixtureControls {
    fn fader(control: FixtureControl, value: Option<f64>) -> Self {
        FixtureControls {
            control,
            value: value
                .map(|value| {
                    FixtureControls_oneof_value::fader(FaderChannel {
                        value,
                        ..Default::default()
                    })
                })
                .into(),
            ..Default::default()
        }
    }

    pub fn with_values(
        fixture_controls: mizer_fixtures::definition::FixtureControls,
        values: &HashMap<String, f64>,
    ) -> Vec<Self> {
        let mut controls = Vec::new();
        if let Some(channel) = fixture_controls.intensity {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::INTENSITY, value));
        }
        if let Some(channel) = fixture_controls.shutter {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::SHUTTER, value));
        }
        if let Some(channel) = fixture_controls.iris {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::IRIS, value));
        }
        if let Some(channel) = fixture_controls.zoom {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::ZOOM, value));
        }
        if let Some(channel) = fixture_controls.frost {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::FROST, value));
        }
        if let Some(channel) = fixture_controls.prism {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::PRISM, value));
        }
        if let Some(channel) = fixture_controls.focus {
            let value = values.get(&channel).copied();
            controls.push(FixtureControls::fader(FixtureControl::FOCUS, value));
        }
        if let Some(channel) = fixture_controls.pan {
            controls.push(FixtureControls {
                control: FixtureControl::PAN,
                value: Some(FixtureControls_oneof_value::axis(AxisChannel::with_value(
                    &channel, values,
                )))
                .into(),
                ..Default::default()
            });
        }
        if let Some(channel) = fixture_controls.tilt {
            controls.push(FixtureControls {
                control: FixtureControl::TILT,
                value: Some(FixtureControls_oneof_value::axis(AxisChannel::with_value(
                    &channel, values,
                )))
                .into(),
                ..Default::default()
            });
        }
        if let Some(color) = fixture_controls.color {
            controls.push(FixtureControls {
                control: FixtureControl::COLOR,
                value: Some(FixtureControls_oneof_value::color(ColorChannel {
                    red: values.get(&color.red).copied().unwrap_or_default(),
                    green: values.get(&color.green).copied().unwrap_or_default(),
                    blue: values.get(&color.blue).copied().unwrap_or_default(),
                    ..Default::default()
                }))
                .into(),
                ..Default::default()
            })
        }
        for channel in fixture_controls.generic {
            let value = values.get(&channel.channel).copied();
            controls.push(FixtureControls {
                control: FixtureControl::GENERIC,
                value: value
                    .map(|value| {
                        FixtureControls_oneof_value::generic(GenericChannel {
                            name: channel.label,
                            value,
                            ..Default::default()
                        })
                    })
                    .into(),
                ..Default::default()
            });
        }

        controls
    }
}

impl From<f64> for GenericChannel {
    fn from(value: f64) -> Self {
        Self {
            value,
            ..Default::default()
        }
    }
}

impl AxisChannel {
    fn with_value(
        axis: &mizer_fixtures::definition::AxisGroup,
        values: &HashMap<String, f64>,
    ) -> Self {
        AxisChannel {
            value: values.get(&axis.channel).copied().unwrap_or_default(),
            angle_from: axis
                .angle
                .map(|angle| angle.from as f64)
                .unwrap_or_default(),
            angle_to: axis.angle.map(|angle| angle.to as f64).unwrap_or_default(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::FixtureId> for FixtureId {
    fn from(id: mizer_fixtures::FixtureId) -> Self {
        match id {
            mizer_fixtures::FixtureId::Fixture(fixture_id) => Self {
                id: Some(FixtureId_oneof_id::fixture(fixture_id)),
                ..Default::default()
            },
            mizer_fixtures::FixtureId::SubFixture(fixture_id, child_id) => Self {
                id: Some(FixtureId_oneof_id::sub_fixture(SubFixtureId {
                    fixture_id,
                    child_id,
                    ..Default::default()
                })),
                ..Default::default()
            }
        }
    }
}

impl From<FixtureId> for mizer_fixtures::FixtureId {
    fn from(id: FixtureId) -> Self {
        match id.id {
            Some(FixtureId_oneof_id::fixture(fixture_id)) => Self::Fixture(fixture_id),
            Some(FixtureId_oneof_id::sub_fixture(SubFixtureId {
                fixture_id,
                child_id,
                ..
            })) => Self::SubFixture(fixture_id, child_id),
            _ => unreachable!()
        }
    }
}
