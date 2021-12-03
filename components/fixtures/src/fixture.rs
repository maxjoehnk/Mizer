use std::collections::HashMap;

use crate::definition::*;
use mizer_protocol_dmx::DmxOutput;

const U24_MAX: u32 = 16_777_215;

#[derive(Debug, Clone)]
pub struct Fixture {
    pub id: u32,
    pub definition: FixtureDefinition,
    pub current_mode: FixtureMode,
    pub universe: u16,
    pub channel: u8,
    pub output: Option<String>,
    /// Contains values for all dmx channels including sub-fixtures
    pub channel_values: HashMap<String, f64>,
}

impl Fixture {
    pub fn new(
        fixture_id: u32,
        definition: FixtureDefinition,
        selected_mode: Option<String>,
        output: Option<String>,
        channel: u8,
        universe: Option<u16>,
    ) -> Self {
        Fixture {
            id: fixture_id,
            current_mode: get_current_mode(&definition, selected_mode),
            definition,
            channel,
            output,
            universe: universe.unwrap_or(1),
            channel_values: Default::default(),
        }
    }

    pub fn get_channels(&self) -> Vec<FixtureChannelDefinition> {
        self.current_mode.channels.clone()
    }

    pub fn write<S: Into<String>>(&mut self, name: S, value: f64) {
        let name = name.into();
        log::trace!("write {} -> {}", name, value);
        self.channel_values.insert(name, value);
    }

    pub fn write_control(&mut self, control: FixtureControl, value: f64) {
        if let Some(channel) = self.current_mode.controls.get_channel(&control) {
            self.write(channel.to_string(), value)
        }
    }

    pub fn highlight(&mut self) {
        log::trace!("Highlighting FID {}", self.id);
        if let Some(channel) = self.current_mode.intensity() {
            self.write(&channel.name, 1f64);
        }
        if let Some(color_group) = self.current_mode.color() {
            self.write(&color_group.red, 1f64);
            self.write(&color_group.green, 1f64);
            self.write(&color_group.blue, 1f64);
        }
    }

    pub fn sub_fixture_mut(&mut self, id: u32) -> Option<SubFixture> {
        self.current_mode
            .sub_fixtures
            .iter()
            .find(|f| f.id == id)
            .cloned()
            .map(move |definition| SubFixture {
                fixture: self,
                definition,
            })
    }

    pub(crate) fn set_to_default(&mut self) {
        for channel in self.current_mode.channels.iter() {
            self.channel_values.insert(channel.name.clone(), 0f64);
        }
    }

    pub(crate) fn flush(&self, output: &dyn DmxOutput) {
        let buffer = self.get_dmx_values();
        let start = self.channel as usize;
        let end = start + self.current_mode.dmx_channels() as usize;
        output.write_bulk(self.universe, self.channel, &buffer[start..end]);
    }

    pub fn get_dmx_values(&self) -> [u8; 512] {
        let mut buffer = [0; 512];

        for (channel_name, value) in self.channel_values.iter() {
            if let Some(channel) = self
                .current_mode
                .channels
                .iter()
                .find(|channel| &channel.name == channel_name)
            {
                match channel.resolution {
                    ChannelResolution::Coarse(coarse) => {
                        let channel = (self.channel + coarse) as usize;
                        buffer[channel] = convert_value(*value);
                    }
                    ChannelResolution::Fine(coarse, fine) => {
                        let value = convert_value_16bit(*value);
                        let coarse_value = (value >> 0) & 0xff;
                        let fine_value = (value >> 8) & 0xff;
                        let coarse_channel = (self.channel + coarse) as usize;
                        let fine_channel = (self.channel + fine) as usize;
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                    }
                    ChannelResolution::Finest(coarse, fine, finest) => {
                        let value = convert_value_24bit(*value);
                        let coarse_value = (value >> 0) & 0xff;
                        let fine_value = (value >> 8) & 0xff;
                        let finest_value = (value >> 16) & 0xff;
                        let coarse_channel = (self.channel + coarse) as usize;
                        let fine_channel = (self.channel + fine) as usize;
                        let finest_channel = (self.channel + finest) as usize;
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                        buffer[finest_channel] = finest_value as u8;
                    }
                }
            }
        }

        buffer
    }
}

#[derive(Debug)]
pub struct SubFixture<'a> {
    fixture: &'a mut Fixture,
    definition: SubFixtureDefinition,
}

impl<'a> SubFixture<'a> {
    pub fn write_control(&mut self, control: FixtureControl, value: f64) {
        if let Some(channel) = self.definition.controls.get_channel(&control) {
            self.fixture.write(channel, value)
        }
    }

    pub fn highlight(&mut self) {
        if let Some(ref channel) = self.definition.controls.intensity {
            self.fixture.write(channel, 1f64);
        }
        if let Some(ref color_group) = self.definition.controls.color {
            self.fixture.write(&color_group.red, 1f64);
            self.fixture.write(&color_group.green, 1f64);
            self.fixture.write(&color_group.blue, 1f64);
        }
    }
}

fn convert_value(input: f64) -> u8 {
    let clamped = input.min(1.0).max(0.0);
    let channel = clamped * (u8::MAX as f64);

    channel.floor() as u8
}

fn convert_value_16bit(input: f64) -> u16 {
    let clamped = input.min(1.0).max(0.0);
    let channel = clamped * (u16::MAX as f64);

    channel.floor() as u16
}

fn convert_value_24bit(input: f64) -> u32 {
    let clamped = input.min(1.0).max(0.0);
    let channel = clamped * (U24_MAX as f64);

    channel.floor() as u32
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

impl FixtureControls {
    fn get_channel<'a>(&'a self, control: &'a FixtureControl) -> Option<&'a str> {
        match control {
            FixtureControl::Intensity => self.intensity.as_ref().map(|c| c.as_str()),
            FixtureControl::Shutter => self.shutter.as_ref().map(|c| c.as_str()),
            FixtureControl::Zoom => self.zoom.as_ref().map(|c| c.as_str()),
            FixtureControl::Focus => self.focus.as_ref().map(|c| c.as_str()),
            FixtureControl::Iris => self.iris.as_ref().map(|c| c.as_str()),
            FixtureControl::Prism => self.prism.as_ref().map(|c| c.as_str()),
            FixtureControl::Frost => self.frost.as_ref().map(|c| c.as_str()),
            FixtureControl::Color(ColorChannel::Red) => self.color.as_ref().map(|c| c.red.as_str()),
            FixtureControl::Color(ColorChannel::Green) => self.color.as_ref().map(|c| c.green.as_str()),
            FixtureControl::Color(ColorChannel::Blue) => self.color.as_ref().map(|c| c.blue.as_str()),
            FixtureControl::Pan => self.pan.as_ref().map(|axis| axis.channel.as_str()),
            FixtureControl::Tilt => self.tilt.as_ref().map(|axis| axis.channel.as_str()),
            FixtureControl::Generic(ref channel) => Some(channel.as_str()),
        }
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::{convert_value, convert_value_16bit, convert_value_24bit};

    #[test_case(0.0, 0)]
    #[test_case(1.0, 255)]
    #[test_case(0.5, 127)]
    fn convert_value_should_convert_to_8_bit(input: f64, expected: u8) {
        let result = convert_value(input);

        assert_eq!(result, expected);
    }

    #[test_case(0.0, 0)]
    #[test_case(1.0, 65_535)]
    #[test_case(0.5, 32_767)]
    fn convert_value_should_convert_to_16_bit(input: f64, expected: u16) {
        let result = convert_value_16bit(input);

        assert_eq!(result, expected);
    }

    #[test_case(0.0, 0)]
    #[test_case(1.0, 16_777_215)]
    #[test_case(0.5, 8_388_607)]
    fn convert_value_should_convert_to_24_bit(input: f64, expected: u32) {
        let result = convert_value_24bit(input);

        assert_eq!(result, expected);
    }
}
