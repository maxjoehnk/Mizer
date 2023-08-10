use std::convert::TryFrom;
use std::hash::{Hash, Hasher};
use std::str::FromStr;

use serde::{Deserialize, Serialize};

use crate::color_mixer::ColorMixer;
use crate::fixture::IChannelType;

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureDefinition {
    pub id: String,
    pub name: String,
    pub manufacturer: String,
    pub modes: Vec<FixtureMode>,
    pub physical: PhysicalFixtureData,
    pub tags: Vec<String>,
    pub provider: &'static str,
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
    pub controls: FixtureControls<SubFixtureControlChannel>,
    pub(crate) color_mixer: Option<ColorMixer>,
}

impl SubFixtureDefinition {
    pub fn new(
        id: u32,
        name: String,
        mut controls: FixtureControls<SubFixtureControlChannel>,
    ) -> Self {
        if controls.intensity.is_none() && controls.color_mixer.is_some() {
            controls.intensity = Some(SubFixtureControlChannel::VirtualDimmer);
        }
        let virtual_dimmer = matches!(
            controls.intensity,
            Some(SubFixtureControlChannel::VirtualDimmer)
        );
        let color_mixer = controls
            .color_mixer
            .as_ref()
            .map(|_| ColorMixer::new(virtual_dimmer));

        Self {
            id,
            name,
            controls,
            color_mixer,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureMode {
    pub name: String,
    pub channels: Vec<FixtureChannelDefinition>,
    pub controls: FixtureControls<FixtureControlChannel>,
    pub sub_fixtures: Vec<SubFixtureDefinition>,
    pub(crate) color_mixer: Option<ColorMixer>,
}

impl FixtureMode {
    pub fn new(
        name: String,
        channels: Vec<FixtureChannelDefinition>,
        mut controls: FixtureControls<FixtureControlChannel>,
        sub_fixtures: Vec<SubFixtureDefinition>,
    ) -> Self {
        if controls.intensity.is_none() && controls.color_mixer.is_some() {
            controls.intensity = Some(FixtureControlChannel::VirtualDimmer);
        }
        let virtual_dimmer = matches!(
            controls.intensity,
            Some(FixtureControlChannel::VirtualDimmer)
        );
        let color_mixer = controls
            .color_mixer
            .as_ref()
            .map(|_| ColorMixer::new(virtual_dimmer));

        if sub_fixtures
            .iter()
            .any(|f| f.controls.color_mixer.is_some())
            && controls.color_mixer.is_none()
        {
            controls.color_mixer = Some(ColorGroup::Rgb {
                red: FixtureControlChannel::Delegate,
                green: FixtureControlChannel::Delegate,
                blue: FixtureControlChannel::Delegate,
                amber: None,
                white: None,
            });
        }
        if sub_fixtures.iter().any(|f| f.controls.intensity.is_some())
            && controls.intensity.is_none()
        {
            controls.intensity = Some(FixtureControlChannel::Delegate);
        }

        Self {
            name,
            channels,
            controls,
            sub_fixtures,
            color_mixer,
        }
    }

    pub fn dmx_channels(&self) -> u16 {
        self.channels.iter().map(|c| c.channels() as u16).sum()
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
        self.controls.color_mixer.clone()
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureControls<TChannel> {
    pub intensity: Option<TChannel>,
    pub shutter: Option<TChannel>,
    pub color_mixer: Option<ColorGroup<TChannel>>,
    pub color_wheel: Option<ColorWheelGroup<TChannel>>,
    pub pan: Option<AxisGroup<TChannel>>,
    pub tilt: Option<AxisGroup<TChannel>>,
    pub gobo: Option<GoboGroup<TChannel>>,
    pub focus: Option<TChannel>,
    pub zoom: Option<TChannel>,
    pub prism: Option<TChannel>,
    pub iris: Option<TChannel>,
    pub frost: Option<TChannel>,
    pub generic: Vec<GenericControl<TChannel>>,
}

impl<TChannel> Default for FixtureControls<TChannel> {
    fn default() -> Self {
        Self {
            intensity: None,
            shutter: None,
            color_mixer: None,
            color_wheel: None,
            pan: None,
            tilt: None,
            focus: None,
            zoom: None,
            prism: None,
            iris: None,
            frost: None,
            gobo: None,
            generic: Vec::default(),
        }
    }
}

impl From<FixtureControls<String>> for FixtureControls<FixtureControlChannel> {
    fn from(controls: FixtureControls<String>) -> Self {
        Self {
            intensity: controls.intensity.map(FixtureControlChannel::Channel),
            shutter: controls.shutter.map(FixtureControlChannel::Channel),
            color_mixer: controls.color_mixer.map(|color| match color {
                ColorGroup::Rgb {
                    red,
                    green,
                    blue,
                    white,
                    amber,
                } => ColorGroup::Rgb {
                    red: FixtureControlChannel::Channel(red),
                    green: FixtureControlChannel::Channel(green),
                    blue: FixtureControlChannel::Channel(blue),
                    white: white.map(FixtureControlChannel::Channel),
                    amber: amber.map(FixtureControlChannel::Channel),
                },
                ColorGroup::Cmy {
                    cyan,
                    magenta,
                    yellow,
                } => ColorGroup::Cmy {
                    cyan: FixtureControlChannel::Channel(cyan),
                    magenta: FixtureControlChannel::Channel(magenta),
                    yellow: FixtureControlChannel::Channel(yellow),
                },
            }),
            color_wheel: controls.color_wheel.map(|wheel| ColorWheelGroup {
                channel: FixtureControlChannel::Channel(wheel.channel),
                colors: wheel.colors,
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
            gobo: controls.gobo.map(|gobo| GoboGroup {
                channel: FixtureControlChannel::Channel(gobo.channel),
                gobos: gobo.gobos,
            }),
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
                .and_then(FixtureControlChannel::into_channel),
            shutter: controls
                .shutter
                .and_then(FixtureControlChannel::into_channel),
            color_mixer: controls.color_mixer.and_then(|color| match color {
                ColorGroup::Rgb {
                    red,
                    green,
                    blue,
                    amber,
                    white,
                } => {
                    if let (
                        FixtureControlChannel::Channel(red),
                        FixtureControlChannel::Channel(green),
                        FixtureControlChannel::Channel(blue),
                    ) = (red, green, blue)
                    {
                        let amber = amber.and_then(|c| c.into_channel());
                        let white = white.and_then(|c| c.into_channel());

                        Some(ColorGroup::Rgb {
                            red,
                            green,
                            blue,
                            amber,
                            white,
                        })
                    } else {
                        None
                    }
                }
                ColorGroup::Cmy {
                    yellow,
                    magenta,
                    cyan,
                } => {
                    if let (
                        FixtureControlChannel::Channel(yellow),
                        FixtureControlChannel::Channel(magenta),
                        FixtureControlChannel::Channel(cyan),
                    ) = (yellow, magenta, cyan)
                    {
                        Some(ColorGroup::Cmy {
                            yellow,
                            magenta,
                            cyan,
                        })
                    } else {
                        None
                    }
                }
            }),
            color_wheel: controls.color_wheel.and_then(|color_wheel| {
                if let FixtureControlChannel::Channel(channel) = color_wheel.channel {
                    Some(ColorWheelGroup {
                        channel,
                        colors: color_wheel.colors,
                    })
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
            focus: controls.focus.and_then(FixtureControlChannel::into_channel),
            zoom: controls.zoom.and_then(FixtureControlChannel::into_channel),
            prism: controls.prism.and_then(FixtureControlChannel::into_channel),
            iris: controls.iris.and_then(FixtureControlChannel::into_channel),
            frost: controls.frost.and_then(FixtureControlChannel::into_channel),
            gobo: controls.gobo.and_then(|gobo| {
                if let FixtureControlChannel::Channel(channel) = gobo.channel {
                    Some(GoboGroup {
                        channel,
                        gobos: gobo.gobos,
                    })
                } else {
                    None
                }
            }),
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

impl From<FixtureControls<String>> for FixtureControls<SubFixtureControlChannel> {
    fn from(controls: FixtureControls<String>) -> Self {
        Self {
            intensity: controls.intensity.map(SubFixtureControlChannel::Channel),
            shutter: controls.shutter.map(SubFixtureControlChannel::Channel),
            color_mixer: controls.color_mixer.map(|color| match color {
                ColorGroup::Rgb {
                    red,
                    green,
                    blue,
                    white,
                    amber,
                } => ColorGroup::Rgb {
                    red: SubFixtureControlChannel::Channel(red),
                    green: SubFixtureControlChannel::Channel(green),
                    blue: SubFixtureControlChannel::Channel(blue),
                    white: white.map(SubFixtureControlChannel::Channel),
                    amber: amber.map(SubFixtureControlChannel::Channel),
                },
                ColorGroup::Cmy {
                    yellow,
                    magenta,
                    cyan,
                } => ColorGroup::Cmy {
                    yellow: SubFixtureControlChannel::Channel(yellow),
                    magenta: SubFixtureControlChannel::Channel(magenta),
                    cyan: SubFixtureControlChannel::Channel(cyan),
                },
            }),
            color_wheel: controls.color_wheel.map(|wheel| ColorWheelGroup {
                channel: SubFixtureControlChannel::Channel(wheel.channel),
                colors: wheel.colors,
            }),
            pan: controls.pan.map(|axis| AxisGroup {
                channel: SubFixtureControlChannel::Channel(axis.channel),
                angle: axis.angle,
            }),
            tilt: controls.tilt.map(|axis| AxisGroup {
                channel: SubFixtureControlChannel::Channel(axis.channel),
                angle: axis.angle,
            }),
            focus: controls.focus.map(SubFixtureControlChannel::Channel),
            zoom: controls.zoom.map(SubFixtureControlChannel::Channel),
            prism: controls.prism.map(SubFixtureControlChannel::Channel),
            iris: controls.iris.map(SubFixtureControlChannel::Channel),
            frost: controls.frost.map(SubFixtureControlChannel::Channel),
            gobo: controls.gobo.map(|gobo| GoboGroup {
                channel: SubFixtureControlChannel::Channel(gobo.channel),
                gobos: gobo.gobos,
            }),
            generic: controls
                .generic
                .into_iter()
                .map(|generic| GenericControl {
                    channel: SubFixtureControlChannel::Channel(generic.channel),
                    label: generic.label,
                })
                .collect(),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum FixtureControlType {
    Fader,
    Color,
}

impl<TChannel> FixtureControls<TChannel> {
    pub fn controls(&self) -> Vec<(FixtureControl, FixtureControlType)> {
        let mut controls = Vec::new();
        if self.intensity.is_some() {
            controls.push((FixtureControl::Intensity, FixtureControlType::Fader));
        }
        if self.shutter.is_some() {
            controls.push((FixtureControl::Shutter, FixtureControlType::Fader));
        }
        if self.iris.is_some() {
            controls.push((FixtureControl::Iris, FixtureControlType::Fader));
        }
        if self.zoom.is_some() {
            controls.push((FixtureControl::Zoom, FixtureControlType::Fader));
        }
        if self.frost.is_some() {
            controls.push((FixtureControl::Frost, FixtureControlType::Fader));
        }
        if self.prism.is_some() {
            controls.push((FixtureControl::Prism, FixtureControlType::Fader));
        }
        if self.focus.is_some() {
            controls.push((FixtureControl::Focus, FixtureControlType::Fader));
        }
        if self.pan.is_some() {
            controls.push((FixtureControl::Pan, FixtureControlType::Fader));
        }
        if self.tilt.is_some() {
            controls.push((FixtureControl::Tilt, FixtureControlType::Fader));
        }
        if self.color_mixer.is_some() {
            controls.push((FixtureControl::ColorMixer, FixtureControlType::Color));
        }
        if self.color_wheel.is_some() {
            controls.push((FixtureControl::ColorWheel, FixtureControlType::Fader));
        }
        for channel in &self.generic {
            controls.push((
                FixtureControl::Generic(channel.label.clone()),
                FixtureControlType::Fader,
            ));
        }

        controls
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum FixtureControlChannel {
    /// Fixture control maps to one dmx channel
    Channel(String),
    /// Delegate this channel to sub fixtures
    Delegate,
    /// Create virtual dimmer for fixtures with only a color channel
    VirtualDimmer,
}

impl IChannelType for FixtureControlChannel {
    fn into_channel(self) -> Option<String> {
        if let FixtureControlChannel::Channel(channel) = self {
            Some(channel)
        } else {
            None
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum SubFixtureControlChannel {
    /// Fixture control maps to one dmx channel
    Channel(String),
    /// Create virtual dimmer for fixtures with only a color channel
    VirtualDimmer,
}

impl IChannelType for SubFixtureControlChannel {
    fn into_channel(self) -> Option<String> {
        if let SubFixtureControlChannel::Channel(channel) = self {
            Some(channel)
        } else {
            None
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ColorGroup<TChannel> {
    Rgb {
        red: TChannel,
        green: TChannel,
        blue: TChannel,
        amber: Option<TChannel>,
        white: Option<TChannel>,
    },
    Cmy {
        cyan: TChannel,
        magenta: TChannel,
        yellow: TChannel,
    },
}

pub struct ColorGroupBuilder<TChannel> {
    red: Option<TChannel>,
    green: Option<TChannel>,
    blue: Option<TChannel>,
    amber: Option<TChannel>,
    white: Option<TChannel>,
    cyan: Option<TChannel>,
    magenta: Option<TChannel>,
    yellow: Option<TChannel>,
}

impl<TChannel> Default for ColorGroupBuilder<TChannel> {
    fn default() -> Self {
        Self {
            red: None,
            green: None,
            blue: None,
            amber: None,
            white: None,
            cyan: None,
            magenta: None,
            yellow: None,
        }
    }
}

impl<TChannel> ColorGroupBuilder<TChannel> {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn red(&mut self, channel: TChannel) {
        self.red = channel.into();
    }

    pub fn green(&mut self, channel: TChannel) {
        self.green = channel.into();
    }

    pub fn blue(&mut self, channel: TChannel) {
        self.blue = channel.into();
    }

    pub fn amber(&mut self, channel: TChannel) {
        self.amber = channel.into();
    }

    pub fn white(&mut self, channel: TChannel) {
        self.white = channel.into();
    }

    pub fn cyan(&mut self, channel: TChannel) {
        self.cyan = channel.into();
    }

    pub fn magenta(&mut self, channel: TChannel) {
        self.magenta = channel.into();
    }

    pub fn yellow(&mut self, channel: TChannel) {
        self.yellow = channel.into();
    }

    pub fn build(self) -> Option<ColorGroup<TChannel>> {
        let rgb = self.red.zip(self.green).zip(self.blue);
        let cmy = self.cyan.zip(self.magenta).zip(self.yellow);
        match (rgb, cmy) {
            (Some(((red, green), blue)), _) => ColorGroup::Rgb {
                red,
                green,
                blue,
                amber: self.amber,
                white: self.white,
            }
            .into(),
            (_, Some(((cyan, magenta), yellow))) => ColorGroup::Cmy {
                cyan,
                magenta,
                yellow,
            }
            .into(),
            _ => None,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct ColorWheelGroup<TChannel> {
    pub channel: TChannel,
    pub colors: Vec<ColorWheelSlot>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct ColorWheelSlot {
    pub value: f64,
    pub name: String,
    pub color: Vec<String>,
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
pub struct GoboGroup<TChannel> {
    pub channel: TChannel,
    pub gobos: Vec<Gobo>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Gobo {
    pub value: f64,
    pub name: String,
    pub image: Option<GoboImage>,
}

#[derive(Clone, PartialEq, Eq)]
pub enum GoboImage {
    Svg(String),
    Raster(Box<Vec<u8>>),
}

impl std::fmt::Debug for GoboImage {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match &self {
            Self::Raster(_) => f.debug_struct("Raster").finish(),
            Self::Svg(_) => f.debug_struct("SVG").finish(),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct GenericControl<TChannel> {
    pub label: String,
    pub channel: TChannel,
}

/// Describes a single fixture control
///
/// This may have multiple fader values
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash, Deserialize, Serialize)]
pub enum FixtureControl {
    Intensity,
    Shutter,
    ColorMixer,
    ColorWheel,
    Pan,
    Tilt,
    Focus,
    Zoom,
    Prism,
    Iris,
    Frost,
    Gobo,
    Generic(String),
}

impl ToString for FixtureControl {
    fn to_string(&self) -> String {
        match self {
            Self::Intensity => "Intensity".into(),
            Self::Shutter => "Shutter".into(),
            Self::ColorMixer => "ColorMixer".into(),
            Self::ColorWheel => "ColorWheel".into(),
            Self::Pan => "Pan".into(),
            Self::Tilt => "Tilt".into(),
            Self::Focus => "Focus".into(),
            Self::Zoom => "Zoom".into(),
            Self::Prism => "Prism".into(),
            Self::Iris => "Iris".into(),
            Self::Frost => "Frost".into(),
            Self::Gobo => "Gobo".into(),
            Self::Generic(control) => control.clone(),
        }
    }
}

impl From<&str> for FixtureControl {
    fn from(s: &str) -> Self {
        match s {
            "Intensity" => Self::Intensity,
            "Shutter" => Self::Shutter,
            "ColorMixer" => Self::ColorMixer,
            "ColorWheel" => Self::ColorWheel,
            "Pan" => Self::Pan,
            "Tilt" => Self::Tilt,
            "Focus" => Self::Focus,
            "Zoom" => Self::Zoom,
            "Prism" => Self::Prism,
            "Iris" => Self::Iris,
            "Frost" => Self::Frost,
            "Gobo" => Self::Gobo,
            control => Self::Generic(control.into()),
        }
    }
}

impl From<String> for FixtureControl {
    fn from(s: String) -> Self {
        s.as_str().into()
    }
}

impl FromStr for FixtureControl {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Ok(s.into())
    }
}

impl TryFrom<FixtureControl> for FixtureFaderControl {
    type Error = ();

    fn try_from(value: FixtureControl) -> Result<Self, Self::Error> {
        match value {
            FixtureControl::Intensity => Ok(Self::Intensity),
            FixtureControl::Shutter => Ok(Self::Shutter),
            FixtureControl::ColorMixer => Err(()),
            FixtureControl::ColorWheel => Ok(Self::ColorWheel),
            FixtureControl::Pan => Ok(Self::Pan),
            FixtureControl::Tilt => Ok(Self::Tilt),
            FixtureControl::Focus => Ok(Self::Focus),
            FixtureControl::Zoom => Ok(Self::Zoom),
            FixtureControl::Prism => Ok(Self::Prism),
            FixtureControl::Iris => Ok(Self::Iris),
            FixtureControl::Frost => Ok(Self::Frost),
            FixtureControl::Gobo => Ok(Self::Gobo),
            FixtureControl::Generic(name) => Ok(Self::Generic(name)),
        }
    }
}

/// Describes a single fader value
#[derive(Debug, Clone, PartialEq, Eq, Ord, PartialOrd, Hash, Deserialize, Serialize)]
pub enum FixtureFaderControl {
    Intensity,
    Shutter,
    ColorMixer(ColorChannel),
    ColorWheel,
    Pan,
    Tilt,
    Focus,
    Zoom,
    Prism,
    Iris,
    Frost,
    Gobo,
    Generic(String),
}

impl FixtureControl {
    pub fn faders(self) -> Vec<FixtureFaderControl> {
        use FixtureControl::*;
        match self {
            Intensity => vec![FixtureFaderControl::Intensity],
            Shutter => vec![FixtureFaderControl::Shutter],
            ColorMixer => vec![
                FixtureFaderControl::ColorMixer(ColorChannel::Red),
                FixtureFaderControl::ColorMixer(ColorChannel::Green),
                FixtureFaderControl::ColorMixer(ColorChannel::Blue),
            ],
            ColorWheel => vec![FixtureFaderControl::ColorWheel],
            Pan => vec![FixtureFaderControl::Pan],
            Tilt => vec![FixtureFaderControl::Tilt],
            Focus => vec![FixtureFaderControl::Focus],
            Zoom => vec![FixtureFaderControl::Zoom],
            Prism => vec![FixtureFaderControl::Prism],
            Iris => vec![FixtureFaderControl::Iris],
            Frost => vec![FixtureFaderControl::Frost],
            Gobo => vec![FixtureFaderControl::Gobo],
            Generic(generic) => vec![FixtureFaderControl::Generic(generic)],
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Ord, PartialOrd, Hash, Deserialize, Serialize)]
pub enum ColorChannel {
    Red,
    Green,
    Blue,
}

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub enum FixtureControlValue {
    Intensity(f64),
    Shutter(f64),
    ColorMixer(f64, f64, f64),
    ColorWheel(f64),
    Pan(f64),
    Tilt(f64),
    Focus(f64),
    Zoom(f64),
    Prism(f64),
    Iris(f64),
    Frost(f64),
    Gobo(f64),
    Generic(String, f64),
}

impl Hash for FixtureControlValue {
    fn hash<H: Hasher>(&self, state: &mut H) {
        match self {
            Self::Intensity(value) => {
                state.write_u8(0);
                value.to_bits().hash(state);
            }
            Self::Shutter(value) => {
                state.write_u8(1);
                value.to_bits().hash(state);
            }
            Self::ColorMixer(r, g, b) => {
                state.write_u8(2);
                r.to_bits().hash(state);
                g.to_bits().hash(state);
                b.to_bits().hash(state);
            }
            Self::ColorWheel(value) => {
                state.write_u8(3);
                value.to_bits().hash(state);
            }
            Self::Pan(value) => {
                state.write_u8(4);
                value.to_bits().hash(state);
            }
            Self::Tilt(value) => {
                state.write_u8(5);
                value.to_bits().hash(state);
            }
            Self::Focus(value) => {
                state.write_u8(6);
                value.to_bits().hash(state);
            }
            Self::Zoom(value) => {
                state.write_u8(7);
                value.to_bits().hash(state);
            }
            Self::Prism(value) => {
                state.write_u8(8);
                value.to_bits().hash(state);
            }
            Self::Iris(value) => {
                state.write_u8(9);
                value.to_bits().hash(state);
            }
            Self::Frost(value) => {
                state.write_u8(10);
                value.to_bits().hash(state);
            }
            Self::Gobo(value) => {
                state.write_u8(11);
                value.to_bits().hash(state);
            }
            Self::Generic(name, value) => {
                state.write_u8(12);
                name.hash(state);
                value.to_bits().hash(state);
            }
        }
    }
}

impl From<FixtureControlValue> for FixtureControl {
    fn from(value: FixtureControlValue) -> Self {
        use FixtureControlValue::*;
        match value {
            Intensity(_) => Self::Intensity,
            Shutter(_) => Self::Shutter,
            ColorMixer(_, _, _) => Self::ColorMixer,
            ColorWheel(_) => Self::ColorWheel,
            Pan(_) => Self::Pan,
            Tilt(_) => Self::Tilt,
            Focus(_) => Self::Focus,
            Zoom(_) => Self::Zoom,
            Prism(_) => Self::Prism,
            Iris(_) => Self::Iris,
            Frost(_) => Self::Frost,
            Gobo(_) => Self::Gobo,
            Generic(channel, _) => Self::Generic(channel),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
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

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ChannelResolution {
    /// 8 Bit
    ///
    /// coarse
    Coarse(u16),
    /// 16 Bit
    ///
    /// coarse, fine
    Fine(u16, u16),
    /// 24 Bit
    ///
    /// coarse, fine, finest
    Finest(u16, u16, u16),
}

#[derive(Debug, Clone, Copy, PartialEq, Default)]
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
