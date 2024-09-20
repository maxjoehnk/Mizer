use std::sync::Arc;
use indexmap::IndexMap;
use crate::channels::{DmxChannel, DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode, FixtureChannelPreset, FixtureValue, SubFixtureChannelMode};
use crate::definition::{FixtureDefinition, PhysicalFixtureData};

#[derive(Default)]
pub struct FixtureDefinitionBuilder {
    id: Option<String>,
    name: Option<String>,
    manufacturer: Option<String>,
    channels: IndexMap<String, FixtureChannelBuilder>,
    modes: Vec<FixtureModeBuilder>,
    tags: Vec<String>,
    provider: Option<&'static str>,
    pub physical: PhysicalFixtureData,
}

impl FixtureDefinitionBuilder {
    pub fn id(&mut self, id: String) -> &mut Self {
        self.id = Some(id);

        self
    }

    pub fn name(&mut self, name: String) -> &mut Self {
        self.name = Some(name.trim().to_string());

        self
    }

    pub fn manufacturer(&mut self, manufacturer: String) -> &mut Self {
        self.manufacturer = Some(manufacturer.trim().to_string());

        self
    }

    pub fn tag(&mut self, tag: String) -> &mut Self {
        self.tags.push(tag.trim().to_string());

        self
    }

    pub fn tags(&mut self, tags: Vec<String>) -> &mut Self {
        self.tags = tags;

        self
    }

    pub fn provider(&mut self, provider: &'static str) -> &mut Self {
        self.provider = Some(provider);

        self
    }

    pub fn channel(&mut self, name: String) -> &mut FixtureChannelBuilder {
        let name = name.trim().to_string();
        self.channels.insert(name.clone(), Default::default());

        self.channels.get_mut(&name).unwrap()
    }

    pub fn mode(&mut self, mode: FixtureModeBuilder) -> &mut Self {
        self.modes.push(mode);

        self
    }

    pub fn build(self) -> anyhow::Result<FixtureDefinition> {
        let id = self.id.ok_or_else(|| anyhow::anyhow!("Fixture ID is required"))?;
        let name = self.name.ok_or_else(|| anyhow::anyhow!("Fixture name is required"))?;
        let manufacturer = self.manufacturer.ok_or_else(|| anyhow::anyhow!("Fixture manufacturer is required"))?;
        let provider = self.provider.ok_or_else(|| anyhow::anyhow!("Fixture provider is required"))?;

        let modes = self.modes
            .into_iter()
            .map(|mode| mode.build())
            .collect::<anyhow::Result<_>>()?;

        Ok(FixtureDefinition {
            id,
            name,
            manufacturer,
            modes,
            physical: self.physical,
            tags: self.tags,
            provider,
        })
    }
}

#[derive(Default)]
pub struct FixtureModeBuilder {
    name: String,
    channels: IndexMap<FixtureChannel, FixtureModeChannelBuilder>,
    children: Vec<FixtureModeBuilder>,
    dmx_channel_count: Option<u16>,
}

impl FixtureModeBuilder {
    pub fn new(name: String) -> Self {
        Self {
            name: name.trim().to_string(),
            ..Default::default()
        }
    }

    pub fn dmx_channel_count(&mut self, channels: u16) -> &mut Self {
        self.dmx_channel_count = Some(channels);

        self
    }

    pub fn sub_fixture(&mut self, builder: FixtureModeBuilder) -> &mut Self {
        self.children.push(builder);

        self
    }

    pub fn use_prebuilt_channel(&mut self, fixture_builder: &FixtureDefinitionBuilder, channel_name: &str, dmx_channel: Option<DmxChannel>) -> anyhow::Result<&mut FixtureModeChannelBuilder> {
        let fixture_channel_builder = fixture_builder.channels.get(channel_name)
            .ok_or_else(|| anyhow::anyhow!("Channel {} not found", channel_name))?;
        let channel = fixture_channel_builder.fixture_channel.ok_or_else(|| anyhow::anyhow!("Channel {} is missing fixture channel", channel_name))?;

        return if self.channels.contains_key(&channel) {
            let channel_builder = self.channels.get_mut(&channel).unwrap();
            if let Some(label) = &fixture_channel_builder.label {
                channel_builder.label = Some(label.clone());
            }
            if let Some(default) = fixture_channel_builder.default {
                channel_builder.default = Some(default);
            }
            if let Some(highlight) = fixture_channel_builder.highlight {
                channel_builder.highlight = Some(highlight);
            }
            for preset in &fixture_channel_builder.presets {
                channel_builder.presets.push(preset.clone());
            }
            if let Some(dmx_channel_builder) = fixture_channel_builder.dmx_channel.as_ref() {
                let dmx_channel = DmxChannelBuilder {
                    endianess: dmx_channel_builder.endianess,
                    dmx_channel: dmx_channel_builder.dmx_channel.or(dmx_channel),
                };
                channel_builder.dmx_channels.push(dmx_channel);
            }
            Ok(channel_builder)
        } else {
            let channel_builder = FixtureModeChannelBuilder {
                channel: Some(channel),
                label: fixture_channel_builder.label.clone(),
                presets: fixture_channel_builder.presets.clone(),
                default: fixture_channel_builder.default,
                highlight: fixture_channel_builder.highlight,
                dmx_channels: fixture_channel_builder.dmx_channel.iter()
                    .map(|dmx_channel_builder| DmxChannelBuilder {
                        endianess: dmx_channel_builder.endianess,
                        dmx_channel,
                    })
                    .collect(),
                ..Default::default()
            };
            self.channels.insert(channel, channel_builder);

            Ok(self.channels.get_mut(&channel).unwrap())
        }
    }

    pub fn add_channel(&mut self, fixture_channel: FixtureChannel, channel: FixtureModeChannelBuilder) -> &mut Self {
        self.channels.insert(fixture_channel, channel);

        self
    }

    pub fn build(self) -> anyhow::Result<FixtureChannelMode> {
        let channels = self.channels.into_iter()
            .map(|(key, definition)| {
                let definition = definition.build()?;
                Ok((key, definition))
            })
            .collect::<anyhow::Result<IndexMap<_, _>>>()?;
        let children = self.children.into_iter()
            .enumerate()
            .map(|(id, child)| child.build_sub_fixture(id as u32))
            .collect::<anyhow::Result<Vec<_>>>()?;

        let dmx_channel_count = self.dmx_channel_count.unwrap_or_else(|| {
            let child_channels = children.iter()
                .flat_map(|c| c.channels.values().map(|c| c.channels.dmx_width()))
                .sum::<u16>();
            let channels = channels.values().map(|c| c.channels.dmx_width()).sum::<u16>();

            channels + child_channels
        });
        
        Ok(FixtureChannelMode {
            name: self.name.into(),
            channels,
            children,
            dmx_channel_count
        })
    }
    
    fn build_sub_fixture(self, id: u32) -> anyhow::Result<SubFixtureChannelMode> {
        let channels = self.channels.into_iter()
            .map(|(key, definition)| {
                let definition = definition.build()?;
                Ok((key, definition))
            })
            .collect::<anyhow::Result<IndexMap<_, _>>>()?;

        Ok(SubFixtureChannelMode {
            id,
            name: self.name.into(),
            channels
        })
    }
}

#[derive(Default)]
pub struct FixtureModeChannelBuilder {
    channel: Option<FixtureChannel>,
    label: Option<String>,
    dmx_channels: Vec<DmxChannelBuilder>,
    presets: Vec<FixtureChannelPreset>,
    default: Option<FixtureValue>,
    highlight: Option<FixtureValue>,
}

impl FixtureModeChannelBuilder {
    pub fn label(&mut self, label: String) -> &mut Self {
        self.label = Some(label.trim().to_string());

        self
    }

    pub fn default(&mut self, value: FixtureValue) -> &mut Self {
        self.default = Some(value);

        self
    }

    pub fn highlight(&mut self, value: FixtureValue) -> &mut Self {
        self.highlight = Some(value);

        self
    }

    pub fn channel(&mut self, channel: FixtureChannel) -> &mut Self {
        self.channel = Some(channel);

        self
    }

    pub fn dmx_channel(&mut self, dmx_channel: DmxChannelBuilder) -> &mut Self {
        self.dmx_channels.push(dmx_channel);

        self
    }

    pub fn add_preset(&mut self, preset: FixtureChannelPreset) -> &mut Self {
        self.presets.push(preset);

        self
    }

    pub fn presets(&mut self, presets: Vec<FixtureChannelPreset>) -> &mut Self {
        self.presets = presets;

        self
    }


    fn build(self) -> anyhow::Result<FixtureChannelDefinition> {
        let fixture_channel = self.channel.ok_or_else(|| anyhow::anyhow!("Channel is required"))?;
        let mut coarse = None;
        let mut fine = None;
        let mut finest = None;
        let mut ultra = None;
        for channels in self.dmx_channels {
            match channels.endianess {
                0 => coarse = channels.dmx_channel,
                1 => fine = channels.dmx_channel,
                2 => finest = channels.dmx_channel,
                3 => ultra = channels.dmx_channel,
                _ => return Err(anyhow::anyhow!("Invalid channel endianess"))
            }
        }
        let dmx_channels = match (coarse, fine, finest, ultra) {
            (Some(coarse), None, None, None) => DmxChannels::Resolution8Bit { coarse },
            (Some(coarse), Some(fine), None, None) => DmxChannels::Resolution16Bit { coarse, fine },
            (Some(coarse), Some(fine), Some(finest), None) => DmxChannels::Resolution24Bit { coarse, fine, finest },
            (Some(coarse), Some(fine), Some(finest), Some(ultra)) => DmxChannels::Resolution32Bit { coarse, fine, finest, ultra },
            _ => return Err(anyhow::anyhow!("Invalid dmx channel configuration"))
        };
        
        Ok(FixtureChannelDefinition {
            channel: fixture_channel,
            label: self.label.map(Arc::from),
            channels: dmx_channels,
            presets: self.presets,
            default: self.default,
            highlight: self.highlight,
        })
    }
}

#[derive(Default, Clone)]
pub struct FixtureChannelBuilder {
    fixture_channel: Option<FixtureChannel>,
    label: Option<String>,
    dmx_channel: Option<DmxChannelBuilder>,
    presets: Vec<FixtureChannelPreset>,
    default: Option<FixtureValue>,
    highlight: Option<FixtureValue>,
}

impl FixtureChannelBuilder {
    pub fn new(fixture_channel: FixtureChannel) -> Self {
        Self {
            fixture_channel: Some(fixture_channel),
            ..Default::default()
        }
    }

    pub fn label(&mut self, label: String) -> &mut Self {
        self.label = Some(label);

        self
    }

    pub fn default(&mut self, value: FixtureValue) {
        self.default = Some(value);
    }

    pub fn highlight(&mut self, value: FixtureValue) {
        self.highlight = Some(value);
    }

    pub fn channel(&mut self, channel: FixtureChannel) -> &mut Self {
        self.fixture_channel = Some(channel);

        self
    }

    pub fn dmx_channel(&mut self, dmx_channel: DmxChannelBuilder) -> &mut Self {
        self.dmx_channel = Some(dmx_channel);

        self
    }

    pub fn add_preset(&mut self, preset: FixtureChannelPreset) {
        self.presets.push(preset);
    }

    pub fn presets(&mut self, presets: Vec<FixtureChannelPreset>) -> &mut Self {
        self.presets = presets;

        self
    }
}

#[derive(Clone)]
pub struct DmxChannelBuilder {
    endianess: u8,
    dmx_channel: Option<DmxChannel>,
}

impl DmxChannelBuilder {
    pub fn new(endianess: u8, dmx_channel: DmxChannel) -> Self {
        Self {
            endianess,
            dmx_channel: Some(dmx_channel),
        }
    }

    pub fn from_endianess(endianess: u8) -> Self {
        Self {
            endianess,
            dmx_channel: None,
        }
    }

    pub fn coarse() -> Self {
        Self {
            endianess: 0,
            dmx_channel: None,
        }
    }

    pub fn fine() -> Self {
        Self {
            endianess: 1,
            dmx_channel: None,
        }
    }

    pub fn finest() -> Self {
        Self {
            endianess: 2,
            dmx_channel: None,
        }
    }

    pub fn ultra() -> Self {
        Self {
            endianess: 3,
            dmx_channel: None,
        }
    }
}
