use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::hash::{Hash, Hasher};

use mizer_protocol_dmx::DmxWriter;
use mizer_util::LerpExt;

pub(crate) use crate::channel_values::*;
use crate::color_mixer::update_color_mixer;
use crate::definition::*;
use crate::manager::{FadeTimings, FixtureValueSource};
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
    pub current_mode: FixtureMode,
    pub universe: u16,
    pub channel: u16,
    /// Contains values for all dmx channels including sub-fixtures
    pub(crate) channel_values: ChannelsWithValues,
    pub configuration: FixtureConfiguration,
    pub sub_master: f64,
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct FixtureConfiguration {
    #[serde(default)]
    pub invert_pan: bool,
    #[serde(default)]
    pub invert_tilt: bool,
    #[serde(default)]
    pub reverse_pixel_order: bool,
    #[serde(default)]
    pub limits: HashMap<FixtureFaderControl, ChannelLimit>,
}

#[derive(Debug, Default, Copy, Clone, Deserialize, Serialize, PartialEq)]
pub struct ChannelLimit {
    #[serde(default)]
    pub min: Option<f64>,
    #[serde(default)]
    pub max: Option<f64>,
}

impl Hash for ChannelLimit {
    fn hash<H: Hasher>(&self, state: &mut H) {
        if let Some(min) = self.min {
            min.to_bits().hash(state);
        } else {
            0u64.hash(state);
        }
        if let Some(max) = self.max {
            max.to_bits().hash(state);
        } else {
            0u64.hash(state);
        }
    }
}

impl ChannelLimit {
    fn adapt_read(&self, value: f64) -> f64 {
        let min = self.min.unwrap_or(0.);
        let max = self.max.unwrap_or(1.);

        value.linear_extrapolate((min, max), (0., 1.))
    }

    fn adapt_write(&self, value: f64) -> f64 {
        let min = self.min.unwrap_or(0.);
        let max = self.max.unwrap_or(1.);

        value.linear_extrapolate((0., 1.), (min, max))
    }
}

impl FixtureConfiguration {
    pub(crate) fn adapt_write(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        let value = self.adapt_pan_tilt(control, value);
        let value = self.adapt_write_limits(control, value);

        value
    }

    pub(crate) fn adapt_read(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        let value = self.adapt_pan_tilt(control, value);
        let value = self.adapt_read_limits(control, value);

        value
    }

    fn adapt_pan_tilt(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        match control {
            FixtureFaderControl::Pan if self.invert_pan => (1. - value).abs(),
            FixtureFaderControl::Tilt if self.invert_tilt => (1. - value).abs(),
            _ => value,
        }
    }

    fn adapt_write_limits(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        if let Some(limits) = self.limits.get(control) {
            limits.adapt_write(value)
        } else {
            value
        }
    }

    fn adapt_read_limits(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        if let Some(limits) = self.limits.get(control) {
            limits.adapt_read(value)
        } else {
            value
        }
    }
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
            current_mode: get_current_mode(&definition, selected_mode),
            definition,
            channel,
            universe: universe.unwrap_or(1),
            channel_values: Default::default(),
            configuration,
            sub_master: 1.0
        }
    }

    pub fn get_channels(&self) -> Vec<FixtureChannelDefinition> {
        self.current_mode
            .get_channels()
            .into_iter()
            .cloned()
            .collect()
    }

    pub fn sub_fixture(&self, id: u32) -> Option<SubFixture> {
        self.sub_fixture_definition(id)
            .map(move |definition| SubFixture {
                channel_values: &self.channel_values,
                definition,
            })
    }

    pub fn sub_fixture_mut(&mut self, id: u32) -> Option<SubFixtureMut> {
        self.current_mode
            .sub_fixtures
            .iter()
            .position(|f| f.id == id)
            .and_then(|p| {
                let mut fixtures = self.current_mode.sub_fixtures.iter_mut();
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

    fn sub_fixture_definition(&self, id: u32) -> Option<&SubFixtureDefinition> {
        let position = self
            .current_mode
            .sub_fixtures
            .iter()
            .position(|f| f.id == id);

        position.and_then(|p| {
            let mut fixtures = self.current_mode.sub_fixtures.iter();
            if self.configuration.reverse_pixel_order {
                fixtures.rev().nth(p)
            } else {
                fixtures.nth(p)
            }
        })
    }

    pub(crate) fn set_to_default(&mut self) {
        self.channel_values.clear();
        // TODO: FixtureMode should contain default values
        for channel in self.current_mode.get_channels() {
            self.channel_values.insert(
                &channel.name,
                0f64,
                FixturePriority::LOWEST,
                Default::default(),
                Default::default(),
            );
        }
        if let Some(mixer) = self.current_mode.color_mixer.as_mut() {
            mixer.clear();
            mixer.set_red(
                0f64,
                FixturePriority::LOWEST,
                Default::default(),
                Default::default(),
            );
            mixer.set_green(
                0f64,
                FixturePriority::LOWEST,
                Default::default(),
                Default::default(),
            );
            mixer.set_blue(
                0f64,
                FixturePriority::LOWEST,
                Default::default(),
                Default::default(),
            );
            if mixer.virtual_dimmer().is_some() {
                mixer.set_virtual_dimmer(
                    0f64,
                    FixturePriority::LOWEST,
                    Default::default(),
                    Default::default(),
                );
            }
        }
        for sub_fixture in self.current_mode.sub_fixtures.iter_mut() {
            if let Some(mixer) = sub_fixture.color_mixer.as_mut() {
                mixer.clear();
                mixer.set_red(
                    0f64,
                    FixturePriority::LOWEST,
                    Default::default(),
                    Default::default(),
                );
                mixer.set_green(
                    0f64,
                    FixturePriority::LOWEST,
                    Default::default(),
                    Default::default(),
                );
                mixer.set_blue(
                    0f64,
                    FixturePriority::LOWEST,
                    Default::default(),
                    Default::default(),
                );
                if mixer.virtual_dimmer().is_some() {
                    mixer.set_virtual_dimmer(
                        0f64,
                        FixturePriority::LOWEST,
                        Default::default(),
                        Default::default(),
                    );
                }
            }
        }
    }

    pub fn flush(&mut self, output: &dyn DmxWriter) {
        profiling::scope!("Fixture::flush");
        if self.current_mode.color_mixer.is_some() {
            self.update_color_mixer();
        }
        let ids = self
            .current_mode
            .sub_fixtures
            .iter()
            .map(|f| f.id)
            .collect::<Vec<_>>();
        for sub_fixture_id in ids {
            if let Some(mut sub_fixture) = self.sub_fixture_mut(sub_fixture_id) {
                if sub_fixture.definition.color_mixer.is_some() {
                    sub_fixture.update_color_mixer();
                }
            }
        }
        self.apply_submaster();
        self.channel_values.flush();

        let buffer = self.get_dmx_values();
        let start = self.channel as usize;
        let start = start.clamp(DMX_START_ADDRESS, DMX_END_ADDRESS);
        let end = start + self.current_mode.dmx_channels() as usize;
        let end = end.clamp(start, DMX_END_ADDRESS);
        output.write_bulk(self.universe, self.channel, &buffer[start..end]);
    }

    fn get_dmx_values(&self) -> [u8; DMX_END_ADDRESS] {
        profiling::scope!("Fixture::get_dmx_values");
        let mut buffer = [0; DMX_END_ADDRESS];

        for (channel_name, value) in self.channel_values.iter() {
            if let Some(channel) = self.current_mode.get_channel(channel_name) {
                let base_channel = self.channel as usize;
                match channel.resolution {
                    ChannelResolution::Coarse(coarse) => {
                        let channel = base_channel + coarse as usize;
                        buffer[channel] = convert_value(value);
                    }
                    ChannelResolution::Fine(coarse, fine) => {
                        let value = convert_value_16bit(value);
                        let coarse_value = (value >> 8) & 0xff;
                        #[allow(clippy::identity_op)]
                        let fine_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse as usize;
                        let fine_channel = base_channel + fine as usize;
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                    }
                    ChannelResolution::Finest(coarse, fine, finest) => {
                        let value = convert_value_24bit(value);
                        let coarse_value = (value >> 16) & 0xff;
                        let fine_value = (value >> 8) & 0xff;
                        #[allow(clippy::identity_op)]
                        let finest_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse as usize;
                        let fine_channel = base_channel + fine as usize;
                        let finest_channel = base_channel + finest as usize;
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                        buffer[finest_channel] = finest_value as u8;
                    }
                    ChannelResolution::Ultra(coarse, fine, finest, ultra) => {
                        let value = convert_value_32bit(value);
                        let coarse_value = (value >> 24) & 0xff;
                        let fine_value = (value >> 16) & 0xff;
                        let finest_value = (value >> 8) & 0xff;
                        #[allow(clippy::identity_op)]
                        let ultra_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse as usize;
                        let fine_channel = base_channel + fine as usize;
                        let finest_channel = base_channel + finest as usize;
                        let ultra_channel = base_channel + ultra as usize;
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

    fn update_color_mixer(&mut self) {
        profiling::scope!("Fixture::update_color_mixer");
        if let Some(color_mixer) = self.current_mode.color_mixer.as_mut() {
            color_mixer.flush();
        }
        update_color_mixer(
            self.current_mode.color_mixer.as_ref(),
            self.current_mode.controls.color_mixer.as_ref(),
            |channel, value| self.channel_values.write(channel, value),
        );
    }

    fn apply_submaster(&mut self) {
        match self.current_mode.controls.intensity.as_ref() {
            Some(FixtureControlChannel::Channel(channel)) => {
                self.channel_values.apply_master(channel, self.sub_master);
            }
            Some(FixtureControlChannel::VirtualDimmer) => {
                if let Some(color_mixer) = self.current_mode.color_mixer.as_mut() {
                    color_mixer.apply_master(self.sub_master);
                }
            }
            _ => {}
        }
        for sub_fixture in self.current_mode.sub_fixtures.iter_mut() {
            match sub_fixture.controls.intensity.as_ref() {
                Some(SubFixtureControlChannel::Channel(channel)) => {
                    self.channel_values.apply_master(channel, self.sub_master);
                }
                Some(SubFixtureControlChannel::VirtualDimmer) => {
                    if let Some(color_mixer) = sub_fixture.color_mixer.as_mut() {
                        color_mixer.apply_master(self.sub_master);
                    }
                }
                _ => {}
            }
        }
    }
}

impl IFixtureMut for Fixture {
    fn write_fader_control_with_timings(
        &mut self,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        profiling::scope!("Fixture::write_fader_control");
        let value = self.configuration.adapt_write(&control, value);
        match self.current_mode.controls.get_channel(&control) {
            Some(FixtureControlChannel::Channel(ref channel)) => {
                if let FixtureFaderControl::ColorMixer(color_channel) = control {
                    if let Some(color_mixer) = self.current_mode.color_mixer.as_mut() {
                        match color_channel {
                            ColorChannel::Red => {
                                color_mixer.set_red(value, priority, source, fade_timings)
                            }
                            ColorChannel::Green => {
                                color_mixer.set_green(value, priority, source, fade_timings)
                            }
                            ColorChannel::Blue => {
                                color_mixer.set_blue(value, priority, source, fade_timings)
                            }
                        }
                    }
                } else {
                    self.channel_values.write_priority_with_timings(
                        channel,
                        value,
                        priority,
                        source,
                        fade_timings,
                    )
                }
            }
            Some(FixtureControlChannel::Delegate) => {
                for definition in self.current_mode.sub_fixtures.iter_mut() {
                    let mut fixture = SubFixtureMut {
                        channel_values: &mut self.channel_values,
                        definition,
                    };
                    fixture.write_fader_control_with_timings(
                        control.clone(),
                        value,
                        priority,
                        source.clone(),
                        fade_timings,
                    );
                }
            }
            Some(FixtureControlChannel::VirtualDimmer) => {
                debug_assert!(
                    control == FixtureFaderControl::Intensity,
                    "Trying to write non intensity channel to virtual dimmer"
                );
                if let Some(color_mixer) = self.current_mode.color_mixer.as_mut() {
                    color_mixer.set_virtual_dimmer(value, priority, source, fade_timings);
                }
            }
            None => {}
        }
    }
}

impl IFixture for Fixture {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("Fixture::read_control");
        if let FixtureFaderControl::ColorMixer(channel) = control {
            let color_mixer = self.current_mode.color_mixer.as_ref()?;
            let rgb = color_mixer.rgb();

            return match channel {
                ColorChannel::Red => Some(rgb.red),
                ColorChannel::Green => Some(rgb.green),
                ColorChannel::Blue => Some(rgb.blue),
            };
        }
        match self.current_mode.controls.get_channel(&control) {
            Some(FixtureControlChannel::Channel(ref channel)) => self
                .channel_values
                .get(channel)
                .map(|value| self.configuration.adapt_read(&control, value)),
            Some(FixtureControlChannel::VirtualDimmer) => self
                .current_mode
                .color_mixer
                .as_ref()
                .and_then(|mixer| mixer.virtual_dimmer()),
            _ => None,
        }
    }
}

pub trait IChannelType {
    fn into_channel(self) -> Option<String>;
    fn to_channel(&self) -> Option<&String>;
}

pub trait IFixture {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64>;
}

pub trait IFixtureMut: IFixture {
    fn write_fader_control(
        &mut self,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        self.write_fader_control_with_timings(
            control,
            value,
            priority,
            None,
            FadeTimings::default(),
        );
    }
    fn write_fader_control_with_timings(
        &mut self,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    );

    fn highlight(&mut self) {
        self.write_fader_control(
            FixtureFaderControl::Intensity,
            1f64,
            FixturePriority::Highlight,
        );
        self.write_fader_control(
            FixtureFaderControl::ColorMixer(ColorChannel::Red),
            1f64,
            FixturePriority::Highlight,
        );
        self.write_fader_control(
            FixtureFaderControl::ColorMixer(ColorChannel::Green),
            1f64,
            FixturePriority::Highlight,
        );
        self.write_fader_control(
            FixtureFaderControl::ColorMixer(ColorChannel::Blue),
            1f64,
            FixturePriority::Highlight,
        );
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

impl<TChannel> FixtureControls<TChannel> {
    pub(crate) fn get_channel<'a>(
        &'a self,
        control: &'a FixtureFaderControl,
    ) -> Option<&'a TChannel> {
        match control {
            FixtureFaderControl::Intensity => self.intensity.as_ref(),
            FixtureFaderControl::Shutter => self.shutter.as_ref(),
            FixtureFaderControl::Zoom => self.zoom.as_ref(),
            FixtureFaderControl::Focus => self.focus.as_ref(),
            FixtureFaderControl::Iris => self.iris.as_ref(),
            FixtureFaderControl::Prism => self.prism.as_ref(),
            FixtureFaderControl::Frost => self.frost.as_ref(),
            // TODO: returning cmy channels when fetching rgb channels is not correct
            // This should probably be restructured, though the capability to specify a channel mode (channel, delegate, virtual) per control is quite nice
            FixtureFaderControl::ColorMixer(ColorChannel::Red) => match self.color_mixer.as_ref() {
                Some(ColorGroup::Rgb { red, .. }) => Some(red),
                Some(ColorGroup::Cmy { cyan, .. }) => Some(cyan),
                _ => None,
            },
            FixtureFaderControl::ColorMixer(ColorChannel::Green) => {
                match self.color_mixer.as_ref() {
                    Some(ColorGroup::Rgb { green, .. }) => Some(green),
                    Some(ColorGroup::Cmy { magenta, .. }) => Some(magenta),
                    _ => None,
                }
            }
            FixtureFaderControl::ColorMixer(ColorChannel::Blue) => {
                match self.color_mixer.as_ref() {
                    Some(ColorGroup::Rgb { blue, .. }) => Some(blue),
                    Some(ColorGroup::Cmy { yellow, .. }) => Some(yellow),
                    _ => None,
                }
            }
            FixtureFaderControl::ColorWheel => {
                self.color_wheel.as_ref().map(|color| &color.channel)
            }
            FixtureFaderControl::Pan => self.pan.as_ref().map(|axis| &axis.channel),
            FixtureFaderControl::Tilt => self.tilt.as_ref().map(|axis| &axis.channel),
            FixtureFaderControl::Gobo => self.gobo.as_ref().map(|gobo| &gobo.channel),
            FixtureFaderControl::Generic(ref channel) => self
                .generic
                .iter()
                .find(|c| &c.label == channel)
                .map(|c| &c.channel),
        }
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use crate::definition::FixtureFaderControl;
    use crate::fixture::{ChannelLimit, FixtureConfiguration};
    use crate::{FixturePriority, LTPPriority};

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

        let result = config.adapt_read(&FixtureFaderControl::Pan, input);

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

        let result = config.adapt_read(&FixtureFaderControl::Tilt, input);

        assert_eq!(expected, result);
    }

    #[test_case(FixtureFaderControl::Pan)]
    #[test_case(FixtureFaderControl::Tilt)]
    #[test_case(FixtureFaderControl::Intensity)]
    fn fixture_configuration_adapt_read_should_passthrough_unrelated_values(
        control: FixtureFaderControl,
    ) {
        let config = FixtureConfiguration::default();

        let result = config.adapt_read(&control, 1.0);

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
            .insert(FixtureFaderControl::Intensity, ChannelLimit { min, max });

        let result = config.adapt_write(&FixtureFaderControl::Intensity, input);

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
            .insert(FixtureFaderControl::Intensity, ChannelLimit { min, max });

        let result = config.adapt_read(&FixtureFaderControl::Intensity, input);

        assert_eq!(expected, result);
    }

    #[test_case(LTPPriority::Lowest, 0.5, LTPPriority::High, 1.0, 1.0)]
    #[test_case(LTPPriority::Normal, 0.5, LTPPriority::Low, 1.0, 0.5)]
    #[test_case(LTPPriority::Low, 1.25, LTPPriority::High, 0.75, 0.75)]
    fn channel_value_should_return_value_with_highest_priority(
        level_a: LTPPriority,
        value_a: f64,
        level_b: LTPPriority,
        value_b: f64,
        expected: f64,
    ) {
        let mut channel_values = super::ChannelValues::default();
        channel_values.insert(
            value_a,
            level_a.into(),
            Default::default(),
            Default::default(),
        );
        channel_values.insert(
            value_b,
            level_b.into(),
            Default::default(),
            Default::default(),
        );
        channel_values.flush();

        let result = channel_values.get();

        assert_eq!(expected, result.unwrap());
    }

    #[test_case(0.5, 1.0, 1.0)]
    #[test_case(1.0, 0.5, 1.0)]
    fn channel_value_should_return_highest_value_when_htp_is_used(
        value_ltp: f64,
        value_htp: f64,
        expected: f64,
    ) {
        let mut channel_values = super::ChannelValues::default();
        channel_values.insert(
            value_ltp,
            LTPPriority::Low.into(),
            Default::default(),
            Default::default(),
        );
        channel_values.insert(
            value_htp,
            FixturePriority::HTP,
            Default::default(),
            Default::default(),
        );
        channel_values.flush();

        let result = channel_values.get();

        assert_eq!(expected, result.unwrap());
    }
}
