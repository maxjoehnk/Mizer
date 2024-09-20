use mizer_fixtures::builder::{DmxChannelBuilder, FixtureDefinitionBuilder, FixtureModeBuilder};
use mizer_fixtures::channels::{DmxChannel, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureColorChannel, SubFixtureChannelMode};
use mizer_fixtures::definition::FixtureDefinition;

use crate::definition::{MizerFixtureControl, MizerFixtureDefinition};

pub fn map_fixture_definition(definition: MizerFixtureDefinition) -> anyhow::Result<FixtureDefinition> {
    let mut definition_builder = FixtureDefinitionBuilder::default();
    
    definition_builder.id(format!(
        "mizer:{}:{}",
        definition.metadata.manufacturer, definition.metadata.name
    ))
        .name(definition.metadata.name)
        .provider("Mizer")
        .manufacturer(definition.metadata.manufacturer)
        .tags(definition.metadata.tags);

    let mut custom_channel_number = 1u8;

    let mut custom_channel = || -> FixtureChannel {
        let n = custom_channel_number;
        custom_channel_number += 1;

        FixtureChannel::Custom(n)
    };
    
    for channel in definition.channels {
        let channel_builder = definition_builder.channel(channel.name.clone())
            .label(channel.name)
            .dmx_channel(DmxChannelBuilder::coarse());
        
        let fixture_channel = match channel.control {
            MizerFixtureControl::Intensity => FixtureChannel::Intensity,
            MizerFixtureControl::Shutter => FixtureChannel::Shutter(1),
            MizerFixtureControl::ColorRed => FixtureChannel::ColorMixer(FixtureColorChannel::Red),
            MizerFixtureControl::ColorGreen => FixtureChannel::ColorMixer(FixtureColorChannel::Green),
            MizerFixtureControl::ColorBlue => FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
            MizerFixtureControl::Pan => FixtureChannel::Pan,
            MizerFixtureControl::Tilt => FixtureChannel::Tilt,
            MizerFixtureControl::Generic => custom_channel(),
        };
        channel_builder.channel(fixture_channel);
    }
    
    for mode in definition.modes {
        let mut mode_builder = FixtureModeBuilder::new(mode.name);
        
        // TODO: This doesn't work with fine channels currently
        let mut channel_number = DmxChannel::new(0u16);
        
        for channel in mode.channels {
            mode_builder.use_prebuilt_channel(&definition_builder, &channel, Some(channel_number))?;
            channel_number += 1;
        }
        
        for pixel in mode.pixels {
            let mut sub_mode_builder = FixtureModeBuilder::new(pixel.name);
            
            for channel in pixel.channels {
                sub_mode_builder.use_prebuilt_channel(&definition_builder, &channel, Some(channel_number))?;
                channel_number += 1;
            }
            
            mode_builder.sub_fixture(sub_mode_builder);
        }
        
        definition_builder.mode(mode_builder);
    }
    
    
    definition_builder.build()
}
