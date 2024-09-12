use std::collections::HashMap;

use mizer_protocol_dmx::DmxWriter;
use crate::channel_evaluator::ChannelValues;
use crate::channels::{FixtureChannel, FixtureChannelMode, FixtureValue, FixtureColorChannel, SubFixtureChannelMode, DmxChannels};
use crate::definition::*;
use crate::fixture_configuration::FixtureConfiguration;
pub use crate::priority::*;
pub use crate::sub_fixture::*;

const U24_MAX: u32 = 16_777_215;

const DMX_START_ADDRESS: usize = 0;
const DMX_END_ADDRESS: usize = 512;

#[derive(Debug, Clone)]
pub struct Fixture {
    pub id: u32,
    pub name: String,
    pub definition: FixtureDefinition,
    pub channel_mode: FixtureChannelMode,
    pub universe: u16,
    pub channel: u16,
    /// Contains values for all dmx channels of this fixture,
    pub(crate) channel_values: ChannelValues,
    pub(crate) children_channel_values: HashMap<u32, ChannelValues>,
    pub configuration: FixtureConfiguration,
}

impl Fixture {
    pub fn new(
        fixture_id: u32,
        name: String,
        definition: FixtureDefinition,
        selected_mode: Option<String>,
        channel: u16,
        universe: Option<u16>,
        configuration: FixtureConfiguration,
    ) -> Self {
        Fixture {
            id: fixture_id,
            name,
            channel_mode: get_current_mode(&definition, selected_mode),
            definition,
            channel,
            universe: universe.unwrap_or(1),
            channel_values: Default::default(),
            children_channel_values: Default::default(),
            configuration,
        }
    }

    pub fn sub_fixture(&self, id: u32) -> Option<SubFixture> {
        self.sub_fixture_definition(id)
            .map(move |definition| SubFixture {
                channel_values: &self.channel_values,
                definition,
            })
    }

    pub fn sub_fixture_mut(&mut self, id: u32) -> Option<SubFixtureMut> {
        self.channel_mode
            .children
            .iter()
            .position(|f| f.id == id)
            .and_then(|p| {
                let mut fixtures = self.channel_mode.children.iter_mut();
                if self.configuration.reverse_pixel_order {
                    fixtures.rev().nth(p)
                } else {
                    fixtures.nth(p)
                }
            })
            .map(|definition| SubFixtureMut {
                channel_values: &mut self.channel_values,
                definition,
            })
    }

    fn sub_fixture_definition(&self, id: u32) -> Option<&SubFixtureChannelMode> {
        let position = self
            .channel_mode
            .children
            .iter()
            .position(|f| f.id == id);

        position.and_then(|p| {
            let mut fixtures = self.channel_mode.children.iter();
            if self.configuration.reverse_pixel_order {
                fixtures.rev().nth(p)
            } else {
                fixtures.nth(p)
            }
        })
    }

    pub(crate) fn set_to_default(&mut self) {
        self.channel_values.clear();
        for (channel, definition) in &self.channel_mode.channels {
            self.channel_values
                .insert(*channel, definition.default.unwrap_or_default(), FixturePriority::LOWEST);
        }
        for sub_fixture in self.channel_mode.children.iter() {
            for (channel, definition) in &sub_fixture.channels {
                self.children_channel_values
                    .entry(sub_fixture.id)
                    .or_default()
                    .insert(*channel, definition.default.unwrap_or_default(), FixturePriority::LOWEST);
            }
        }
    }

    pub fn flush(&mut self, output: &dyn DmxWriter) {
        profiling::scope!("Fixture::flush");
        let buffer = self.get_dmx_values();
        let start = self.channel as usize;
        let start = start.clamp(DMX_START_ADDRESS, DMX_END_ADDRESS);
        let end = start + self.channel_mode.channel_count() as usize;
        let end = end.clamp(start, DMX_END_ADDRESS);
        output.write_bulk(self.universe, self.channel, &buffer[start..end]);
    }

    fn get_dmx_values(&self) -> [u8; DMX_END_ADDRESS] {
        profiling::scope!("Fixture::get_dmx_values");
        let mut buffer = [0; DMX_END_ADDRESS];

        for (channel, value) in self.channel_values.iter() {
            if let Some(definition) = self.channel_mode.channels.get(&channel) {
                let base_channel = self.channel as usize;
                match definition.channels {
                    DmxChannels::Resolution8Bit { coarse } => {
                        let channel = base_channel + coarse.as_usize();
                        buffer[channel] = convert_value(value);
                    }
                    DmxChannels::Resolution16Bit { coarse, fine } => {
                        let value = convert_value_16bit(value);
                        let coarse_value = (value >> 8) & 0xff;
                        #[allow(clippy::identity_op)]
                        let fine_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse.as_usize();
                        let fine_channel = base_channel + fine.as_usize();
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                    }
                    DmxChannels::Resolution24Bit { coarse, fine, finest } => {
                        let value = convert_value_24bit(value);
                        let coarse_value = (value >> 16) & 0xff;
                        let fine_value = (value >> 8) & 0xff;
                        #[allow(clippy::identity_op)]
                        let finest_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse.as_usize();
                        let fine_channel = base_channel + fine.as_usize();
                        let finest_channel = base_channel + finest.as_usize();
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                        buffer[finest_channel] = finest_value as u8;
                    }
                    DmxChannels::Resolution32Bit { coarse, fine, finest, ultra } => {
                        let value = convert_value_32bit(value);
                        let coarse_value = (value >> 24) & 0xff;
                        let fine_value = (value >> 16) & 0xff;
                        let finest_value = (value >> 8) & 0xff;
                        #[allow(clippy::identity_op)]
                        let ultra_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse.as_usize();
                        let fine_channel = base_channel + fine.as_usize();
                        let finest_channel = base_channel + finest.as_usize();
                        let ultra_channel = base_channel + ultra.as_usize();
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                        buffer[finest_channel] = finest_value as u8;
                        buffer[ultra_channel] = ultra_value as u8;
                    }
                }
            }
        }

        buffer
    }
}

impl IFixtureMut for Fixture {
    fn write_channel(&mut self, channel: FixtureChannel, value: FixtureValue, priority: FixturePriority) {
        profiling::scope!("Fixture::write_channel");
        self.channel_values.write_priority(channel, value, priority);
    }

    fn highlight(&mut self) {
        profiling::scope!("Fixture::highlight");
        for (channel, definition) in self.channel_mode.channels.iter() {
            if let Some(value) = definition.highlight {
                self.channel_values.insert(*channel, value, FixturePriority::HTP);
            }
        }
    }
}

impl IFixture for Fixture {
    fn read_channel(&self, channel: FixtureChannel) -> Option<f64> {
        profiling::scope!("Fixture::read_channel");
        self.channel_values.get(channel)
    }
}

pub trait IChannelType {
    fn into_channel(self) -> Option<String>;
    fn to_channel(&self) -> Option<&String>;
}

pub trait IFixture {
    fn read_channel(&self, channel: FixtureChannel) -> Option<f64>;
}

pub trait IFixtureMut: IFixture {
    fn write_channel(&mut self, channel: FixtureChannel, value: FixtureValue, priority: FixturePriority);

    fn highlight(&mut self) {
        self.write_channel(FixtureChannel::Intensity, FixtureValue::Percent(1f64), FixturePriority::HTP);
        self.write_channel(FixtureChannel::ColorMixer(FixtureColorChannel::Red), FixtureValue::Percent(1f64), FixturePriority::HTP);
        self.write_channel(FixtureChannel::ColorMixer(FixtureColorChannel::Green), FixtureValue::Percent(1f64), FixturePriority::HTP);
        self.write_channel(FixtureChannel::ColorMixer(FixtureColorChannel::Blue), FixtureValue::Percent(1f64), FixturePriority::HTP);
        self.write_channel(FixtureChannel::ColorMixer(FixtureColorChannel::White), FixtureValue::Percent(1f64), FixturePriority::HTP);
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

fn convert_value_32bit(input: f64) -> u32 {
    let clamped = input.min(1.0).max(0.0);
    let channel = clamped * (u32::MAX as f64);

    channel.floor() as u32
}

fn get_current_mode(definition: &FixtureDefinition, selected_mode: Option<String>) -> FixtureChannelMode {
    if let Some(selected_mode) = selected_mode {
        definition
            .modes
            .iter()
            .find(|mode| mode.name.as_str() == selected_mode)
            .cloned()
            .expect("invalid fixture mode")
    } else {
        definition.modes[0].clone()
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use crate::channels::FixtureChannel;
    use crate::fixture::{FixtureConfiguration};
    use crate::{ChannelLimit};

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

    #[test_case(0., 1.)]
    #[test_case(1., 0.)]
    #[test_case(0.5, 0.5)]
    fn fixture_configuration_adapt_read_should_invert_pan(input: f64, expected: f64) {
        let config = FixtureConfiguration {
            invert_pan: true,
            ..Default::default()
        };

        let result = config.adapt_read(FixtureChannel::Pan, input);

        assert_eq!(expected, result);
    }

    #[test_case(0., 1.)]
    #[test_case(1., 0.)]
    #[test_case(0.5, 0.5)]
    fn fixture_configuration_adapt_read_should_invert_tilt(input: f64, expected: f64) {
        let config = FixtureConfiguration {
            invert_tilt: true,
            ..Default::default()
        };

        let result = config.adapt_read(FixtureChannel::Tilt, input);

        assert_eq!(expected, result);
    }

    #[test_case(FixtureChannel::Pan)]
    #[test_case(FixtureChannel::Tilt)]
    #[test_case(FixtureChannel::Intensity)]
    fn fixture_configuration_adapt_read_should_passthrough_unrelated_values(
        control: FixtureChannel,
    ) {
        let config = FixtureConfiguration::default();

        let result = config.adapt_read(control, 1.0);

        assert_eq!(1.0, result);
    }

    #[test_case(1.0, None, None, 1.0)]
    #[test_case(0.5, None, None, 0.5)]
    #[test_case(1.0, None, Some(0.5), 0.5)]
    #[test_case(0.5, Some(0.5), None, 0.75)]
    #[test_case(0.5, Some(0.25), Some(0.75), 0.5)]
    fn fixture_configuration_adapt_write_should_limit_channel_value(
        input: f64,
        min: Option<f64>,
        max: Option<f64>,
        expected: f64,
    ) {
        let mut config = FixtureConfiguration::default();
        config
            .limits
            .insert(FixtureChannel::Intensity, ChannelLimit { min, max });

        let result = config.adapt_write(FixtureChannel::Intensity, input);

        assert_eq!(expected, result);
    }

    #[test_case(1.0, None, None, 1.0)]
    #[test_case(0.5, None, None, 0.5)]
    #[test_case(1.0, None, Some(0.5), 0.5)]
    #[test_case(0.5, Some(0.5), None, 0.75)]
    #[test_case(0.5, Some(0.25), Some(0.75), 0.5)]
    fn fixture_configuration_adapt_read_should_limit_channel_value(
        expected: f64,
        min: Option<f64>,
        max: Option<f64>,
        input: f64,
    ) {
        let mut config = FixtureConfiguration::default();
        config
            .limits
            .insert(FixtureChannel::Intensity, ChannelLimit { min, max });

        let result = config.adapt_read(FixtureChannel::Intensity, input);

        assert_eq!(expected, result);
    }
}
