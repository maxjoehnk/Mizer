use serde::{Deserialize, Serialize};
use std::convert::TryFrom;
use std::str::FromStr;

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
        self.controls.color.clone()
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureControls<TChannel> {
    pub intensity: Option<TChannel>,
    pub shutter: Option<TChannel>,
    pub color: Option<ColorGroup<TChannel>>,
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
            color: None,
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

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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
        if self.color.is_some() {
            controls.push((FixtureControl::Color, FixtureControlType::Color));
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

#[derive(Debug, Clone, PartialEq)]
pub enum FixtureControlChannel {
    /// Fixture control maps to one dmx channel
    Channel(String),
    /// Delegate this channel to sub fixtures
    Delegate,
}

impl FixtureControlChannel {
    fn into_channel(self) -> Option<String> {
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

#[derive(Clone, PartialEq)]
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

#[derive(Debug, Clone, PartialEq)]
pub struct GenericControl<TChannel> {
    pub label: String,
    pub channel: TChannel,
}

/// Describes a single fixture control
///
/// This may have multiple fader values
#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum FixtureControl {
    Intensity,
    Shutter,
    Color,
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
            Self::Color => "Color".into(),
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
            "Color" => Self::Color,
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
            FixtureControl::Color => Err(()),
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
#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum FixtureFaderControl {
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
    Gobo,
    Generic(String),
}

impl FixtureControl {
    pub fn faders(self) -> Vec<FixtureFaderControl> {
        use FixtureControl::*;
        match self {
            Intensity => vec![FixtureFaderControl::Intensity],
            Shutter => vec![FixtureFaderControl::Shutter],
            Color => vec![
                FixtureFaderControl::Color(ColorChannel::Red),
                FixtureFaderControl::Color(ColorChannel::Green),
                FixtureFaderControl::Color(ColorChannel::Blue),
            ],
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

#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
pub enum ColorChannel {
    Red,
    Green,
    Blue,
}

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub enum FixtureControlValue {
    Intensity(f64),
    Shutter(f64),
    Color(f64, f64, f64),
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

impl From<FixtureControlValue> for FixtureControl {
    fn from(value: FixtureControlValue) -> Self {
        use FixtureControlValue::*;
        match value {
            Intensity(_) => Self::Intensity,
            Shutter(_) => Self::Shutter,
            Color(_, _, _) => Self::Color,
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
