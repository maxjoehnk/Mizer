use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::hash::{Hash, Hasher};

use mizer_protocol_dmx::DmxOutput;

use crate::color_mixer::update_color_mixer;
use crate::definition::*;
pub use crate::sub_fixture::*;
use crate::WorldCoordinate;

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
    pub output: Option<String>,
    /// Contains values for all dmx channels including sub-fixtures
    pub channel_values: HashMap<String, f64>,
    pub configuration: FixtureConfiguration,
    pub placement: FixturePlacement,
    point_at: Option<WorldCoordinate>,
}

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct FixtureConfiguration {
    #[serde(default)]
    pub invert_pan: bool,
    #[serde(default)]
    pub invert_tilt: bool,
    #[serde(default)]
    pub reverse_pixel_order: bool,
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

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct FixturePlacement {
    pub x: f64,
    pub y: f64,
    pub z: f64,
    pub rotate_x: f64,
    pub rotate_y: f64,
    pub rotate_z: f64,
}

impl Hash for FixturePlacement {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.x.to_bits().hash(state);
        self.y.to_bits().hash(state);
        self.z.to_bits().hash(state);
        self.rotate_x.to_bits().hash(state);
        self.rotate_y.to_bits().hash(state);
        self.rotate_z.to_bits().hash(state);
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
        placement: FixturePlacement,
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
            configuration,
            placement,
            point_at: Default::default(),
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
        self.sub_fixture_definition(id)
            .map(move |definition| SubFixture {
                fixture: self,
                definition,
            })
    }

    pub fn sub_fixture_mut(&mut self, id: u32) -> Option<SubFixtureMut> {
        self.sub_fixture_definition(id)
            .cloned()
            .map(move |definition| SubFixtureMut {
                fixture: self,
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
        for channel in self.current_mode.channels.iter() {
            self.channel_values.insert(channel.name.clone(), 0f64);
        }
        self.point_at = Default::default();
        if let Some(mixer) = self.current_mode.color_mixer.as_mut() {
            if mixer.virtual_dimmer().is_some() {
                mixer.set_virtual_dimmer(0f64);
            }
        }
        for sub_fixture in self.current_mode.sub_fixtures.iter_mut() {
            if let Some(mixer) = sub_fixture.color_mixer.as_mut() {
                if mixer.virtual_dimmer().is_some() {
                    mixer.set_virtual_dimmer(0f64);
                }
            }
        }
    }

    pub(crate) fn flush(&self, output: &dyn DmxOutput) {
        profiling::scope!("Fixture::flush");
        let buffer = self.get_dmx_values();
        let start = self.channel as usize;
        let start = start.clamp(DMX_START_ADDRESS, DMX_END_ADDRESS);
        let end = start + self.current_mode.dmx_channels() as usize;
        let end = end.clamp(start, DMX_END_ADDRESS);
        output.write_bulk(self.universe, self.channel, &buffer[start..end]);
    }

    pub fn get_dmx_values(&self) -> [u8; DMX_END_ADDRESS] {
        profiling::scope!("Fixture::get_dmx_values");
        let mut buffer = [0; DMX_END_ADDRESS];

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
                        #[allow(clippy::identity_op)]
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
                        #[allow(clippy::identity_op)]
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

    fn update_point_at(&mut self) -> Option<()> {
        let point_at = self.point_at?;
        let (pan_control, tilt_control) = self
            .current_mode
            .controls
            .pan
            .as_ref()
            .zip(self.current_mode.controls.tilt.as_ref())?;
        let pan_angle = pan_control.angle.unwrap_or(Angle { from: 0., to: 360. });
        let tilt_angle = tilt_control.angle.unwrap_or(Angle { from: 0., to: 180. });
        let pan_channel = pan_control.channel.clone().into_channel()?;
        let tilt_channel = tilt_control.channel.clone().into_channel()?;
        let origin = (self.placement.x, self.placement.y, self.placement.z);
        let rotation = (
            self.placement.rotate_x,
            self.placement.rotate_y,
            self.placement.rotate_z,
        );
        let target = (point_at.x, point_at.y, point_at.z);

        let (pan, tilt) = calculate_pan_tilt(origin, rotation, target, pan_angle, tilt_angle);

        self.write(pan_channel, pan);
        self.write(tilt_channel, tilt);

        Some(())
    }
}

fn calculate_pan_tilt(
    origin: (f64, f64, f64),
    rotation: (f64, f64, f64),
    target: (f64, f64, f64),
    pan_angle: Angle,
    tilt_angle: Angle,
) -> (f64, f64) {
    let (x, y, z) = target;
    let (x, y, z) = (x - origin.0, y - origin.1, z - origin.2);
    let pan = (x.atan2(y).to_degrees() + 360.) % 360.;
    let tilt = (z.atan2((x * x + y * y).sqrt()).to_degrees() + 360.) % 360.;
    let pan = pan_angle.from + (pan_angle.to - pan_angle.from) * pan / 360.;
    let tilt = tilt_angle.from + (tilt_angle.to - tilt_angle.from) * tilt / 360.;
    (pan, tilt)
}

impl IFixtureMut for Fixture {
    fn write_fader_control(&mut self, control: FixtureFaderControl, value: f64) {
        profiling::scope!("Fixture::write_fader_control");
        let value = self.configuration.adapt(&control, value);
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
            None => {
                if let FixtureFaderControl::PointAt(axis) = control {
                    if self.point_at.is_none() {
                        self.point_at = Some(Default::default());
                    }
                    let point_at = self.point_at.as_mut().unwrap();
                    match axis {
                        WorldAxis::X => point_at.x = value,
                        WorldAxis::Y => point_at.y = value,
                        WorldAxis::Z => point_at.z = value,
                    }
                    self.update_point_at();
                }
            }
        }
    }
}

impl IFixture for Fixture {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("Fixture::read_control");
        if let FixtureFaderControl::ColorMixer(channel) = control {
            let color_mixer = self.current_mode.color_mixer?;
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
                .copied()
                .map(|value| self.configuration.adapt(&control, value)),
            Some(FixtureControlChannel::VirtualDimmer) => self
                .current_mode
                .color_mixer
                .and_then(|mixer| mixer.virtual_dimmer()),
            _ => None,
        }
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
            FixtureFaderControl::PointAt(WorldAxis::X) => None,
            FixtureFaderControl::PointAt(WorldAxis::Y) => None,
            FixtureFaderControl::PointAt(WorldAxis::Z) => None,
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
