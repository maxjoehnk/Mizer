use itertools::Itertools;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

use mizer_protocol_dmx::DmxOutput;

use crate::color_mixer::{update_color_mixer, ColorMixer};
use crate::definition::*;
pub use crate::sub_fixture::*;

const U24_MAX: u32 = 16_777_215;

#[derive(Debug, Clone)]
pub struct Fixture {
    pub id: u32,
    pub name: String,
    pub definition: FixtureDefinition,
    pub current_mode: FixtureMode,
    pub universe: u16,
    pub channel: u16,
    pub output: Option<String>,
    pub submaster: Option<f64>,
    pub configuration: FixtureConfiguration,
    fixture_values: HashMap<FixtureFaderControl, f64>,
    pub(crate) sub_fixture_values: HashMap<(u32, FixtureFaderControl), f64>,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct FixtureConfiguration {
    pub invert_pan: bool,
    pub invert_tilt: bool,
}

impl Default for FixtureConfiguration {
    fn default() -> Self {
        Self {
            invert_pan: false,
            invert_tilt: false,
        }
    }
}

impl FixtureConfiguration {
    pub(crate) fn adapt(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        match control {
            FixtureFaderControl::Pan if self.invert_pan => (1. - value).abs(),
            FixtureFaderControl::Tilt if self.invert_tilt => (1. - value).abs(),
            _ => value,
        }
    }
}

impl Fixture {
    pub fn new(
        fixture_id: u32,
        name: String,
        definition: FixtureDefinition,
        selected_mode: Option<String>,
        output: Option<String>,
        channel: u16,
        universe: Option<u16>,
        configuration: FixtureConfiguration,
    ) -> Self {
        let mode = get_current_mode(&definition, selected_mode);
        Fixture {
            id: fixture_id,
            name,
            submaster: mode.controls.intensity.is_some().then(|| 1f64),
            current_mode: mode,
            definition,
            channel,
            output,
            universe: universe.unwrap_or(1),
            configuration,
            fixture_values: Default::default(),
            sub_fixture_values: Default::default(),
        }
    }

    pub fn get_channels(&self) -> Vec<FixtureChannelDefinition> {
        self.current_mode.channels.clone()
    }

    pub fn sub_fixture(&self, id: u32) -> Option<SubFixture> {
        self.current_mode
            .sub_fixtures
            .iter()
            .find(|f| f.id == id)
            .map(move |definition| SubFixture {
                fixture: self,
                definition,
            })
    }

    pub fn sub_fixture_mut(&mut self, id: u32) -> Option<SubFixtureMut> {
        self.current_mode
            .sub_fixtures
            .iter()
            .find(|f| f.id == id)
            .cloned()
            .map(move |definition| SubFixtureMut {
                fixture: self,
                definition,
            })
    }

    pub(crate) fn set_to_default(&mut self) {
        self.fixture_values.clear();
        self.sub_fixture_values.clear();
        // for channel in self.current_mode.channels.iter() {
        //     self.channel_values.insert(channel.name.clone(), 0f64);
        // }
        // if let Some(mixer) = self.current_mode.color_mixer.as_mut() {
        //     if mixer.virtual_dimmer().is_some() {
        //         mixer.set_virtual_dimmer(0f64);
        //     }
        // }
        // for sub_fixture in self.current_mode.sub_fixtures.iter_mut() {
        //     if let Some(mixer) = sub_fixture.color_mixer.as_mut() {
        //         if mixer.virtual_dimmer().is_some() {
        //             mixer.set_virtual_dimmer(0f64);
        //         }
        //     }
        // }
    }

    pub(crate) fn flush(&self, output: &dyn DmxOutput) {
        profiling::scope!("Fixture::flush");
        let buffer = self.get_dmx_values();
        let start = self.channel as usize;
        let end = start + self.current_mode.dmx_channels() as usize;
        output.write_bulk(self.universe, self.channel, &buffer[start..end]);
    }

    pub fn get_dmx_values(&self) -> [u8; 512] {
        profiling::scope!("Fixture::get_dmx_values");
        let channel_values = self.build_channel_values();

        let mut buffer = [0; 512];

        for (channel_name, value) in channel_values.iter() {
            if let Some(channel) = self
                .current_mode
                .channels
                .iter()
                .find(|channel| &channel.name == channel_name)
            {
                let base_channel = self.channel as usize;
                match channel.resolution {
                    ChannelResolution::Coarse(coarse) => {
                        let channel = base_channel + coarse as usize;
                        buffer[channel] = convert_value(*value);
                    }
                    ChannelResolution::Fine(coarse, fine) => {
                        let value = convert_value_16bit(*value);
                        let coarse_value = (value >> 8) & 0xff;
                        let fine_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse as usize;
                        let fine_channel = base_channel + fine as usize;
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                    }
                    ChannelResolution::Finest(coarse, fine, finest) => {
                        let value = convert_value_24bit(*value);
                        let coarse_value = (value >> 16) & 0xff;
                        let fine_value = (value >> 8) & 0xff;
                        let finest_value = (value >> 0) & 0xff;
                        let coarse_channel = base_channel + coarse as usize;
                        let fine_channel = base_channel + fine as usize;
                        let finest_channel = base_channel + finest as usize;
                        buffer[coarse_channel] = coarse_value as u8;
                        buffer[fine_channel] = fine_value as u8;
                        buffer[finest_channel] = finest_value as u8;
                    }
                }
            }
        }

        buffer
    }

    pub fn write_submaster(&mut self, value: f64) {
        if let Some(submaster) = self.submaster.as_mut() {
            *submaster = value;
        }
    }

    pub(crate) fn adapt_to_submaster(&self, control: &FixtureFaderControl, value: f64) -> f64 {
        if let Some(submaster) = self.submaster {
            if control == &FixtureFaderControl::Intensity {
                value.min(submaster)
            } else {
                value
            }
        } else {
            value
        }
    }

    fn build_channel_values(&self) -> HashMap<String, f64> {
        let mut channel_values = HashMap::new();
        let mut color_mixer = self.current_mode.color_mixer.clone();

        for (control, value) in self.fixture_values.iter() {
            self.build_fixture_fader_value(
                control,
                *value,
                &mut channel_values,
                color_mixer.as_mut(),
            );
        }

        for (id, controls) in &self
            .sub_fixture_values
            .iter()
            .sorted_by_key(|((id, _), _)| *id)
            .group_by(|((id, _), _)| *id)
        {
            if let Some(definition) = self.current_mode.sub_fixtures.iter().find(|f| f.id == id) {
                let mut color_mixer = definition.color_mixer.clone();
                for ((_, control), value) in controls {
                    self.build_sub_fixture_fader_value(
                        definition,
                        control,
                        *value,
                        &mut channel_values,
                        color_mixer.as_mut(),
                    );
                }
            }
        }

        channel_values
    }

    fn build_fixture_fader_value(
        &self,
        control: &FixtureFaderControl,
        value: f64,
        channel_values: &mut HashMap<String, f64>,
        mut color_mixer: Option<&mut ColorMixer>,
    ) {
        profiling::scope!("Fixture::build_fixture_fader_value");
        let value = self.configuration.adapt(&control, value);
        let value = self.adapt_to_submaster(&control, value);
        match self.current_mode.controls.get_channel(&control) {
            Some(FixtureControlChannel::Channel(ref channel)) => {
                if let FixtureFaderControl::ColorMixer(color_channel) = control {
                    if let Some(color_mixer) = color_mixer.as_mut() {
                        match color_channel {
                            ColorChannel::Red => color_mixer.set_red(value),
                            ColorChannel::Green => color_mixer.set_green(value),
                            ColorChannel::Blue => color_mixer.set_blue(value),
                        }
                    }
                    update_color_mixer(
                        color_mixer.cloned(),
                        self.current_mode.controls.color_mixer.clone(),
                        |channel, value| {
                            channel_values.insert(channel, value);
                        },
                    );
                } else {
                    let channel = channel.to_string();
                    channel_values.insert(channel, value);
                }
            }
            Some(FixtureControlChannel::Delegate) => {
                // Noop because handled while writing the control value
            }
            Some(FixtureControlChannel::VirtualDimmer) => {
                debug_assert!(
                    control == &FixtureFaderControl::Intensity,
                    "Trying to write non intensity channel to virtual dimmer"
                );
                if let Some(color_mixer) = color_mixer.as_mut() {
                    color_mixer.set_virtual_dimmer(value);
                }
                update_color_mixer(
                    color_mixer.cloned(),
                    self.current_mode.controls.color_mixer.clone(),
                    |channel, value| {
                        channel_values.insert(channel, value);
                    },
                );
            }
            None => {}
        }
    }

    fn build_sub_fixture_fader_value(
        &self,
        definition: &SubFixtureDefinition,
        control: &FixtureFaderControl,
        value: f64,
        channel_values: &mut HashMap<String, f64>,
        mut color_mixer: Option<&mut ColorMixer>,
    ) {
        if let Some(channel) = definition.controls.get_channel(&control) {
            match channel {
                SubFixtureControlChannel::Channel(channel) => {
                    if let FixtureFaderControl::ColorMixer(color_channel) = control {
                        if let Some(color_mixer) = color_mixer.as_mut() {
                            match color_channel {
                                ColorChannel::Red => color_mixer.set_red(value),
                                ColorChannel::Green => color_mixer.set_green(value),
                                ColorChannel::Blue => color_mixer.set_blue(value),
                            }
                        }
                        update_color_mixer(
                            color_mixer.cloned(),
                            definition.controls.color_mixer.clone(),
                            |channel, value| {
                                channel_values.insert(channel, value);
                            },
                        );
                    } else {
                        channel_values.insert(channel.clone(), value);
                    }
                }
                SubFixtureControlChannel::VirtualDimmer => {
                    debug_assert!(
                        control == &FixtureFaderControl::Intensity,
                        "Trying to write non intensity channel to virtual dimmer"
                    );
                    if let Some(color_mixer) = color_mixer.as_mut() {
                        color_mixer.set_virtual_dimmer(value);
                    }
                    update_color_mixer(
                        color_mixer.cloned(),
                        definition.controls.color_mixer.clone(),
                        |channel, value| {
                            channel_values.insert(channel, value);
                        },
                    );
                }
            }
        }
    }
}

impl IFixtureMut for Fixture {
    fn write_fader_control(&mut self, control: FixtureFaderControl, value: f64) {
        profiling::scope!("Fixture::write_fader_control");
        if let Some(FixtureControlChannel::Delegate) =
            self.current_mode.controls.get_channel(&control)
        {
            let sub_fixtures = self.current_mode.sub_fixtures.clone();
            for definition in sub_fixtures.into_iter() {
                let mut sub_fixture = SubFixtureMut {
                    fixture: self,
                    definition,
                };
                sub_fixture.write_fader_control(control.clone(), value);
            }
        } else {
            self.fixture_values.insert(control, value);
        }
    }
}

impl IFixture for Fixture {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("Fixture::read_control");
        self.fixture_values.get(&control).copied()
    }
}

pub trait IChannelType {
    fn into_channel(self) -> Option<String>;
}

pub trait IFixture {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64>;
}

pub trait IFixtureMut: IFixture {
    fn write_fader_control(&mut self, control: FixtureFaderControl, value: f64);
    fn highlight(&mut self) {
        self.write_fader_control(FixtureFaderControl::Intensity, 1f64);
        self.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Red), 1f64);
        self.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Green), 1f64);
        self.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Blue), 1f64);
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
            FixtureFaderControl::ColorMixer(ColorChannel::Red) => {
                self.color_mixer.as_ref().map(|c| &c.red)
            }
            FixtureFaderControl::ColorMixer(ColorChannel::Green) => {
                self.color_mixer.as_ref().map(|c| &c.green)
            }
            FixtureFaderControl::ColorMixer(ColorChannel::Blue) => {
                self.color_mixer.as_ref().map(|c| &c.blue)
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
    use crate::definition::FixtureFaderControl;
    use crate::fixture::FixtureConfiguration;
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

    #[test_case(0., 1.)]
    #[test_case(1., 0.)]
    #[test_case(0.5, 0.5)]
    fn fixture_configuration_adapt_should_invert_pan(input: f64, expected: f64) {
        let config = FixtureConfiguration {
            invert_pan: true,
            ..Default::default()
        };

        let result = config.adapt(&FixtureFaderControl::Pan, input);

        assert_eq!(expected, result);
    }

    #[test_case(0., 1.)]
    #[test_case(1., 0.)]
    #[test_case(0.5, 0.5)]
    fn fixture_configuration_adapt_should_invert_tilt(input: f64, expected: f64) {
        let config = FixtureConfiguration {
            invert_tilt: true,
            ..Default::default()
        };

        let result = config.adapt(&FixtureFaderControl::Tilt, input);

        assert_eq!(expected, result);
    }

    #[test_case(FixtureFaderControl::Pan)]
    #[test_case(FixtureFaderControl::Tilt)]
    #[test_case(FixtureFaderControl::Intensity)]
    fn fixture_configuration_adapt_should_passthrough_unrelated_values(
        control: FixtureFaderControl,
    ) {
        let config = FixtureConfiguration::default();

        let result = config.adapt(&control, 1.0);

        assert_eq!(1.0, result);
    }
}
