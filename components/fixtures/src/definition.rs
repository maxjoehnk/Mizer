use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureDefinition {
    pub id: String,
    pub name: String,
    pub manufacturer: String,
    pub modes: Vec<FixtureMode>,
    pub physical: PhysicalFixtureData,
    pub tags: Vec<String>,
}

impl FixtureDefinition {
    pub fn get_mode(&self, name: &str) -> Option<&FixtureMode> {
        self.modes.iter().find(|mode| mode.name == name)
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct SubFixtureDefinition {
    pub id: u32,
    pub name: String,
    pub controls: FixtureControls<String>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureMode {
    pub name: String,
    pub channels: Vec<FixtureChannelDefinition>,
    pub controls: FixtureControls<FixtureControlChannel>,
    pub sub_fixtures: Vec<SubFixtureDefinition>,
}

impl FixtureMode {
    pub fn dmx_channels(&self) -> u8 {
        self.channels.iter().map(|c| c.channels()).sum()
    }

    pub fn intensity(&self) -> Option<FixtureChannelDefinition> {
        self.controls
            .intensity
            .as_ref()
            .and_then(|c| {
                if let FixtureControlChannel::Channel(channel) = c {
                    Some(channel)
                } else {
                    None
                }
            })
            .and_then(|channel| self.channels.iter().find(|c| &c.name == channel).cloned())
    }

    pub fn color(&self) -> Option<ColorGroup<FixtureControlChannel>> {
        self.controls.color.clone()
    }
}

#[derive(Debug, Clone, PartialEq, Default)]
pub struct FixtureControls<TChannel> {
    pub intensity: Option<TChannel>,
    pub shutter: Option<TChannel>,
    pub color: Option<ColorGroup<TChannel>>,
    pub pan: Option<AxisGroup<TChannel>>,
    pub tilt: Option<AxisGroup<TChannel>>,
    pub focus: Option<TChannel>,
    pub zoom: Option<TChannel>,
    pub prism: Option<TChannel>,
    pub iris: Option<TChannel>,
    pub frost: Option<TChannel>,
    pub generic: Vec<GenericControl<TChannel>>,
}

impl From<FixtureControls<String>> for FixtureControls<FixtureControlChannel> {
    fn from(controls: FixtureControls<String>) -> Self {
        Self {
            intensity: controls.intensity.map(FixtureControlChannel::Channel),
            shutter: controls.shutter.map(FixtureControlChannel::Channel),
            color: controls.color.map(|color| ColorGroup {
                red: FixtureControlChannel::Channel(color.red),
                green: FixtureControlChannel::Channel(color.green),
                blue: FixtureControlChannel::Channel(color.blue),
            }),
            pan: controls.pan.map(|axis| AxisGroup {
                channel: FixtureControlChannel::Channel(axis.channel),
                angle: axis.angle,
            }),
            tilt: controls.tilt.map(|axis| AxisGroup {
                channel: FixtureControlChannel::Channel(axis.channel),
                angle: axis.angle,
            }),
            focus: controls.focus.map(FixtureControlChannel::Channel),
            zoom: controls.zoom.map(FixtureControlChannel::Channel),
            prism: controls.prism.map(FixtureControlChannel::Channel),
            iris: controls.iris.map(FixtureControlChannel::Channel),
            frost: controls.frost.map(FixtureControlChannel::Channel),
            generic: controls
                .generic
                .into_iter()
                .map(|generic| GenericControl {
                    channel: FixtureControlChannel::Channel(generic.channel),
                    label: generic.label,
                })
                .collect(),
        }
    }
}

impl From<FixtureControls<FixtureControlChannel>> for FixtureControls<String> {
    fn from(controls: FixtureControls<FixtureControlChannel>) -> Self {
        Self {
            intensity: controls
                .intensity
                .and_then(FixtureControlChannel::to_channel),
            shutter: controls.shutter.and_then(FixtureControlChannel::to_channel),
            color: controls.color.and_then(|color| {
                if let (
                    FixtureControlChannel::Channel(red),
                    FixtureControlChannel::Channel(green),
                    FixtureControlChannel::Channel(blue),
                ) = (color.red, color.green, color.blue)
                {
                    Some(ColorGroup { red, green, blue })
                } else {
                    None
                }
            }),
            pan: controls.pan.and_then(|axis| {
                if let FixtureControlChannel::Channel(channel) = axis.channel {
                    Some(AxisGroup {
                        channel,
                        angle: axis.angle,
                    })
                } else {
                    None
                }
            }),
            tilt: controls.tilt.and_then(|axis| {
                if let FixtureControlChannel::Channel(channel) = axis.channel {
                    Some(AxisGroup {
                        channel,
                        angle: axis.angle,
                    })
                } else {
                    None
                }
            }),
            focus: controls.focus.and_then(FixtureControlChannel::to_channel),
            zoom: controls.zoom.and_then(FixtureControlChannel::to_channel),
            prism: controls.prism.and_then(FixtureControlChannel::to_channel),
            iris: controls.iris.and_then(FixtureControlChannel::to_channel),
            frost: controls.frost.and_then(FixtureControlChannel::to_channel),
            generic: controls
                .generic
                .into_iter()
                .filter_map(|generic| {
                    if let FixtureControlChannel::Channel(channel) = generic.channel {
                        Some(GenericControl {
                            channel,
                            label: generic.label,
                        })
                    } else {
                        None
                    }
                })
                .collect(),
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum FixtureControlChannel {
    /// Fixture control maps to one dmx channel
    Channel(String),
    /// Delegate this channel to sub fixtures
    Delegate,
}

impl FixtureControlChannel {
    fn to_channel(self) -> Option<String> {
        if let FixtureControlChannel::Channel(channel) = self {
            Some(channel)
        } else {
            None
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct ColorGroup<TChannel> {
    pub red: TChannel,
    pub green: TChannel,
    pub blue: TChannel,
}

#[derive(Debug, Clone, PartialEq)]
pub struct AxisGroup<TChannel> {
    pub channel: TChannel,
    pub angle: Option<Angle>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Angle {
    pub from: f32,
    pub to: f32,
}

#[derive(Debug, Clone, PartialEq)]
pub struct GenericControl<TChannel> {
    pub label: String,
    pub channel: TChannel,
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
    Blue,
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
