use std::collections::HashMap;

use serde::{Deserialize, Serialize};

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

    pub fn write(&mut self, name: &str, value: f64) {
        log::trace!("write {} -> {}", name, value);
        self.channel_values.insert(name.to_string(), value);
    }

    pub fn write_control(&mut self, control: FixtureControl, value: f64) {
        match control {
            FixtureControl::Intensity => if let Some(channel) = self.current_mode.controls.intensity.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Shutter => if let Some(channel) = self.current_mode.controls.shutter.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Zoom => if let Some(channel) = self.current_mode.controls.zoom.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Focus => if let Some(channel) = self.current_mode.controls.focus.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Iris => if let Some(channel) = self.current_mode.controls.iris.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Prism => if let Some(channel) = self.current_mode.controls.prism.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Frost => if let Some(channel) = self.current_mode.controls.frost.clone() {
                self.write(&channel, value)
            }
            FixtureControl::Color(ColorChannel::Red) => if let Some(color_group) = self.current_mode.controls.color.clone() {
                self.write(&color_group.red, value);
            }
            FixtureControl::Color(ColorChannel::Green) => if let Some(color_group) = self.current_mode.controls.color.clone() {
                self.write(&color_group.green, value);
            }
            FixtureControl::Color(ColorChannel::Blue) => if let Some(color_group) = self.current_mode.controls.color.clone() {
                self.write(&color_group.blue, value);
            }
            FixtureControl::Pan => if let Some(axis) = self.current_mode.controls.pan.clone() {
                self.write(&axis.channel, value)
            }
            FixtureControl::Tilt => if let Some(axis) = self.current_mode.controls.tilt.clone() {
                self.write(&axis.channel, value)
            }
            FixtureControl::Generic(channel) => self.write(&channel, value),
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

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureDefinition {
    pub id: String,
    pub name: String,
    pub manufacturer: String,
    pub modes: Vec<FixtureMode>,
    pub physical: PhysicalFixtureData,
    pub tags: Vec<String>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureMode {
    pub name: String,
    pub channels: Vec<FixtureChannelDefinition>,
    pub controls: FixtureControls,
    pub groups: Vec<FixtureChannelGroup>,
}

#[derive(Debug, Clone, PartialEq, Default)]
pub struct FixtureControls {
    pub intensity: Option<String>,
    pub shutter: Option<String>,
    pub color: Option<ColorGroup>,
    pub pan: Option<AxisGroup>,
    pub tilt: Option<AxisGroup>,
    pub focus: Option<String>,
    pub zoom: Option<String>,
    pub prism: Option<String>,
    pub iris: Option<String>,
    pub frost: Option<String>,
    pub generic: Vec<GenericControl>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelGroup {
    pub name: String,
    pub group_type: FixtureChannelGroupType,
}

#[derive(Debug, Clone, PartialEq)]
pub enum FixtureChannelGroupType {
    Generic(String),
    Color(ColorGroup),
    Pan(AxisGroup),
    Tilt(AxisGroup),
    Focus(String),
    Zoom(String),
    Prism(String),
    Intensity(String),
    Shutter(String),
    Iris(String),
    Frost(String),
}

#[derive(Debug, Clone, PartialEq)]
pub struct ColorGroup {
    pub red: String,
    pub green: String,
    pub blue: String,
}

#[derive(Debug, Clone, PartialEq)]
pub struct AxisGroup {
    pub channel: String,
    pub angle: Option<Angle>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Angle {
    pub from: f32,
    pub to: f32,
}

#[derive(Debug, Clone, PartialEq)]
pub struct GenericControl {
    pub label: String,
    pub channel: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum FixtureControl {
    Intensity,
    Shutter,
    Color(ColorChannel),
    Pan,
    Tilt,
    Focus,
    Zoom,
    Prism,
    Iris,
    Frost,
    Generic(String),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum ColorChannel {
    Red,
    Green,
    Blue
}

impl FixtureMode {
    fn dmx_channels(&self) -> u8 {
        self.channels.iter().map(|c| c.channels()).sum()
    }

    pub fn intensity(&self) -> Option<FixtureChannelDefinition> {
        self.controls
            .intensity
            .as_ref()
            .and_then(|channel| self.channels.iter().find(|c| &c.name == channel).cloned())
    }

    pub fn color(&self) -> Option<ColorGroup> {
        self.controls.color.clone()
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelDefinition {
    pub name: String,
    pub resolution: ChannelResolution,
}

impl FixtureChannelDefinition {
    fn channels(&self) -> u8 {
        match self.resolution {
            ChannelResolution::Coarse { .. } => 1,
            ChannelResolution::Fine { .. } => 2,
            ChannelResolution::Finest { .. } => 3,
        }
    }
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

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct PhysicalFixtureData {
    pub dimensions: Option<FixtureDimensions>,
    pub weight: Option<f32>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct FixtureDimensions {
    pub width: f32,
    pub height: f32,
    pub depth: f32,
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
