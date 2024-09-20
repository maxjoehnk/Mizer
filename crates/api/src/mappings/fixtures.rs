use crate::proto::fixtures::*;

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
                .collect(),
            tags: definition.tags,
            physical: Some(physical),
            provider: definition.provider.to_string(),
        }
    }
}

impl From<mizer_fixtures::definition::PhysicalFixtureData> for FixturePhysicalData {
    fn from(physical_data: mizer_fixtures::definition::PhysicalFixtureData) -> Self {
        let mut data = FixturePhysicalData::default();
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

impl From<mizer_fixtures::channels::FixtureChannelMode> for FixtureMode {
    fn from(mode: mizer_fixtures::channels::FixtureChannelMode) -> Self {
        FixtureMode {
            channels: mode
                .channels
                .into_iter()
                .map(|(_, v)| v)
                .map(FixtureChannelDefinition::from)
                .collect(),
            name: mode.name.to_string(),
            dmx_footprint: mode.dmx_channel_count as u32,
        }
    }
}

impl From<mizer_fixtures::channels::FixtureChannelDefinition> for FixtureChannelDefinition {
    fn from(channel: mizer_fixtures::channels::FixtureChannelDefinition) -> Self {
        Self {
            category: FixtureChannelCategory::from(channel.channel_category()).into(),
            channel: channel.channel.to_string(),
            label: channel.label.map(|label| label.to_string()),
            presets: channel.presets.into_iter()
                .map(FixtureChannelPreset::from)
                .collect(),
        }
    }
}

impl From<mizer_fixtures::channels::FixtureChannelCategory> for FixtureChannelCategory {
    fn from(category: mizer_fixtures::channels::FixtureChannelCategory) -> Self {
        use mizer_fixtures::channels::FixtureChannelCategory::*;
        match category {
            Dimmer => Self::Dimmer,
            Position => Self::Position,
            Color => Self::Color,
            Gobo => Self::Gobo,
            Beam => Self::Beam,
            Shaper => Self::Shaper,
            Custom => Self::Custom,
        }
    }
}

impl From<mizer_fixtures::channels::FixtureChannelPreset> for FixtureChannelPreset {
    fn from(preset: mizer_fixtures::channels::FixtureChannelPreset) -> Self {
        Self {
            value: Some(FixtureValue {
                value: Some(fixture_value::Value::Percent(preset.value.get_percent())),
            }),
            name: preset.name,
            colors: preset.color,
            image: preset.image.map(FixtureImage::from),
        }
    }
}

impl From<mizer_fixtures::channels::FixtureImage> for FixtureImage {
    fn from(image: mizer_fixtures::channels::FixtureImage) -> Self {
        use mizer_fixtures::channels::FixtureImage::*;
        
        FixtureImage {
            image: Some(
                match image {
                    Raster(bytes) => fixture_image::Image::Raster(bytes.to_vec()),
                    Svg(svg) => fixture_image::Image::Svg(svg.to_string()),
                }
            ),
        }
    }
}

impl From<mizer_fixtures::FixtureId> for FixtureId {
    fn from(id: mizer_fixtures::FixtureId) -> Self {
        match id {
            mizer_fixtures::FixtureId::Fixture(fixture_id) => Self {
                id: Some(fixture_id::Id::Fixture(fixture_id)),
                ..Default::default()
            },
            mizer_fixtures::FixtureId::SubFixture(fixture_id, child_id) => Self {
                id: Some(fixture_id::Id::SubFixture(SubFixtureId {
                    fixture_id,
                    child_id,
                    ..Default::default()
                })),
                ..Default::default()
            },
        }
    }
}

impl From<FixtureId> for mizer_fixtures::FixtureId {
    fn from(id: FixtureId) -> Self {
        match id.id {
            Some(fixture_id::Id::Fixture(fixture_id)) => Self::Fixture(fixture_id),
            Some(fixture_id::Id::SubFixture(SubFixtureId {
                fixture_id,
                child_id,
                ..
            })) => Self::SubFixture(fixture_id, child_id),
            _ => unreachable!(),
        }
    }
}
