use crate::models::fixtures::*;
use protobuf::SingularPtrField;
use mizer_fixtures::fixture::{PhysicalFixtureData, ChannelResolution, FixtureChannelGroupType};
use std::collections::HashMap;

impl From<mizer_fixtures::fixture::FixtureDefinition> for FixtureDefinition {
    fn from(definition: mizer_fixtures::fixture::FixtureDefinition) -> Self {
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

impl From<mizer_fixtures::fixture::PhysicalFixtureData> for FixturePhysicalData {
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

impl From<mizer_fixtures::fixture::FixtureMode> for FixtureMode {
    fn from(mode: mizer_fixtures::fixture::FixtureMode) -> Self {
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

impl From<mizer_fixtures::fixture::FixtureChannelDefinition> for FixtureChannel {
    fn from(channel: mizer_fixtures::fixture::FixtureChannelDefinition) -> Self {
        FixtureChannel {
            name: channel.name,
            resolution: Some(channel.resolution.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::fixture::ChannelResolution> for FixtureChannel_oneof_resolution {
    fn from(resolution: mizer_fixtures::fixture::ChannelResolution) -> Self {
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

impl FixtureChannelGroup {
    pub fn with_values(group: &mizer_fixtures::fixture::FixtureChannelGroup, values: &HashMap<String, f64>) -> Self {
        Self {
            name: group.name.clone(),
            channel: Some(FixtureChannelGroup_oneof_channel::with_values(&group.group_type, values)),
            ..Default::default()
        }
    }
}

impl FixtureChannelGroup_oneof_channel {
    pub fn with_values(group_type: &mizer_fixtures::fixture::FixtureChannelGroupType, values: &HashMap<String, f64>) -> Self {
        use mizer_fixtures::fixture::FixtureChannelGroupType::*;
        match group_type {
            Color(color) => Self::color(ColorChannel {
                red: values.get(&color.red).copied().unwrap_or_default(),
                green: values.get(&color.green).copied().unwrap_or_default(),
                blue: values.get(&color.blue).copied().unwrap_or_default(),
                ..Default::default()
            }),
            Generic(channel) => Self::generic(GenericChannel {
                value: values.get(channel).copied().unwrap_or_default(),
                ..Default::default()
            }),
        }
    }
}
