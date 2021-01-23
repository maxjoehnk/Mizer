use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct Fixture {
    pub id: String,
    pub definition: FixtureDefinition,
    current_mode: FixtureMode,
    pub universe: u16,
    pub channel: u8,
    channel_values: HashMap<String, f64>,
}

impl Fixture {
    pub fn new(
        fixture_id: String,
        definition: FixtureDefinition,
        selected_mode: Option<String>,
        channel: u8,
        universe: Option<u16>,
    ) -> Self {
        Fixture {
            id: fixture_id,
            current_mode: get_current_mode(&definition, selected_mode),
            definition,
            channel,
            universe: universe.unwrap_or(1),
            channel_values: Default::default(),
        }
    }

    pub fn get_channels(&self) -> Vec<FixtureChannelDefinition> {
        self.current_mode.channels.clone()
    }

    pub fn write(&mut self, name: &str, value: f64) {
        self.channel_values.insert(name.to_string(), value);
    }

    pub fn get_dmx_values(&self) -> [u8; 255] {
        let mut buffer = [0; 255];

        for (channel_name, value) in self.channel_values.iter() {
            if let Some(channel) = self
                .current_mode
                .channels
                .iter()
                .find(|channel| &channel.name == channel_name)
            {
                match channel.resolution {
                    ChannelResolution::Coarse(coarse) => {
                        let channel = (self.channel + coarse - 1) as usize;
                        buffer[channel] = convert_value(*value);
                    }
                    _ => unimplemented!("only coarse is implemented right now"),
                }
            }
        }

        buffer
    }
}

fn convert_value(input: f64) -> u8 {
    let clamped = input.min(1.0).max(0.0);
    let channel = clamped * (u8::MAX as f64);

    channel.floor() as u8
}

fn get_current_mode(definition: &FixtureDefinition, selected_mode: Option<String>) -> FixtureMode {
    if let Some(selected_mode) = selected_mode {
        definition
            .modes
            .iter()
            .find(|mode| mode.name == selected_mode)
            .cloned()
            .expect("invalid fixture mode")
    } else {
        definition.modes[0].clone()
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureDefinition {
    pub name: String,
    pub manufacturer: String,
    pub modes: Vec<FixtureMode>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureMode {
    pub name: String,
    pub channels: Vec<FixtureChannelDefinition>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelDefinition {
    pub name: String,
    pub resolution: ChannelResolution,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum ChannelResolution {
    /// 8 Bit
    ///
    /// coarse
    Coarse(u8),
    /// 16 Bit
    ///
    /// coarse, fine
    Fine(u8, u8),
    /// 24 Bit
    ///
    /// coarse, fine, finest
    Finest(u8, u8, u8),
}
