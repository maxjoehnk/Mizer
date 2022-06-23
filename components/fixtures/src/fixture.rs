use std::collections::HashMap;

use crate::color_mixer::{ColorMixer, Rgb};
use crate::definition::*;
use mizer_protocol_dmx::DmxOutput;

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
    /// Contains values for all dmx channels including sub-fixtures
    pub channel_values: HashMap<String, f64>,
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
    ) -> Self {
        Fixture {
            id: fixture_id,
            name,
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

    fn update_color_mixer(&mut self) {
        update_color_mixer(
            self.current_mode.color_mixer,
            self.current_mode.controls.color_mixer.clone(),
            |channel, value| self.write(channel, value),
        );
    }
}

impl IFixtureMut for Fixture {
    fn write_fader_control(&mut self, control: FixtureFaderControl, value: f64) {
        match self.current_mode.controls.get_channel(&control) {
            Some(FixtureControlChannel::Channel(ref channel)) => {
                if let FixtureFaderControl::ColorMixer(color_channel) = control {
                    if let Some(color_mixer) = self.current_mode.color_mixer.as_mut() {
                        match color_channel {
                            ColorChannel::Red => color_mixer.set_red(value),
                            ColorChannel::Green => color_mixer.set_green(value),
                            ColorChannel::Blue => color_mixer.set_blue(value),
                        }
                    }
                    self.update_color_mixer();
                } else {
                    let channel = channel.to_string();
                    self.write(channel, value)
                }
            }
            Some(FixtureControlChannel::Delegate) => {
                let sub_fixtures = self.current_mode.sub_fixtures.clone();
                for definition in sub_fixtures.into_iter() {
                    let mut fixture = SubFixtureMut {
                        fixture: self,
                        definition,
                    };
                    fixture.write_fader_control(control.clone(), value);
                }
            }
            Some(FixtureControlChannel::VirtualDimmer) => {
                debug_assert!(
                    control == FixtureFaderControl::Intensity,
                    "Trying to write non intensity channel to virtual dimmer"
                );
                if let Some(color_mixer) = self.current_mode.color_mixer.as_mut() {
                    color_mixer.set_virtual_dimmer(value);
                }
                self.update_color_mixer();
            }
            None => {}
        }
    }
}

impl IFixture for Fixture {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        match self.current_mode.controls.get_channel(&control) {
            Some(FixtureControlChannel::Channel(ref channel)) => {
                self.channel_values.get(channel).copied()
            }
            Some(FixtureControlChannel::VirtualDimmer) => self
                .current_mode
                .color_mixer
                .map(|mixer| mixer.virtual_dimmer()),
            _ => None,
        }
    }
}

#[derive(Debug)]
pub struct SubFixtureMut<'a> {
    fixture: &'a mut Fixture,
    definition: SubFixtureDefinition,
}

impl<'a> SubFixtureMut<'a> {
    fn update_color_mixer(&mut self) {
        update_color_mixer(
            self.color_mixer(),
            self.definition.controls.color_mixer.clone(),
            |channel, value| self.fixture.write(channel, value),
        );
    }

    fn color_mixer_mut(&mut self) -> Option<&mut ColorMixer> {
        let definition_id = self.definition.id;
        self.fixture
            .current_mode
            .sub_fixtures
            .iter_mut()
            .find(|s| s.id == definition_id)
            .and_then(|definition| definition.color_mixer.as_mut())
    }

    fn color_mixer(&self) -> Option<ColorMixer> {
        let definition_id = self.definition.id;
        self.fixture
            .current_mode
            .sub_fixtures
            .iter()
            .find(|s| s.id == definition_id)
            .and_then(|definition| definition.color_mixer)
    }
}

fn update_color_mixer<TChannel: IChannelType>(
    color_mixer: Option<ColorMixer>,
    color_group: Option<ColorGroup<TChannel>>,
    mut write: impl FnMut(String, f64),
) {
    debug_assert!(
        color_mixer.is_some(),
        "Trying to update non existent color mixer"
    );
    debug_assert!(
        color_group.is_some(),
        "Trying to update color mixer without color group"
    );
    if let Some(color_mixer) = color_mixer {
        if let Some(color_group) = color_group {
            let rgb = if let Some(white_channel) = color_group.white.and_then(|c| c.into_channel())
            {
                let value = color_mixer.rgbw();
                write(white_channel, value.white);

                Rgb {
                    red: value.red,
                    green: value.green,
                    blue: value.blue,
                }
            } else {
                color_mixer.rgb()
            };
            if let Some(channel) = color_group.red.into_channel() {
                write(channel, rgb.red);
            }
            if let Some(channel) = color_group.green.into_channel() {
                write(channel, rgb.green);
            }
            if let Some(channel) = color_group.blue.into_channel() {
                write(channel, rgb.blue);
            }
        }
    }
}

pub trait IChannelType {
    fn into_channel(self) -> Option<String>;
}

#[derive(Debug)]
pub struct SubFixture<'a> {
    fixture: &'a Fixture,
    definition: &'a SubFixtureDefinition,
}

impl<'a> IFixtureMut for SubFixtureMut<'a> {
    fn write_fader_control(&mut self, control: FixtureFaderControl, value: f64) {
        if let Some(channel) = self.definition.controls.get_channel(&control) {
            match channel {
                SubFixtureControlChannel::Channel(channel) => {
                    if let FixtureFaderControl::ColorMixer(color_channel) = control {
                        let color_mixer = self.color_mixer_mut();
                        if let Some(color_mixer) = color_mixer {
                            match color_channel {
                                ColorChannel::Red => color_mixer.set_red(value),
                                ColorChannel::Green => color_mixer.set_green(value),
                                ColorChannel::Blue => color_mixer.set_blue(value),
                            }
                        }
                        self.update_color_mixer();
                    } else {
                        self.fixture.write(channel, value)
                    }
                }
                SubFixtureControlChannel::VirtualDimmer => {
                    debug_assert!(
                        control == FixtureFaderControl::Intensity,
                        "Trying to write non intensity channel to virtual dimmer"
                    );
                    let color_mixer = self.color_mixer_mut();
                    if let Some(color_mixer) = color_mixer {
                        color_mixer.set_virtual_dimmer(value);
                    }
                    self.update_color_mixer();
                }
            }
        }
    }
}

impl<'a> IFixture for SubFixtureMut<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        read_control(&self.fixture.channel_values, &self.definition, control)
    }
}

impl<'a> IFixture for SubFixture<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        read_control(&self.fixture.channel_values, self.definition, control)
    }
}

fn read_control(
    channel_values: &HashMap<String, f64>,
    definition: &SubFixtureDefinition,
    control: FixtureFaderControl,
) -> Option<f64> {
    match definition.controls.get_channel(&control) {
        Some(SubFixtureControlChannel::Channel(ref channel)) => {
            channel_values.get(channel).copied()
        }
        Some(SubFixtureControlChannel::VirtualDimmer) => {
            definition.color_mixer.map(|mixer| mixer.virtual_dimmer())
        }
        _ => None,
    }
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
    fn get_channel<'a>(&'a self, control: &'a FixtureFaderControl) -> Option<&'a TChannel> {
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
